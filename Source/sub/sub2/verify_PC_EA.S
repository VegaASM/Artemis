/*What this func does...
This func will attempt to change the EA to a valid PA.
As long as PA is valid, func will return 0
If not, func returns an Exception Function to call in x18 with optional arg in w2
*/

/*w0 = EA (PC*/
/*w0 returns instruction*/
/*w0 = 0 if no good, x1 = exception to call, w2 = exception arg*/

.globl verify_PC_EA
verify_PC_EA:
stp fp, lr, [sp, -0x30]!
stp x19, x20, [sp, 0x10]
str x21, [sp, 0x20]
mov fp, sp

/*Get PC's EA, save it*/
ldr x1, [x27, regbank_ptr]
ldr w0, [x1, pc]
mov w19, w0

/*Check MSR for Instruction Address Translation*/
ldr x1, [x27, regbank_ptr]
ldr w2, [x1, msr]
tst w2, msr_ir
mov w20, 1 /*Force I bit high*/
beq verify_physical_instruction_ea
mov w20, 0

/*Check if secondary bats are enabled*/
/*Use sbe bit to shift base value of 4 (loop count aka number of ibats)*/
ldr w2, [x1, hid4]
mov w18, 4
ubfx w2, w2, 25, 1
lsl w18, w18, w2

/*Check all qualified IBats*/
add x17, x1, ibat0u

mov w0, w19
ldr x1, [x17], 8
bl check_bats /*x1 returns BAT*/
cbnz w0, check_ibat_wg
subs w18, w18, 1
bne -0x14

/*EA array miss*/
mov w2, 0x40000000
b raise_isi_for_ibat

/*Check for W or G bits being high*/
check_ibat_wg:
mov x21, x1 /*Save BAT first*/
tst x1, bat_wimg_w || bat_wimg_g
bne undefined_ibat

/*Check BAT's PP bits*/
/*Anything not 00 is good to go for instruction fetching*/
tbz x1, 0x3, ibat_pp_denied //NOTE todo remember to implement srr1 bit 4 stuff

/*Change virt EA to phys EA*/
bl bat_va_to_pa

/*Check Physical Range, if NOT then raise MCE, if no MCE, raise checkstop*/
verify_physical_instruction_ea:
bl verify_physical_ea
tbz w0, 1, BAD_phys_instruction_ea

/*TODO put in code for Page Tables.... lol*/

mov w0, 0

process_PC_EA_epilogue:
ldr x21, [sp, 0x20]
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x30
ret

/*ISI occurs when G is high. However for W high, its "undefined behavior". We can't emulate that, so just throw an ISI for W bit as well*/
undefined_ibat:
mov w2, 0x10000000
b raise_isi_for_ibat

ibat_pp_denied:
mov w2, 0x08000000
/*Bat Array Miss or PP violation*/
/*Raise ISI*/
raise_isi_for_ibat:
adrp x18, isi_exception_vector
add x18, x18, :lo12: isi_exception_vector
b process_PC_EA_epilogue

BAD_phys_instruction_ea:
mov w2, 0

/*Bad physical instruction EA*/
bad_physical_instruction_ea:
adrp x18, machine_check_exception_vector
add x18, x18, :lo12: machine_check_exception_vector
b process_PC_EA_epilogue

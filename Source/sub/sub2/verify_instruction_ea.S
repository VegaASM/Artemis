/*w0 = EA*/
/*return values
w0 = 0 = good EA
w0 = exception routine address to call&link if bad EA*/

.globl verify_instruction_ea
verify_instruction_ea:
stp fp, lr, [sp, -0x20]!
str x19, [sp, 0x10]
mov fp, sp

/*Backup arg*/
mov w19, w0

/*Check MSR for Instruction Address Translation*/
ldr x1, [x27, regbank_ptr]
ldr w2, [x1, msr]
tst w2, msr_ir
beq verify_physical_instruction_ea

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
bl check_bats
cbnz w0, check_ibat_wg
subs w18, w18, 1
bne -0x14

/*Bat Array Miss or PP violation*/
/*Raise ISI*/
raise_isi_for_ibat:
adrp x0, isi_exception_vector
add x0, x0, :lo12: isi_exception_vector
b verify_instruction_ea_epilogue

/*Check for W or G bits being high*/
check_ibat_wg:
tst x1, bat_wimg_w || bat_wimg_g
beq 0x10

/*Hardware in this case does undefined behavior...
for Artemis, we'll do a MCE with a force-no-matter-what checkstop*/
mov w0, 1
strb w0, [x27, checkstop_flag]
b bad_physical_instruction_ea

/*Check BAT's PP bits*/
/*Anything not 00 is good to go for instruction fetching*/
tbz x1, 0x3, raise_isi_for_ibat //NOTE todo remember to implement srr1 bit 4 stuff

/*Change virt EA to phys EA*/
bl bat_va_to_pa

/*Check Physical Range, if NOT then raise MCE, if no MCE, raise checkstop*/
verify_physical_instruction_ea:
bl verify_physical_ea
tbnz w0, 1, good_instruction_ea

/*Bad physical instruction EA*/
bad_physical_instruction_ea:
adrp x0, machine_check_exception_vector
add x0, x0, :lo12: machine_check_exception_vector
b verify_instruction_ea_epilogue

good_instruction_ea:
mov w0, 0

verify_instruction_ea_epilogue:
ldr x19, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

/*TODO put in code for segment register / page tables check... great...*/

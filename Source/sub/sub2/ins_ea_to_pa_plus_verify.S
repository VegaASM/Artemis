/*w0 = PA, x1 = reg bank ptr
w0 return 0 if zero, -1 if not*/

.globl ins_ea_to_pa_plus_verify
ins_ea_to_pa_plus_verify:
stp fp, lr, [sp, -0x20]!
str x19, [sp, 0x10]
mov fp, sp

/*Backup EA, save it*/
mov w19, w0

/*Check MSR for Instruction Address Translation*/
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
bl check_bats /*x1 returns BAT*/
cbnz w0, check_ibat_wg
subs w18, w18, 1
bne -0x14

/*EA array miss*/
mov w1, 0x40000000
b raise_isi_for_ibat

/*Check for W or G bits being high*/
check_ibat_wg:
tst x1, bat_wimg_w || bat_wimg_g
bne undefined_ibat

/*Check BAT's PP bits*/
/*Anything not 00 is good to go for instruction fetching*/
tbz x1, 0x3, ibat_pp_denied

/*Change virt EA to phys EA*/
str x1, [x27, batsave_ptr] /*Need this for other funcs later, hacky*/
bl bat_va_to_pa

/*Check Physical Range, if NOT then raise MCE, if no MCE, raise checkstop*/
verify_physical_instruction_ea:
bl verify_physical_ea
tbz w0, 1, BAD_phys_instruction_ea

/*TODO put in code for Page Tables.... lol*/

mov w0, 1 /*All good*/

ins_ea_to_pa_plus_verify_epi:
ldr x19, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

/*ISI occurs when G is high. However for W high, its "undefined behavior". We can't emulate that, so just throw an ISI for W bit as well*/
undefined_ibat:
mov w1, 0x10000000
b raise_isi_for_ibat

ibat_pp_denied:
mov w1, 0x08000000
/*Bat Array Miss or PP violation*/
/*Raise ISI*/
raise_isi_for_ibat:
adrp x18, isi_exception_vector
add x18, x18, :lo12: isi_exception_vector
mov w0, 0
b ins_ea_to_pa_plus_verify_epi

/*Bad physical instruction EA*/
BAD_phys_instruction_ea:
mov w1, 0
adrp x18, machine_check_exception_vector
add x18, x18, :lo12: machine_check_exception_vector
mov w0, 0
b ins_ea_to_pa_plus_verify_epi

/*w0 = PA, x1 = reg bank ptr
w0 return 0 if zero, -1 if not*/

.globl data_ea_to_pa_plus_verify
data_ea_to_pa_plus_verify:
stp fp, lr, [sp, -0x20]!
str x19, [sp, 0x10]
mov fp, sp

/*Backup arg*/
mov w19, w0

/*Check MSR for Data Address Translation*/
ldr w2, [x1, msr]
tst w2, msr_dr
beq verify_physical_data_ea

/*Check if secondary bats are enabled*/
/*Use sbe bit to shift base value of 4 (loop count aka number of ibats)*/
ldr w2, [x1, hid4]
mov w18, 4
ubfx w2, w2, 25, 1
lsl w18, w18, w2

/*Check all qualified DBats*/
add x17, x1, dbat0u

dbat_check_loop:
mov w0, w19
ldr x1, [x17], 8
bl check_bats
cbnz w0, check_dbat_pp /*x1 returns BAT; fyi this func does not stack push*/
subs w18, w18, 1
bne dbat_check_loop

/*EA array miss*/
mov w1, 0x40000000
b raise_dsi_for_dbat

check_dbat_pp:
/*Check BAT's PP bits*/
/*x1 = read only, 10 = read/write*/
/*TODO we have to implement something for dcbt/dcbtst instruction, simply abort access (nop)*/
tst x1, 0x3
beq dbat_pp_denied /*NOTE todo remember to implement dsisr bit stuff that's unique for PP violation*/
tbz x1, 1, change_dva_to_dpa

/*PP only allows reads (load instructions), check load_flag, if low, then it's PP violation*/
ldrb w2, [x27, touch_flag]
cbnz w2, change_dva_to_dpa //simply abort access due to dcbt/dcbtst; TODO
ldrb w2, [x27, load_flag]
cbz w2, dbat_pp_denied

/*Change virt EA to phys EA
w0 = EA
x1 = BAT
args already set*/
change_dva_to_dpa:
str x1, [x27, batsave_ptr] /*Need this for other funcs later, hacky*/
bl bat_va_to_pa

/*Check Physical Range, if NOT then raise MCE, if no MCE, raise checkstop*/
verify_physical_data_ea:
bl verify_physical_ea
cbz w0, bad_physical_instruction_dea /*0 is for error for Parent func, so we can directly return!*/

/*TODO put in code for Page Tables.... lol*/

data_ea_to_pa_plus_verify_epi:
ldr x19, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

dbat_pp_denied:
mov w1, 0x08000000
/*Bat Array Miss or PP violation*/
/*Raise DSI*/
raise_dsi_for_dbat:
adrp x18, dsi_exception_vector
add x18, x18, :lo12: dsi_exception_vector
mov w0, 0
b data_ea_to_pa_plus_verify_epi

/*Bad physical instruction data EA*/
bad_physical_instruction_dea:
mov w1, 0
adrp x18, machine_check_exception_vector
add x18, x18, :lo12: machine_check_exception_vector
mov w0, 0
b data_ea_to_pa_plus_verify_epi

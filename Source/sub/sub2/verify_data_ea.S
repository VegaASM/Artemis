/*w0 = EA*/
/*return values
x1 = 0 if good EA; ignore w0 return value
x1 = exception routine address to call&link if bad EA, with w0 being the arg for to-be function to call*/

.globl verify_data_ea
verify_data_ea:
stp fp, lr, [sp, -0x20]!
str x19, [sp, 0x10]
mov fp, sp

/*Backup arg*/
mov w19, w0

/*Check MSR for Data Address Translation*/
ldr x1, [x27, regbank_ptr]
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

mov w0, w19
ldr x1, [x17], 8
bl check_bats
cbnz w0, check_dbat_pp
subs w18, w18, 1
bne -0x14

/*Bat Array Miss or PP violation*/
/*Raise DSI*/
raise_dsi_for_dbat:
adrp x18, dsi_exception_vector
add x18, x18, :lo12: dsi_exception_vector
b verify_data_ea_epilogue

check_dbat_pp:
/*Check BAT's PP bits*/
/*x1 = read only, 10 = read/write*/
//TODO for dcbt/dcbtst instruction, simply abort access (nop)
tbnz x1, 0x3, raise_dsi_for_dbat //NOTE todo remember to implement dsisr bit stuff that's unique for PP violation
tbz x1, 0x2, data_pp_read_and_write

/*PP only allows reads (load instructions), check load_flag, if low, then it's PP violation*/
ldrb w2, [x27, touch_flag]
tbnz w2, 1, good_data_ea //simply abort access due to dcbt/dcbtst
ldrb w2, [x27, load_flag]
tbnz w2, 1, raise_dsi_for_dbat

//Change virt EA to phys EA
data_pp_read_and_write:
bl bat_va_to_pa

/*Check Physical Range, if NOT then raise MCE, if no MCE, raise checkstop*/
verify_physical_data_ea:
bl verify_physical_ea
tbnz w0, 1, good_data_ea

/*Bad physical data EA*/
bad_physical_data_ea:
adrp x18, machine_check_exception_vector
add x18, x18, :lo12: machine_check_exception_vector
b verify_data_ea_epilogue

good_data_ea:
mov w1, 0

verify_data_ea_epilogue:
ldr x19, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

/*TODO put in code for segment register / page tables check... great...*/

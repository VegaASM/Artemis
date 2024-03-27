
/*w0 = EA*/
/*return values
w0 = 0 = good EA
w0 = exception routine address to call&link if bad EA*/
.globl verify_data_ea
verify_data_ea:
stp fp, lr, [sp, -0x20]!
str x19, [sp, 0x10]
mov fp, sp

/*Backup arg*/
mov w19, w0

/*Check MSR for Data Address Translation*/
ldr x1, [x27, 0x20] //reg bank ptr
ldr w2, [x1, msr]
tst w2, msr_dr
beq verify_physical_data_ea

/*Check if secondary bats are enabled*/
ldr w2, [x1, hid4]
tst w2, sbe_hid4
beq 0xC

/*Set loop count of 8*/
mov w18, 8
b 0x8

/*set loop count of 4*/
mov w18, 4

/*Check all qualified DBats*/
add x17, x1, dbat0

mov w0, w19
ldr x1, [x17], 8
bl check_bats
cbz w0, good_data_ea
subs w18, w18, 1
bne -0x14

/*TODO put in code for segment register / page tables check... crap....*/

/*Virtual EA is bad*/
adrp x0, dsi_exception_vector
add x0, x0, :lo12: dsi_exception_vector
b verify_data_ea_epilogue

good_data_ea:
mov w0, 0

/*Done with verification*/
verify_data_ea_epilogue:
ldr x19, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

verify_physical_data_ea:
cmp w0, 0
blo bad_physical_data_ea
movz w2, 0x13FF, lsl 16
movk w2, 0xFFFF
cmp w0, w2
bhi bad_physical_data_ea
mov w2, 0x10000000
cmp w0, w2
bhi good_data_ea
movz w2, 0x017F, lsl 16
movk w2, 0xFFFF
cmp w0, w2
bls good_data_ea

/*Bad physical data EA*/
bad_physical_data_ea:
adrp x0, machine_check_exception_vector
add x0, x0, :lo12: machine_check_exception_vector
b verify_data_ea_epilogue

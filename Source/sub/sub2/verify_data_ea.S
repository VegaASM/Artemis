/*w0 = EA*/
/*return values
x0 = Real Mem Addr converted from EA
x0 = 0 (Error) if no such EA NOTE make sure parent checks ENTIRE gpr
if x0 = 0 then..
x18 = Exception func to call
w1+ = Exception func args
NOTE do something for dcbt, dcbtst, w2 return flag????
*/

.globl verify_data_ea
verify_data_ea:
stp fp, lr, [sp, -0x30]!
stp x19, x20, [sp, 0x10]
str x21, [sp, 0x20]
mov fp, sp

/*Backup arg*/
mov w19, w0

/*Check MSR for Data Address Translation*/
ldr x1, [x27, regbank_ptr]
ldr w2, [x1, msr]
tst w2, msr_dr
mov w20, 1 /*Force I bit BAT reading high*/
beq verify_physical_data_ea
mov w20, 0

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
//TODO we have to implement something for dcbt/dcbtst instruction, simply abort access (nop)
tbnz x1, 0x3, dbat_pp_denied //NOTE todo remember to implement dsisr bit stuff that's unique for PP violation
tbz x1, 0x2, change_dva_to_dpa

/*PP only allows reads (load instructions), check load_flag, if low, then it's PP violation*/
ldrb w2, [x27, touch_flag]
tbnz w2, 1, change_dva_to_dpa //simply abort access due to dcbt/dcbtst; TODO
ldrb w2, [x27, load_flag]
tbnz w2, 1, dbat_pp_denied

/*Change virt EA to phys EA*/
change_dva_to_dpa:
mov x21, x1 /*Backup BAT*/
bl bat_va_to_pa

/*Check Physical Range, if NOT then raise MCE, if no MCE, raise checkstop*/
verify_physical_data_ea:
bl verify_physical_ea
tbz w0, 1, bad_physical_instruction_dea /*0 is for error for Parent func, so we can directly return!*/

/*Change PA to PA-32*/
and w2, w0, 0x0000001F

/*Check real mode flag*/
cbnz w20, 0xC

/*Is IBAT I high?*/
tst x21, bat_wimg_i
beq physical_dfetch

/*Is HID0 DCE low? aka is L1 D-Cache on/off*/
ldr x3, [x27, regbank_ptr]
ldr w3, [x3, hid0]
tst w3, hid0_dce
beq check_l2_on

/*Check L1 data cache*/
ldr x3, [x27, L1_data_ptr]
mov w4, DCache_word_size /*TODO fix me*/
L1_data_cache_check:
ldr w5, [x3], 12 /*Get PA-32 from Cache*/
and w6, w5, 0xFFFFFFE0 /*Remove TMEI bits*/
cmp w6, w2
bne 0xC
tst w5, TMEI_I
beq in_dcache
subs w4, w4, 1
bne L1_data_cache_check

/*Is L2 on?*/
check_l2_on:
ldr x3, [x27, regbank_ptr]
ldr w3, [x3, l2cr]
tst w3, l2cr_l2e
beq physical_dfetch

/*Check L2 cache*/
ldr x3, [x27, L2_ptr]
mov w4, L2Cache_word_size /*TODO fix me*/
L2_dcache_check:
ldr w5, [x3], 12 /*Get PA-32 from Cache*/
and w6, w5, 0xFFFFFFE0 /*Remove TMEI bits*/
cmp w6, w2
bne 0x14
tst w5, TMEI_T /*T = 1 for ins-type, 0 for data*/
bne 0xC
tst w5, TMEI_I
beq in_dcache
subs w4, w4, 1
bne L2_dcache_check

/*TODO put in code for Page Tables.... lol*/

/*Not in any Cache, fetch instruction from physical memory*/
physical_dfetch:
/*Get PA's real Mem Addr*/
/*PA already in w0*/
bl convert /*x0 returns real addr*/
b verify_Data_EA_epilogue

in_dcache:
/*Grab Cache PA-32's Real Memory Address*/
ldr x3, [x3, -0x8]
/*Get offset amount from PA non-32*/
and w0, w0, 0x0000001F
/*Using offset, complete the rest of the REAL mem address*/
add x0, x3, x0

verify_Data_EA_epilogue:
ldr x21, [sp, 0x20]
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x30
ret

dbat_pp_denied:
mov w1, 0x08000000
/*Bat Array Miss or PP violation*/
/*Raise DSI*/
raise_dsi_for_dbat:
adrp x18, dsi_exception_vector
add x18, x18, :lo12: dsi_exception_vector
mov w0, 0
b verify_Data_EA_epilogue

/*Bad physical instruction data EA*/
bad_physical_instruction_dea:
mov w1, 0
adrp x18, machine_check_exception_vector
add x18, x18, :lo12: machine_check_exception_vector
mov w0, 0
b verify_Data_EA_epilogue

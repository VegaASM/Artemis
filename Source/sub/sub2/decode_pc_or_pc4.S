/*Cache layout
PA-32 (with TMEI); Real-Mem-Addr
T bit is type bit, its ARtemis unique. T = 1 for ins type.
*/

/*What this func does...
It acts as an instruction fetcher, but its for returning the Real Mem address so the Parent func can grab the instruction to then call the Disassembler.
No actual instruction execution occurs.
*/

/*w0 = PC or PC+4*/
/*x0 returns Real address to instruction*/
/*x0 returns zero if no such Real address can be found (memory doesn't exist)*/

.globl decode_pc_or_pc4
decode_pc_or_pc4:
stp fp, lr, [sp, -0x30]!
stp x19, x20, [sp, 0x10]
str x21, [sp, 0x20]
mov fp, sp

/*Backup arg*/
mov w19, w0

/*Check MSR for Instruction Address Translation*/
ldr x1, [x27, regbank_ptr]
ldr w2, [x1, msr]
tst w2, msr_ir
mov w20, 1 /*Force I bit BAT reading high*/
beq verify_physical_ins_ea
mov w20, 0

/*Check if secondary bats are enabled*/
/*Use sbe bit to shift base value of 4 (loop count aka number of ibats)*/
ldr w2, [x1, hid4]
mov w18, 4
ubfx w2, w2, 25, 1
lsl w18, w18, w2

/*Check all qualified IBats*/
add x17, x1, ibat0u

ibat_check_loop:
mov w0, w19
ldr x1, [x17], 8
bl check_bats /*x1 returns BAT; fyi this func does not stack push*/
cbnz w0, 0x14
subs w18, w18, 1
bne ibat_check_loop

mov w0, 0 /*Error, memory doesn't exist*/
b process_pc_pc4_epilogue

/*Change virt EA to phys EA*/
mov x21, x1 /*backup BAT*/
str x1, [x27, batsave_ptr] /*Also need to backup to array, a way later function needs this value*/
bl bat_va_to_pa

/*Check Physical Range, if NOT then raise MCE, if no MCE, raise checkstop*/
verify_physical_ins_ea:
bl verify_physical_ea
tbz w0, 1, process_pc_pc4_epilogue /*0 is for error for Parent func, so we can directly return!*/

/*Change PA to PA-32*/
and w2, w0, 0x0000001F

/*Check real mode flag*/
cbnz w20, 0xC

/*Is IBAT I high?*/
tst x21, bat_wimg_i
beq physical_fetch

/*Is HID0 ICE low? aka is L1 I-Cache on/off*/
ldr x3, [x27, regbank_ptr]
ldr w3, [x3, hid0]
tst w3, hid0_ice
beq is_l2_on

/*Check L1 ins cache*/
ldr x3, [x27, L1_ins_entries_ptr]
mov w4, L1_ins_number_entries
L1_ins_cache_check:
ldr w5, [x3], 12 /*Get PA-32 from Cache*/
and w6, w5, 0xFFFFFFE0 /*Remove TMEI bits*/
cmp w6, w2
bne 0xC
tst w5, LTMEI_I
beq in_cache
subs w4, w4, 1
bne L1_ins_cache_check

/*Is L2 on?*/
is_l2_on:
ldr x3, [x27, regbank_ptr]
ldr w3, [x3, l2cr]
tst w3, l2cr_l2e
beq physical_fetch
/*L2 is on, but is it set to Data-only?*/
tst w3, l2cr_l2do
bne physical_fetch

/*Check L2 cache*/
ldr x3, [x27, L2_data_entries_ptr]
mov w4, L2_ins_number_entries
L2_cache_check:
ldr w5, [x3], 12 /*Get PA-32 from Cache*/
and w6, w5, 0xFFFFFFE0 /*Remove TMEI bits*/
cmp w6, w2
bne 0x14
tst w5, LTMEI_T /*T = 1 for ins-type, 0 for data*/
beq 0xC
tst w5, LTMEI_I
beq in_cache
subs w4, w4, 1
bne L2_cache_check

/*TODO put in code for Page Tables.... lol*/

/*Not in any Cache, fetch instruction from physical memory*/
physical_fetch:
/*Get PA's real Mem Addr*/
/*PA already in w0*/
bl convert /*x0 returns real addr*/
b process_pc_pc4_epilogue

in_cache:
/*Grab Cache PA-32's Real Memory Address*/
ldr x3, [x3, -0x8]
/*Get offset amount from PA non-32*/
and w0, w0, 0x0000001F
/*Using offset, complete the rest of the REAL mem address*/
add x0, x3, x0

process_pc_pc4_epilogue:
ldr x21, [sp, 0x20]
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x30
ret

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
mov w20, 1 /*Force I bit BAT reading high*/
tbz w2, msr_ir_b, verify_physical_ins_ea
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
cbz w0, process_pc_pc4_epilogue /*0 is for error for Parent func, so we can directly return!*/

/*Change PA to PA-32*/
and w2, w0, 0xFFFFFFE0

/*Check real mode flag*/
cbnz w20, 0x8

/*Is IBAT I high?*/
tbnz x21, bat_wimg_i_b, physical_fetch

/*Is HID0 ICE low? aka is L1 I-Cache on/off*/
ldr x3, [x27, regbank_ptr]
ldr w3, [x3, hid0]
tbz w3, hid0_ice_b, is_l2_on

/*Check L1 ICache*/
ldr x3, [x27, L1_ICache_ptr]
mov w4, L1_ICache_entries
L1_ins_cache_check:
ldr w5, [x3], L1_way_size /*Get PA-32 from Cache*/
and w6, w5, 0xFFFFFFE0 /*Remove LMEI bits*/
cmp w6, w2
bne 0x8
tbz w5, LMEI_I_b, in_cache
subs w4, w4, 1
bne L1_ins_cache_check

/*Is L2 on, and is L2DO set low?*/
is_l2_on:
ldr x3, [x27, regbank_ptr]
ldr w3, [x3, l2cr]
tbz w3, l2cr_l2e_b, physical_fetch
tbnz w3, l2cr_l2do_b, physical_fetch

/*Check L2 cache*/
ldr x3, [x27, L2_ICache_ptr]
movz w4, :abs_g0_nc: L2_ICache_size
L2_cache_check:
ldr w5, [x3], L2_block_size /*Get PA-32 from Cache*/
and w6, w5, 0xFFFFFFE0 /*Remove LMEI bits*/
cmp w6, w2
bne 0x8
tbz w5, LMEI_I_b, in_cache /*If invalid high, we don't grab from cache, we grab from physical*/
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
/*Move real mem addr ptr to start of actual cache block*/
sub x3, x3, 32
/*Get offset amount from PA non-32*/
bfc w0, 0, 5
/*Using offset, complete the rest of the REAL mem address*/
add x0, x3, x0

process_pc_pc4_epilogue:
ldr x21, [sp, 0x20]
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x30
ret

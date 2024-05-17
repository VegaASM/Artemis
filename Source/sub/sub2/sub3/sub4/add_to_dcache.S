/*w0 = PA
NOTE return values present but unused
NOTE this func is currently unused*/

.globl add_to_dcache
add_to_dcache:
/*Prologue*/
stp fp, lr, [sp, -0x20]!
str x19, [sp, 0x10]
mov fp, lr

/*Save Arg*/
mov w19, w0

/*Is L1 DCache enabled?*/
ldr x17, [x27, regbank_ptr]
ldr w18, [x17, hid0]
tst w18, hid0_dce
beq __add_to_dcache_L2check

/*Get Base PTR of L1 DCache aka set0+way0 ptr*/
ldr x1, [x27, L1_DCache_ptr]

/*Set a GPR to Cache Set Size*/
movz w2, L1_set_size

/*Get Set Number from PA big endian bits 20 thru 26*/
ubfx w3, w0, 5, 7

/*Artemis uses custom set sizes due to custom way sizes
Each way is 37 bytes (PA word, PLRU byte, Cache Block)
Thus each Set is 296 bytes instead of 256 bytes
Mulitply Set number by 296*/
umull x2, w2, w3

/*Set Way amount for upcoming loop. 8 ways are in a set*/
mov w5, 8

/*Now add that to Base PTR to get Set's way0 ptr*/
add x1, x1, x2

/*Save this ptr as there is one PLRU byte per Set*/
mov x6, x1

/*Now run thru the 8 ways. Use first one that's invalid & UNlocked
If all are valid or locked, do L2 searching. But if L2 is disabled, do L1 PLRU*/
ldr w4, [x1], L1_way_size
tbz w4, LMEI_I | LMEI_L, found_invalid_dway
subs w5, w5, 1
bne -0xC
b __add_to_dcache_L2check

/*Found a usable aka invalid Way
Change loop amount to become Way number*/
found_invalid_dway:
sub w5, w5, 8
neg w0, w5

/*The Way's PLRU bits must be reset
How the bits are reset depends on the Way number
Grab PLRU Mask Table ptr, then grab way's masks
There are two masks we need for each way*/
need_to_reset_dplru:
and w3, w19, 0xFFFFFFE0
add x1, x1, -(L1_way_size)
mov x2, x6
orr r3, r3, LMEI_M
bl reset_PLRU_and_update_cache_block

/*All done!*/
mov w0, 0
b add_to_dcache_eplilogue

/*Is l2 on?
If not, then go back to l1 cache and do PLRU to determine which to do.
if both l2 and l1 disabled, return back -1*/
__add_to_dcache_L2check:
ldr w2, [x17, l2cr]
tst w2, l2cr_l2e
beq do_plru_L1_DCache
/*Loop amount depends on L2DO bit*/
ubfx w2, w2, xx, 1
mov w3, L2_DCache_entries
lsl w2, w3, w2

/*Find first I block in L2 DCache*/
ldr x18, [x27, L2_DCache_ptr]

ldr w0, [x18], L2_block_size
tbnz w0, LMEI_I, found_in_L2_DCache
subs w2, w2, 1
bne -0xC

/*No I block found, so replace very first block of L2 TODO what to do here hmm...*/
ldr x18, [x27, L2_DCache_ptr]
prep_for_L2_Dblock_push:
and w0, w19, 0xFFFFFFE0
orr w0, w0, LMEI_M
str w0, [x18]
add x18, x18, 9
bl convert
mov w1, 8 /*L2 blocks have 8 double-words instead of usual 4 double-words*/
ldr x2, [x0], 8
str x2, [x18], 8
subs w1, w1, 1
bne -0xC

/*Done*/
mov w0, 0
b add_to_dcache_eplilogue

do_plru_L1_DCache:
tst w18, hid0_dce /*Just in case....*/
bne error_add_to_dcache
bl PLRU
b need_to_reset_dplru

found_in_L2_DCache:
sub x18, x18, L2_block_size
b prep_for_L2_Dblock_push

/*Both L1 and L2 are turned off, huh...*/
error_add_to_dcache:
mov w0, -1

add_to_dcache_eplilogue:
ldr x19, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

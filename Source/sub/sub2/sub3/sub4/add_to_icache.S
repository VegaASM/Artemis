/*
w0 = PA
x0 returns real mem OS addr or 0 for error
*/

.globl add_to_icache
add_to_icache:
/*Prologue*/
stp fp, lr, [sp, -0x20]!
str x19, [sp, 0x10]
mov fp, lr

/*Save Arg*/
mov w19, w0

/*Is L1 ICache enabled?*/
ldr x20, [x27, regbank_ptr]
ldr w21, [x17, hid0]
tbz w21, hid0_ice_b, __add_to_icache_L2check

/*Get Base PTR of L1 ICache aka set0+way0 ptr*/
ldr x1, [x27, L1_ICache_ptr]

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
mov x22, x1

/*Now run thru the 8 ways. Use first one that's invalid & UNlocked
If all are valid or locked, do L2 searching. But if L2 is disabled, do L1 PLRU*/
ldr w4, [x1], L1_way_size
tbnz w4, 0, found_invalid_iway /*Check LMEI_I bit*/
subs w5, w5, 1
bne -0xC
b __add_to_icache_L2check

/*Found a usable aka invalid Way
Change loop amount to become Way number*/
found_invalid_iway:
add x23, x1, -(L1_way_size) /*Save real mem OS addr*/
sub w5, w5, 8
neg w0, w5

/*The Set's PLRU bits must be reset
How the bits are reset depends on the Way number
Grab PLRU Mask Table ptr, then grab way's masks
There are two masks we need for each way*/
need_to_reset_iplru:
mov x1, x22
bl reset_PLRU

/*Now transfer from physical memory to l1 icache chip memory*/
and w0, w19, 0xFFFFFFE0
mov x1, x23
bl push_into_cache

/*All done!*/
i_all_done:
mov w0, 0
mov x1, x23
b add_to_icache_eplilogue

/*Is l2 on and l2do low?
If not, then go back to l1 cache and do PLRU to determine which to do.
if both l2 and l1 disabled, return back -1*/
__add_to_icache_L2check:
ldr w2, [x17, l2cr]
tbz w2, l2cr_l2e_b, do_plru_L1_ICache
tbnz w2, l2cr_l2do_b, do_plru_L1_ICache

/*Find first I block in L2 ICache*/
ldr x23, [x27, L2_ICache_ptr]
mov w2, L2_ICache_entries

ldr w0, [x23], L2_block_size
tbnz w0, 0, found_in_L2_ICache /*Check LMEI_I*/
subs w2, w2, 1
bne -0xC

/*No I block found, so replace very first block of L2 TODO what to do here hmm...*/
ldr x23, [x27, L2_ICache_ptr]
prep_for_L2_Iblock_push:
and w0, w19, 0xFFFFFFC0
mov x1, x23
bl push_into_l2cache
b i_all_done

do_plru_L1_ICache:
tbz w21, hid0_ice_b, error_add_to_icache /*Just in case....*/
/*w0 = PLRU byte, w0 returns way number*/
ldrb w0, [x22, 8]
bl PLRU
/*Update x23 now that we have way number*/
mov w1, 37
mul w0, w0, w1
add x23, x22, x0
b need_to_reset_iplru

found_in_L2_ICache:
sub x23, x23, L2_block_size
b prep_for_L2_Iblock_push

/*Both L1 and L2 are turned off, huh...*/
error_add_to_icache:
mov w0, 0

add_to_icache_eplilogue:
ldr x19, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//w0 = PA
.globl add_to_dcache
add_to_dcache:
//Prologue
stp fp, lr, [sp -0x20]!
str x19, [sp, 0x10]
mov fp, lr

//Is DCE high?
ldr x1, [x27, regbank_ptr]
ldr w2, [x1, hid0]
tst w2, hid0_dce
beq 0x20

//Search entire L1 DCache for any I's
mov w2, L1_data_number_entries
ldr x3, [x27, L1_data_entries_ptr]
ldr w4, [x3], cache_entry_width
tbnz w4, LTMEI_L, 0x8
tbnz w4, LTMEI_I, __add_to_dcache
subs w2, w2, 1
bne -0x10

//Is L2CR even on?
ldr w2, [x1, l2cr]
tst w2, l2cr_l2e
beq add_to_dcache_epilogue
//Set Loop Amount based on L2DO
ubfx w2, w2, 22, 1
mov w3, L2_data_number_entries /*Incurs no l2do*/
lsl w2, w3, w2

//Search applicable L2 DCache for Any I's
ldr x3, [x27, L2_data_entries_ptr]
ldr w4, [x3], cache_entry_width
tbnz w4, LTMEI_L, 0x8
tbnz w4, LTMEI_I, __add_to_dcache
subs w2, w2, 1
bne -0x10

//Below notes are all TODO
//No I's, do same shit over, but do E's
//L1
//L2
//No E's, do same shit for 1st M found
//L1
//L2

//Add it to entry list!
__add_to_dcache:
orr w0, w19, LTMEI_M
str w0, [x3, -(cache_entry_width)]!
//Add to the cache itself
mov w0, w19 //Get PA and convert to real mem addr
mov x19, x3
bl convert
ldr x1, [x17], 8 //Load from PPC main memory
str x1, [x0], 8 //Store to PPC DCache
subs w17, w17, 1
bne -0xC

//Done!
add_to_dcache_epilogue:
ldr x19, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

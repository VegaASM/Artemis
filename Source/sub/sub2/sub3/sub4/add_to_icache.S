//w0 = PA
.globl add_to_icache
add_to_icache:
//Prologue
stp fp, lr, [sp, -0x20]!
str x19, [sp, 0x10]
mov fp, lr

//Is ICE high?
ldr x1, [x27, regbank_ptr]
ldr w2, [x1, hid0]
tst w2, hid0_ice
beq 0x20

//Search entire L1 ICache for any I's
mov w2, L1_ins_number_entries
ldr x3, [x27, L1_ins_entries_ptr]
ldr w4, [x3], cache_entry_width
tbnz w4, LTMEI_L, 0x8
tbnz w4, LTMEI_I, __add_to_icache
subs w2, w2, 1
bne -0x10

//Is L2CR even on?
ldr w2, [x1, l2cr]
tst w2, l2cr_l2e
beq add_to_icache_epilogue
//Is L2DO set high?
tst w2, l2cr_l2do
beq add_to_icache_epilogue

//Search applicable L2 ICache for Any I's
mov w2, L2_ins_number_entries
ldr x3, [x27, L2_ins_entries_ptr]
ldr w4, [x3], cache_entry_width
tbnz w4, LTMEI_L, 0x8
tbnz w4, LTMEI_I, __add_to_icache
subs w2, w2, 1
bne -0x10

//Add it to entry list!
__add_to_icache:
str w19, [x3, -(cache_entry_width)]!
//Add to the cache itself
mov w0, w19 //Get PA and convert to real mem addr
mov x19, x3
bl convert
ldr x1, [x17], 8 //Load from PPC main memory
str x1, [x0], 8 //Store to PPC ICache
subs w17, w17, 1
bne -0xC

//Done!
add_to_icache_epilogue:
ldr x19, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//w0 = PA
//w1 = Hit/Miss
//w2 = Write/Read
.globl dcache_algo_update_no_snoops
dcache_algo_update_no_snoops:
/*Prologue*/
stp fp, lr, [sp, -0x10]!
mov fp, lr

//Change PA to PA-32
and w6, w0, 0xFFFFFFE0
//Set L1 DCache entry loop amount
mov w7, L1_data_number_entries
//Get L1 Dcache entry ptr
ldr x3, [x27, L1_data_entries_ptr]
//Compare PA to recently added PA, that PA doesn't get updated
ldr w4, [x3], cache_entry_width
and w5, w4, 0xFFFFFFE0
cmp w5, w6
beq -0x10

bl __dcache_algo_update_yes_snoops

//L1 DCache completed, now do L2
//Is L2 on?
ldr x4, [x27, regbank_ptr]
ldr w4, [x4, l2cr]
tst w4, l2cr_l2e
beq dcache_algo_update_yes_snoops_epilogue

//Set Loop Amount based on L2D0 bit
ubfx w4, w4, 22, 1
mov w5, L2_data_number_entries /*Incurs no l2do*/
lsl w7, w4, w5

bl __dcache_algo_update_yes_snoops

dcache_algo_update_yes_snoops_epilogue:
ldp fp, lr, [sp], 0x10
ret

__dcache_algo_update_yes_snoops:
//Is PA locked?
tbnz w4, LTMEI_L, -0x14

//Update MEI
//If Modified then..
//Snoop Hit on Cacheable Read/Write -> I
//Any other Snoop Hit -> E
//Miss or any other scenario -> M (nop)
tbz w4, LTMEI_M, 0x30
tbz w1, 1, __dcache_algo_update_yes_snoops_loop_decrementer
ldr x5 [x27, batsave_ptr]
tst x5, bat_wimg_i
bfc w4, 0, 3
bne 0x14
//Change to E
orr w4, w4, LTMEI_E
str w4, [x3], -(cache_entry_width)
b __dcache_algo_update_yes_snoops_loop_decrementer
//Change to I
orr w4, w4, LTMEI_I
str w4, [x3], -(cache_entry_width)
b __dcache_algo_update_yes_snoops_loop_decrementer

//Exclusive or Invalid
tbz w4, LTMEI_E, __dcache_algo_update_yes_snoops_loop_decrementer
//Exclusive
//Snoop Hit on Cacheable Read/Write -> I
//Snoop Hit on Cache-Inhib'd Read -> E (nop)
//Any other Hit or a miss -> E (nop)
tbz w1, 1, __dcache_algo_update_yes_snoops_loop_decrementer
ldr x5 [x27, batsave_ptr]
tst x5, bat_wimg_i
bfc w4, 0, 3
beq __dcache_algo_update_yes_snoops_loop_decrementer
//Change to I
orr w4, w4, LTMEI_I
str w4, [x3], -(cache_entry_width)
b __dcache_algo_update_yes_snoops_loop_decrementer

//Invalid
//Any Scenario = nop
//Decrement
__dcache_algo_update_yes_snoops_loop_decrementer:
subs w7, w7, 1
bne __dcache_algo_update_yes_snoops
ret

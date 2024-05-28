/*w0 = PA
w1 = Hit/Miss
w2 = Write/Read*/
.globl dcache_algo_update_snoops
dcache_algo_update_snoops:
/*Prologue*/
stp fp, lr, [sp, -0x10]!
mov fp, lr

/*Change PA to PA-32*/
and w6, w0, 0xFFFFFFE0
/*Set L1 DCache entry loop amount*/
mov w7, L1_DCache_entries
/*Get L1 Dcache base ptr*/
ldr x3, [x27, L1_DCache_ptr]
/*Compare PA to recently added PA, that PA doesn't get updated*/
ldr w4, [x3], L1_way_size
and w5, w4, 0xFFFFFFE0
cmp w5, w6
beq -0x10
mov w18, -(L1_way_size) /*Hacky*/

bl __dcache_algo_update_snoops

/*L1 DCache completed, now do L2
Is L2 on?*/
ldr x4, [x27, regbank_ptr]
ldr w4, [x4, l2cr]
tbz w4, l2cr_l2e_b, dcache_algo_update_snoops_epilogue

/*Set Loop Amount based on L2D0 bit*/
ubfx w4, w4, l2cr_l2do_b, 1
mov w5, L2_DCache_entries /*Incurs no l2do*/
lsl w7, w4, w5

/*Change PA to PA-64*/
and w6, w0, 0xFFFFFFC0
/*Get very base L2 DCache ptr*/
ldr x3, [x27, L2_DCache_ptr]
/*Compare PA to recently added PA, that PA doesn't get updated*/
ldr w4, [x3], L2_block_size
and w5, w4, 0xFFFFFFC0
cmp w5, w6
beq -0x10
mov w18, -(L2_block_size) /*Hacky*/

bl __dcache_algo_update_snoops

dcache_algo_update_snoops_epilogue:
ldp fp, lr, [sp], 0x10
ret

__dcache_algo_update_snoops:
/*Is PA locked?*/
tbnz w4, LMEI_L_b, -0x14

/*Update MEI
If Modified then..
Snoop Hit on Cacheable Read/Write -> I
Any other Snoop Hit -> E
Miss or any other scenario -> M (nop)*/
tbz w4, LMEI_M_b, 0x30
tbz w1, 0, __dcache_algo_update_snoops_loop_decrementer
ldr x5, [x27, batsave_ptr]
bfc w4, 0, 3
tbnz x5, bat_wimg_i_b, 0x10
/*Change to E*/
orr w4, w4, LMEI_E
str w4, [x3, x18]
b __dcache_algo_update_snoops_loop_decrementer
/*Change to I*/
orr w4, w4, LMEI_I
str w4, [x3, x18]
b __dcache_algo_update_snoops_loop_decrementer

/*Exclusive or Invalid*/
tbz w4, LMEI_E_b, __dcache_algo_update_snoops_loop_decrementer
/*Exclusive
Snoop Hit on Cacheable Read/Write -> I
Snoop Hit on Cache-Inhib'd Read -> E (nop)
Any other Hit or a miss -> E (nop)*/
tbz w1, 0, __dcache_algo_update_snoops_loop_decrementer
ldr x5, [x27, batsave_ptr]
bfc w4, 0, 3
tbz x5, bat_wimg_i_b, __dcache_algo_update_snoops_loop_decrementer
//Change to I
orr w4, w4, LMEI_I
str w4, [x3, x18]
b __dcache_algo_update_snoops_loop_decrementer

/*Invalid
Any Scenario = nop
Decrement*/
__dcache_algo_update_snoops_loop_decrementer:
subs w7, w7, 1
bne __dcache_algo_update_snoops
ret

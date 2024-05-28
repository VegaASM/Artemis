/*w0 = PA
w0 returns 1 for found
w0 returns 0 for not found, or found but locked TODO fix stuff for locked cache*/
.globl is_pa_in_icache
is_pa_in_icache:
/*Prologue*/
stp fp, lr, [sp, -0x10]!
mov fp, sp

/*is L1 ICache enabled?*/
ldr x1, [x27, regbank_ptr]
ldr w2, [x1, hid0]
bfc w0, 0, 5 /*Convert PA to PA-32, clear least significant 5 bits*/
tbz w2, hid0_ice_b, 0x24

/*Check L1 ICache*/
ldr x2, [x27, L1_ICache_ptr]

movz w3, :abs_g0: L1_ICache_entries
ldr w4, [x2], L1_way_size
bfc w4, 0, 5
cmp w0, w4
beq found_in_icache
subs w3, w3, 1
bne -0x10

/*Check L2 Ins_Cache, check L2 status first*/
ldr w2, [x1, l2cr]
tbz w2, l2cr_l2e_b, not_in_any_icache
tbnz w2, l2cr_l2do_b, not_in_any_icache

/*L2 ICache can be used, search thru it*/
ldr x2, [x27, L2_ICache_ptr]
bfc w0, 0, 6

mov w3, L2_ICache_entries
ldr w4, [x2], L2_block_size
bfc w4, 0, 6
cmp w0, w4
beq found_in_icache
subs w3, w3, 1
bne -0x10

/*Not in any i-cache, return false*/
not_in_any_icache:
mov w0, 0
b is_pa32_in_i_cache_epilogue

/*Return true*/
found_in_icache:
mov w0, 1

/*Epilogue*/
is_pa32_in_i_cache_epilogue:
ldp fp, lr, [sp], 0x10
ret

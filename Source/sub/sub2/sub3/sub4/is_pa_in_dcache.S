.globl is_pa_in_dcache
is_pa_in_dcache:
/*Prologue*/
stp fp, lr, [sp, -0x10]!
mov fp, sp

/*Convert PA to PA-32, clear least significant 5 bits*/
bfc w0, 0, 5

/*Check L1 D-Cache*/
ldr x2, [x27, L1_DCache_ptr]

movz w3, :abs_g0: L1_DCache_entries
ldr w3, [x2], L1_way_size
bfc w3, 0, 5
cmp w0, w3
beq found_in_dcache
subs w3, w3, 1
bne -0x10

/*Check L2 Data_Cache*/
ldr x2, [x27, regbank_ptr]
ldr w2, [x2, l2cr]
tst w2, l2cr_l2e
beq not_in_any_icache

/*Loop amount depends on l2do bit, extract bit*/
ubfx w4, w2, 22, 1
mov w3, L2_DCache_entries /*Incurs no l2do*/
lsl w4, w3, w4 /*If l2do, mulli loop amount by 2*/

/*Get ptr to entry list*/
ldr x2, [x27, L2_DCache_ptr]

ldr w3, [x2], L1_way_size
bfc w3, 0, 5
cmp w0, w3
beq found_in_dcache
subs w4, w4, 1
bne -0x10

/*Not in any d-cache, return null ptr*/
not_in_any_dcache:
mov w0, 0
b is_pa32_in_d_cache_epilogue

/*Return ptr to cache entry block*/
found_in_dcache:
mov w0, 1

is_pa32_in_d_cache_epilogue:
ldp fp, lr, [sp], 0x10
ret


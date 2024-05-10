.globl is_pa_in_icache
is_pa_in_icache:
/*Prologue*/
stp fp, lr, [sp, -0x10]!
mov fp, sp

/*Convert PA to PA-32, clear least significant 5 bits*/
bfc w0, 0, 5

/*Check L1 I-Cache*/
ldr x2, [x27, L1_ins_entries_ptr]

mov w3, L1_ins_number_entries
ldr w3, [x2], cache_entry_width
bfc w3, 0, 5
cmp w0, w3
beq found
subs w3, w3, 1
bne -0x10

/*Check L2 Ins_Cache*/
ldr x2, [x27, regbank_ptr]
ldr w2, [x2, l2cr]
tst w2, l2cr_l2e
beq not_in_any_icache
tst w2, l2cr_l2do
bne not_in_any_icache

/*L2 I-Cache can be used, check it*/
ldr x2, [x27, L2_ins_entries_ptr]

mov w3, L2_ins_number_entries
ldr w3, [x2], cache_entry_width
and w4, w3, 0xFFFFFFE0
cmp w0, w4
bne 0xC
tst w3, LTMEI_T
bne found
subs w3, w3, 1
bne -0x10

/*Not in any i-cache, return null ptr*/
not_in_any_icache:
mov w0, 0
b is_pa32_in_i_cache_epilogue

/*Return ptr to cache entry block*/
found:
sub x0, x2, cache_entry_width

is_pa32_in_i_cache_epilogue:
ldp fp, lr, [sp], 0x10
ret


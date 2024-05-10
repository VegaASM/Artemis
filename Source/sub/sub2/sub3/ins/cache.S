
.globl dcbf_ppc
dcbf_ppc:
stp fp, lr, [sp, -0x20]!
str x19, [sp, 0x10]
mov fp, sp
/*See if EA is legit. If so, is PA legit? If so, return back PA*/
bl data_ea_to_pa_plus_verify
cbnz w0, 0x10
/*Need to call exception instead*/
mov w1, w0
blr x18
b dcbf_epilogue
/*NOTE regardless of WIMG_I dcbf still acts the same regarding MEI protocol only*/
/*Is PA-32 in cache?*/
mov w19, w0
bfc w0, 0, 5
bl is_pa_in_dcache /*returns x0 for real mem addr, 0 for nope*/
cbnz x0, dcbf_epilogue
/*Already in Cache, update MEI*/
ldr w1, [x0]
/*M is only state that gets changed, from M to I*/
tbz w1, LTMEI_M, dcbf_epilogue
bfc w1, 0, 5
orr w1, w1, LTMEI_I //TODO what about locking and type bits?
str w1, [x0] //TODO update entry/algo number
/*Was I high, if so, skip the write from virtual to physical*/
ldr x1, [x27, batsave_ptr]
tst x1, bat_wimg_i
bne dcbf_epilogue
/*Copy from Virtual to Physical*/
ldr x18, [x0, 8] /*x18 intact thru convert func*/
bfc w19, 0, 5
bl convert
mov w1, 4 /*4 double words in a PPC cache block*/
ldr x2, [x18], 8
str x2, [x0], 8
subs w1, w1, 4
bne -0xC
/*Epilogue*/
dcbf_epilogue:
pc_adjust 0x4
ldr x19, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl dcbi_ppc
dcbi_ppc:
stp fp, lr, [sp, -0x20]!
str x19, [sp, 0x10]
mov fp, sp
/*See if EA is legit. If so, is PA legit? If so, return back PA*/
bl data_ea_to_pa_plus_verify
cbnz w0, 0x10
/*Need to call exception instead*/
mov w1, w0
blr x18
b dcbi_epilogue
/*NOTE regardless of WIMG_I icbi still acts the same regarding MEI protocol only*/
/*Is PA-32 in cache?*/
mov w19, w0
bfc w0, 0, 5
bl is_pa_in_dcache /*returns ptr to cache entry buffer, 0 for not in cache*/
cbz x0, dcbi_epilogue /*If not in cache, do a nop*/
/*Already in Cache, update MEI*/
ldr w1, [x0]
bfc w1, 0, 5
orr w1, w1, LTMEI_I //TODO what about locking and type bits?
str w1, [x0] //TODO update entry/algo number
/*Epilogue*/
dcbi_epilogue:
pc_adjust 0x4
ldr x19, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl dcbst_ppc
dcbst_ppc:
pc_adjust 0x4
ret

.globl dcbt_ppc
dcbt_ppc:
pc_adjust 0x4
ret

.globl dcbtst_ppc
dcbtst_ppc:
pc_adjust 0x4
ret

.globl dcbz_ppc
dcbz_ppc:
pc_adjust 0x4
ret

.globl dcbz_l_ppc
dcbz_l_ppc:
pc_adjust 0x4
ret

.globl icbi_ppc
icbi_ppc:
stp fp, lr, [sp, -0x20]!
str x19, [sp, 0x10]
mov fp, sp
/*See if EA is legit. If so, is PA legit? If so, return back PA*/
bl ins_ea_to_pa_plus_verify
cbnz w0, 0x10
/*Need to call exception instead*/
mov w1, w0
blr x18
b icbi_epilogue
/*NOTE regardless of WIMG_I icbi still acts the same regarding MEI protocol only*/
/*Is PA-32 in cache?*/
mov w19, w0
bfc w0, 0, 5
bl is_pa_in_icache /*returns ptr to cache entry buffer, 0 for not in cache*/
cbz x0, icbi_epilogue /*If not in cache, do a nop*/
/*Already in Cache, update MEI*/
ldr w1, [x0]
bfc w1, 0, 5
orr w1, w1, LTMEI_I //TODO what about locking and type bits?
str w1, [x0] //TODO update entry/algo number
/*Epilogue*/
icbi_epilogue:
pc_adjust 0x4
ldr x19, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl isync_ppc
isync_ppc:
pc_adjust 0x4
ret













/*This func will flip high (but NOT low) the load_flag, or store_flag, and/or touch_flag if said instruction is current instruction*/

/*Load flag = load instruction
store flag = store instruction
touch flag = dcbt or dcbtst
*/

/*dcbi, dcbz, and dcbz_l are stores, all other cache-ops are loads*/

/*NOTE: no need for store flag, not used anywhere else (so far....)*/

/*w20 = PPC Ident*/
.globl set_loadstoretouch_flags
set_loadstoretouch_flags:
/*Prologue*/
stp fp, lr, [sp, -0x10]!
mov fp, sp

/*Preset flag values*/
mov w0, 0 //load
mov w1, 0 //store
mov w2, 0 //touch

/*Check for general*/
cmp w20, dcbf_ident
blo update_flags
cmp w20, stwx_ident
bhi update_flags

/*Check for int and float store*/
cmp w20, stb_ident
bhs store
/*Check for paired single store*/
cmp w20, psq_st_ident
blo could_be_load
cmp w20, psq_stx_ident
bls load

/*Check for load*/
could_be_load:
cmp w20, lbz_ident
blo check_cache_ops
cmp w20, lwzx_ident
bls load

/*only ppc idents 57 thru 136 are possible values left*/
check_cache_ops:
cmp w20, dcbz_l_ident
bhi update_flags

/*Only cache ops left*/
cmp w20, dcbf_ident
beq store
cmp w20, dcbz_ident
bhs store

/*Load*/
load:
mov w0, 1
/*check for touch*/
cmp w20, dcbt_ident
beq 0xC
cmp w20, dcbtst_ident
bne update_flags
mov w2, 1
b update_flags

/*Store*/
store:
mov w1, 1

/*Write flags*/
update_flags:
strb w0, [x27, load_flag]
strb w1, [x27, store_flag]
strb w2, [x27, touch_flag]

/*Epilogue*/
ldp fp, lr, [sp], 0x10
ret

/*This func will flip high (but NOT low) the load_flag, or store_flag, and/or touch_flag if said instruction is current instruction*/

/*Load flag = load instruction
store flag = store instruction
touch flag = dcbt or dcbtst
*/

/*dcbi, dcbz, and dcbz_l are stores, all other cache-ops are loads*/

//TODO no need for store flag, not used anywhere else (so far....)

/*Fyi w20 = PPC Ident*/
.globl set_loadstoretouch_flags
set_loadstoretouch_flags:
stp fp, lr, [sp, -0x10]!
mov fp, sp

//Preset flag values
mov w0, 0 //load
mov w1, 0 //store
mov w2, 0 //touch

//Check for general
cmp w20, 56
bls update_flags
cmp w20, 319
bhs update_flags

//check for int and float store
cmp w20, 292
bhs store
//Check for paired single store
cmp w20, 218
blo could_be_load
cmp w20, 221
bls load

//check for load
could_be_load:
cmp w20, 137
blo check_cache_ops
cmp w20, 166
bls load

//only 57 thru 136 are possible values left
check_cache_ops:
cmp w20, 63
bhi update_flags

//only cache ops left
cmp w20, 57
beq store
cmp w20, 62
bhs store

//load
load:
mov w0, 1
//check for touch
cmp w20, 60
beq 0xC
cmp w20, 61
bne update_flags
mov w2, 1
b update_flags

store:
mov w1, 1

update_flags:
strb w0, [x27, load_flag]
strb w1, [x27, store_flag]
strb w2, [x27, touch_flag]

ldp fp, lr, [sp], 0x10
ret

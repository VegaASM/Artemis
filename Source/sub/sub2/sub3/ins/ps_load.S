//TODO conversions aint done correctly, also what about conversions that exceed max???????

.globl psq_l_ppc
psq_l_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, psq_l_ppc_epilogue
add x1, x20, fpr0
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, SIMMoff] //load SIMM value
ldr w4, [x19, rAoff] //load rA number
cmp w4, 0
beq 0xC
lsl w4, w4, 2
ldr w4, [x20, x4] //load rA value
//Calc EA and convert to real mem addr
add w0, w3, w4
bl convert
//x0 = "real" EA
//Get GQR
ldr w3, [x19, I_nonxoff]
add x1, x20, gqr0
ldr w3, [x3, x1]
//Check L_Type
ubfx w18, w3, 16, 3
cmp w18, 4
blo psq_l_no_scale
cmp w18, 4
beq psq_l_unsigned_byte
cmp w18, 5
beq psq_l_unsigned_half
cmp w18, 6
beq psq_l_signed_byte
//psq_l_signed_halfword
ldrh w4, [x0]
ldrh w5, [x0, 4]
rev16 w4, w4
rev16 w5, w5
sxth w4, w4
sxth w5, w5
b do_psq_l_scaling
psq_l_unsigned_byte:
ldrb w4, [x0]
ldrb w5, [x0, 4]
b do_psq_l_scaling
psq_l_unsigned_half:
ldrh w4, [x0]
ldrh w5, [x0]
rev16 w4, w4
rev16 w5, w5
b do_psq_l_scaling
psq_l_signed_byte:
ldrb w4, [x0]
ldrb w5, [x0, 4]
sxtb w4, w4
sxtb w5, w5
do_psq_l_scaling:
//Get L_Scale (loop counter)
ubfx w6, w3, 24, 6
cmp w6, 0
beq psq_l_set_oneDQvalue
//Place DQ value in w7
mov w7, 2
lsl w7, w7, 1
subs w6, w6, w6
bne -0x8
b 0x8
psq_l_set_oneDQvalue:
mov w7, 1
//Do Int div'd by DQ
//TODO do something other than divide ofc..
udiv w4, w4, w7
udiv w5, w5, w7
//Convert ints to single floats
tbnz w18, 2, 0x8 //low = unsigned, high = signed
ucvtf s0, w4
b psq_l_merge_floats
scvtf s1, w5
b psq_l_merge_floats
psq_l_no_scale:
ldr d1, [x1, x2]
b 0x8
psq_l_merge_floats:
ins v1.s[1], v0.s[0]
//Check for W
ldr w0, [x19, W_nonxoff]
cmp w0, 0
beq 0xC
//Set ps1 to 1.0
fmov s2, 1.0
ins v1.s[0], v2.s[0]
//Write fD
str d1, [x1, x2]
pc_adjust 0x4
psq_l_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl psq_lu_ppc
psq_lu_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, psq_lu_ppc_epilogue
add x1, x20, fpr0
ldr w2, [x19, fDoff] //load fD number
ldr w3, [x19, SIMMoff] //load SIMM value
ldr w4, [x19, rAoff] //load rA number
lsl w2, w2, 3
lsl w4, w4, 2
ldr w5, [x20, x4] //load rA value
//Calc EA and convert to real mem addr
add w0, w3, w5
//Update new EA as rA
str w0, [x20, x4]
bl convert
//x0 = "real" EA
//Get GQR
ldr w3, [x19, I_nonxoff]
add x1, x20, gqr0
ldr w3, [x3, x1]
//Check L_Type
ubfx w18, w3, 16, 3
cmp w18, 4
blo psq_lu_no_scale
cmp w18, 4
beq psq_lu_unsigned_byte
cmp w18, 5
beq psq_lu_unsigned_half
cmp w18, 6
beq psq_lu_signed_byte
//psq_lu_signed_halfword
ldrh w4, [x0]
ldrh w5, [x0, 4]
rev16 w4, w4
rev16 w5, w5
sxth w4, w4
sxth w5, w5
b do_psq_lu_scaling
psq_lu_unsigned_byte:
ldrb w4, [x0]
ldrb w5, [x0, 4]
b do_psq_l_scaling
psq_lu_unsigned_half:
ldrh w4, [x0]
ldrh w5, [x0]
rev16 w4, w4
rev16 w5, w5
b do_psq_lu_scaling
psq_lu_signed_byte:
ldrb w4, [x0]
ldrb w5, [x0, 4]
sxtb w4, w4
sxtb w5, w5
do_psq_lu_scaling:
//Get L_Scale (loop counter)
ubfx w6, w3, 24, 6
cmp w6, 0
beq psq_lu_set_oneDQvalue
//Place DQ value in w7
mov w7, 2
lsl w7, w7, 1
subs w6, w6, w6
bne -0x8
b 0x8
psq_lu_set_oneDQvalue:
mov w7, 1
//Do Int div'd by DQ
//TODO do something other than divide ofc..
udiv w4, w4, w7
udiv w5, w5, w7
//Convert ints to single floats
tbnz w18, 2, 0x8 //low = unsigned, high = signed
ucvtf s0, w4
b psq_lu_merge_floats
scvtf s1, w5
b psq_lu_merge_floats
psq_lu_no_scale:
ldr d1, [x1, x2]
b 0x8
psq_lu_merge_floats:
ins v1.s[1], v0.s[0]
//Check for W
ldr w0, [x19, W_nonxoff]
cmp w0, 0
beq 0xC
//Set ps1 to 1.0
fmov s2, 1.0
ins v1.s[0], v2.s[0]
//Write fD
str d1, [x1, x2]
pc_adjust 0x4
psq_lu_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl psq_lux_ppc
psq_lux_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, psq_lux_ppc_epilogue
add x1, x20, fpr0
ldr w2, [x19, fDoff] //load fD number
ldr w3, [x19, rAoff] //load rA number
ldr w4, [x19, rBoff] //load rB number
lsl w2, w2, 3
lsl w3, w3, 2
lsl w4, w4, 2
ldr w5, [x20, x3] //load rA value
ldr w6, [x20, x4] //load rB value
//Calc EA and convert to real mem addr
add w0, w5, w6
//Update new EA as rA
str w0, [x20, x3]
bl convert
//x0 = "real" EA
//Get GQR
ldr w3, [x19, I_xoff]
add x1, x20, gqr0
ldr w3, [x3, x1]
//Check L_Type
ubfx w18, w3, 16, 3
cmp w18, 4
blo psq_lux_no_scale
cmp w18, 4
beq psq_lux_unsigned_byte
cmp w18, 5
beq psq_lux_unsigned_half
cmp w18, 6
beq psq_lux_signed_byte
//psq_lux_signed_halfword
ldrh w4, [x0]
ldrh w5, [x0, 4]
rev16 w4, w4
rev16 w5, w5
sxth w4, w4
sxth w5, w5
b do_psq_lux_scaling
psq_lux_unsigned_byte:
ldrb w4, [x0]
ldrb w5, [x0, 4]
b do_psq_l_scaling
psq_lux_unsigned_half:
ldrh w4, [x0]
ldrh w5, [x0]
rev16 w4, w4
rev16 w5, w5
b do_psq_lux_scaling
psq_lux_signed_byte:
ldrb w4, [x0]
ldrb w5, [x0, 4]
sxtb w4, w4
sxtb w5, w5
do_psq_lux_scaling:
//Get L_Scale (loop counter)
ubfx w6, w3, 24, 6
cmp w6, 0
beq psq_lux_set_oneDQvalue
//Place DQ value in w7
mov w7, 2
lsl w7, w7, 1
subs w6, w6, w6
bne -0x8
b 0x8
psq_lux_set_oneDQvalue:
mov w7, 1
//Do Int div'd by DQ
//TODO do something other than divide ofc..
udiv w4, w4, w7
udiv w5, w5, w7
//Convert ints to single floats
tbnz w18, 2, 0x8 //low = unsigned, high = signed
ucvtf s0, w4
b psq_lux_merge_floats
scvtf s1, w5
b psq_lux_merge_floats
psq_lux_no_scale:
ldr d1, [x1, x2]
b 0x8
psq_lux_merge_floats:
ins v1.s[1], v0.s[0]
//Check for W
ldr w0, [x19, W_xoff]
cmp w0, 0
beq 0xC
//Set ps1 to 1.0
fmov s2, 1.0
ins v1.s[0], v2.s[0]
//Write fD
str d1, [x1, x2]
pc_adjust 0x4
psq_lux_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl psq_lx_ppc
psq_lx_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, psq_lx_ppc_epilogue
add x1, x20, fpr0
ldr w2, [x19, fDoff] //load fD number
ldr w4, [x19, rBoff] //load rB number
lsl w2, w2, 3
lsl w4, w4, 2
ldr w3, [x19, rAoff] //load rA number
cmp w3, 0
beq 0xC
lsl w3, w3, 2
ldr w3, [x20, x3] //load rA value
ldr w4, [x20, x4] //load rB value
//Calc EA and convert to real mem addr
add w0, w3, w4
bl convert
//x0 = "real" EA
//Get GQR
ldr w3, [x19, I_xoff]
add x1, x20, gqr0
ldr w3, [x3, x1]
//Check L_Type
ubfx w18, w3, 16, 3
cmp w18, 4
blo psq_lx_no_scale
cmp w18, 4
beq psq_lx_unsigned_byte
cmp w18, 5
beq psq_lx_unsigned_half
cmp w18, 6
beq psq_lx_signed_byte
//psq_lx_signed_halfword
ldrh w4, [x0]
ldrh w5, [x0, 4]
rev16 w4, w4
rev16 w5, w5
sxth w4, w4
sxth w5, w5
b do_psq_lx_scaling
psq_lx_unsigned_byte:
ldrb w4, [x0]
ldrb w5, [x0, 4]
b do_psq_lu_scaling
psq_lx_unsigned_half:
ldrh w4, [x0]
ldrh w5, [x0]
rev16 w4, w4
rev16 w5, w5
b do_psq_lx_scaling
psq_lx_signed_byte:
ldrb w4, [x0]
ldrb w5, [x0, 4]
sxtb w4, w4
sxtb w5, w5
do_psq_lx_scaling:
//Get L_Scale (loop counter)
ubfx w6, w3, 24, 6
cmp w6, 0
beq psq_lx_set_oneDQvalue
//Place DQ value in w7
mov w7, 2
lsl w7, w7, 1
subs w6, w6, w6
bne -0x8
b 0x8
psq_lx_set_oneDQvalue:
mov w7, 1
//Do Int div'd by DQ
//TODO do something other than divide ofc..
udiv w4, w4, w7
udiv w5, w5, w7
//Convert ints to single floats
tbnz w18, 2, 0x8 //low = unsigned, high = signed
ucvtf s0, w4
b psq_lx_merge_floats
scvtf s1, w5
b psq_lx_merge_floats
psq_lx_no_scale:
ldr d1, [x1, x2]
b 0x8
psq_lx_merge_floats:
ins v1.s[1], v0.s[0]
//Check for W
ldr w0, [x19, W_xoff]
cmp w0, 0
beq 0xC
//Set ps1 to 1.0
fmov s2, 1.0
ins v1.s[0], v2.s[0]
//Write fD
str d1, [x1, x2]
pc_adjust 0x4
psq_lx_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

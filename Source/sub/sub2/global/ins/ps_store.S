//TODO conversions aint done correctly, also what about conversions that exceed max???????

.globl psq_st_ppc
psq_st_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, psq_st_ppc_epilogue
add x1, x20, fpr0
ldr w2, [x19, fDoff] //load fS number
ldr w3, [x19, SIMMoff] //load SIMM value
ldr w4, [x19, rAoff] //load rA number
lsl w2, w2, 3
lsl w4, w4, 2
ldr d6, [x1, x2] //load fS value
ins v5.s[1], v6.s[1] //extract fS value ps0. s5 = ps0, s6 = ps1
ldr w4, [x20, x4] //load rA value
//Calc EA and convert to real mem addr
add w0, w3, w4
bl convert
//x0 = "real" EA
//Check for W
ldr w0, [x19, W_nonxoff]
cmp w0, 0
beq 0xC
//Change fS ps1 to 1.0
fmov s6, 1.0
//Set ps1 to 1.0
//Get GQR
ldr w3, [x19, I_nonxoff]
add x1, x20, gqr0
ldr w3, [x3, x1]
//Check R_Type
ubfx w18, w3, 0, 3
cmp w18, 4
blo psq_st_no_scale
cmp w18, 4
beq psq_st_unsigned_byte
cmp w18, 5
beq psq_st_unsigned_half
cmp w18, 6
beq psq_st_signed_byte
//psq_st_signed_halfword
fcvtas w5, s5
fcvtas w6, s6
b do_psq_st_scaling
psq_st_unsigned_byte:
fcvtau w5, s5
fcvtau w6, s6
b do_psq_st_scaling
psq_st_unsigned_half:
fcvtau w5, s5
fcvtau w6, s6
b do_psq_st_scaling
psq_st_signed_byte:
fcvtas w5, s5
fcvtas w6, s6
do_psq_st_scaling:
//Get R_Scale (loop counter)
ubfx w7, w3, 8, 6
cmp w7, 0
beq psq_st_set_oneDQvalue
//Place DQ value in w7
mov w8, 2
lsl w8, w8, 1
subs w7, w7, w7
bne -0x8
b 0x8
psq_st_set_oneDQvalue:
mov w8, 1
//Do Int mul'd by DQ
//TODO do something other than multiply ofc..
mul w5, w5, w8
mul w6, w6, w8
//Store byte vs half
tbnz w18, 1, 0x10 //even = byte, odd = half
strb w5, [x0]
strb w6, [x0, 1]
b 0x18
strh w5, [x0]
strh w5, [x0, 2]
b 0xC
psq_st_no_scale:
str s5, [x0, 4] //TODO put in denorm and HID4 ST0 stuff
str s6, [x0, 4]
pc_adjust 0x4
psq_st_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl psq_stu_ppc
psq_stu_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, psq_stu_ppc_epilogue
add x1, x20, fpr0
ldr w2, [x19, fDoff] //load fS number
ldr w3, [x19, SIMMoff] //load SIMM value
ldr w4, [x19, rAoff] //load rA number
lsl w2, w2, 3
lsl w4, w4, 2
ldr d6, [x1, x2] //load fS value
ins v5.s[1], v6.s[1] //extract fS value ps0. s5 = ps0, s6 = ps1
ldr w7, [x20, x4] //load rA value
//Calc EA and convert to real mem addr
add w0, w3, w7
//Writer new EA to rA
str w0, [x20, x4]
bl convert
//x0 = "real" EA
//Check for W
ldr w0, [x19, W_nonxoff]
cmp w0, 0
beq 0xC
//Change fS ps1 to 1.0
fmov s6, 1.0
//Set ps1 to 1.0
//Get GQR
ldr w3, [x19, I_nonxoff]
add x1, x20, gqr0
ldr w3, [x3, x1]
//Check R_Type
ubfx w18, w3, 0, 3
cmp w18, 4
blo psq_stu_no_scale
cmp w18, 4
beq psq_stu_unsigned_byte
cmp w18, 5
beq psq_stu_unsigned_half
cmp w18, 6
beq psq_stu_signed_byte
//psq_stu_signed_halfword
fcvtas w5, s5
fcvtas w6, s6
b do_psq_stu_scaling
psq_stu_unsigned_byte:
fcvtau w5, s5
fcvtau w6, s6
b do_psq_stu_scaling
psq_stu_unsigned_half:
fcvtau w5, s5
fcvtau w6, s6
b do_psq_stu_scaling
psq_stu_signed_byte:
fcvtas w5, s5
fcvtas w6, s6
do_psq_stu_scaling:
//Get R_Scale (loop counter)
ubfx w7, w3, 8, 6
cmp w7, 0
beq psq_stu_set_oneDQvalue
//Place DQ value in w7
mov w8, 2
lsl w8, w8, 1
subs w7, w7, w7
bne -0x8
b 0x8
psq_stu_set_oneDQvalue:
mov w8, 1
//Do Int mul'd by DQ
//TODO do something other than multiply ofc..
mul w5, w5, w8
mul w6, w6, w8
//Store byte vs half
tbnz w18, 1, 0x10 //even = byte, odd = half
strb w5, [x0]
strb w6, [x0, 1]
b 0x18
strh w5, [x0]
strh w5, [x0, 2]
b 0xC
psq_stu_no_scale:
str s5, [x0, 4] //TODO put in denorm and HID4 ST0 stuff
str s6, [x0, 4]
pc_adjust 0x4
psq_stu_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl psq_stux_ppc
psq_stux_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, psq_stux_ppc_epilogue
add x1, x20, fpr0
ldr w2, [x19, fDoff] //load fS number
ldr w3, [x19, rAoff] //load rA number
ldr w4, [x19, rBoff] //load rA number
lsl w2, w2, 3
lsl w3, w3, 2
lsl w4, w4, 2
ldr d6, [x1, x2] //load fS value
ins v5.s[1], v6.s[1] //extract fS value ps0. s5 = ps0, s6 = ps1
ldr w7, [x20, x3] //load rA value
ldr w8, [x20, x4] //load rB value
//Calc EA and convert to real mem addr
add w0, w7, w8
//Writer new EA to rA
str w0, [x20, x7]
bl convert
//x0 = "real" EA
//Check for W
ldr w0, [x19, W_xoff]
cmp w0, 0
beq 0xC
//Change fS ps1 to 1.0
fmov s6, 1.0
//Set ps1 to 1.0
//Get GQR
ldr w3, [x19, I_xoff]
add x1, x20, gqr0
ldr w3, [x3, x1]
//Check R_Type
ubfx w18, w3, 0, 3
cmp w18, 4
blo psq_stux_no_scale
cmp w18, 4
beq psq_stux_unsigned_byte
cmp w18, 5
beq psq_stux_unsigned_half
cmp w18, 6
beq psq_stux_signed_byte
//psq_stux_signed_halfword
fcvtas w5, s5
fcvtas w6, s6
b do_psq_stux_scaling
psq_stux_unsigned_byte:
fcvtau w5, s5
fcvtau w6, s6
b do_psq_stux_scaling
psq_stux_unsigned_half:
fcvtau w5, s5
fcvtau w6, s6
b do_psq_stux_scaling
psq_stux_signed_byte:
fcvtas w5, s5
fcvtas w6, s6
do_psq_stux_scaling:
//Get R_Scale (loop counter)
ubfx w7, w3, 8, 6
cmp w7, 0
beq psq_stux_set_oneDQvalue
//Place DQ value in w7
mov w8, 2
lsl w8, w8, 1
subs w7, w7, w7
bne -0x8
b 0x8
psq_stux_set_oneDQvalue:
mov w8, 1
//Do Int mul'd by DQ
//TODO do something other than multiply ofc..
mul w5, w5, w8
mul w6, w6, w8
//Store byte vs half
tbnz w18, 1, 0x10 //even = byte, odd = half
strb w5, [x0]
strb w6, [x0, 1]
b 0x18
strh w5, [x0]
strh w5, [x0, 2]
b 0xC
psq_stux_no_scale:
str s5, [x0, 4] //TODO put in denorm and HID4 ST0 stuff
str s6, [x0, 4]
pc_adjust 0x4
psq_stux_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl psq_stx_ppc
psq_stx_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, psq_stx_ppc_epilogue
add x1, x20, fpr0
ldr w2, [x19, fDoff] //load fS number
ldr w3, [x19, rAoff] //load rA number
ldr w4, [x19, rBoff] //load rA number
lsl w2, w2, 3
lsl w3, w3, 2
lsl w4, w4, 2
ldr d6, [x1, x2] //load fS value
ins v5.s[1], v6.s[1] //extract fS value ps0. s5 = ps0, s6 = ps1
ldr w7, [x20, x3] //load rA value
ldr w8, [x20, x4] //load rB value
//Calc EA and convert to real mem addr
add w0, w7, w8
bl convert
//x0 = "real" EA
//Check for W
ldr w0, [x19, W_xoff]
cmp w0, 0
beq 0xC
//Change fS ps1 to 1.0
fmov s6, 1.0
//Set ps1 to 1.0
//Get GQR
ldr w3, [x19, I_xoff]
add x1, x20, gqr0
ldr w3, [x3, x1]
//Check R_Type
ubfx w18, w3, 0, 3
cmp w18, 4
blo psq_stx_no_scale
cmp w18, 4
beq psq_stx_unsigned_byte
cmp w18, 5
beq psq_stx_unsigned_half
cmp w18, 6
beq psq_stx_signed_byte
//psq_stx_signed_halfword
fcvtas w5, s5
fcvtas w6, s6
b do_psq_stx_scaling
psq_stx_unsigned_byte:
fcvtau w5, s5
fcvtau w6, s6
b do_psq_stx_scaling
psq_stx_unsigned_half:
fcvtau w5, s5
fcvtau w6, s6
b do_psq_stx_scaling
psq_stx_signed_byte:
fcvtas w5, s5
fcvtas w6, s6
do_psq_stx_scaling:
//Get R_Scale (loop counter)
ubfx w7, w3, 8, 6
cmp w7, 0
beq psq_stx_set_oneDQvalue
//Place DQ value in w7
mov w8, 2
lsl w8, w8, 1
subs w7, w7, w7
bne -0x8
b 0x8
psq_stx_set_oneDQvalue:
mov w8, 1
//Do Int mul'd by DQ
//TODO do something other than multiply ofc..
mul w5, w5, w8
mul w6, w6, w8
//Store byte vs half
tbnz w18, 1, 0x10 //even = byte, odd = half
strb w5, [x0]
strb w6, [x0, 1]
b 0x18
strh w5, [x0]
strh w5, [x0, 2]
b 0xC
psq_stx_no_scale:
str s5, [x0, 4] //TODO put in denorm and HID4 ST0 stuff
str s6, [x0, 4]
pc_adjust 0x4
psq_stx_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

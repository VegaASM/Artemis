//TODO add in norms, denorms, nans, conversions etc
//stfsX HID2 PSE low = entire FPR converted to 32-bit single then stored
//stfsX HID2 PSE high = ps0 only gets stored
//stfdX HID2 PSE low = entire fpr gets stored
//stfdX HID2 PSE high = ps0 converted to 64-bit, 64-bit float then stored
//todo verify-ea on all funcs
//todo since arm64 is LE, do we need to rev/16 all the non-reverse stores?

.globl stfd_ppc
stfd_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
bl float_legal_check
cbnz w0, stfd_ppc_epilogue
mov x19, x0
mov x20, x1
ldr w2, [x0, doff] //get SIMM value
ldr w3, [x0, rAoff] //get rA number
cmp w3, 0
beq 0xC
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA value
add w0, w2, w3 //calc EA
bl convert
ldr w1, [x19, fDoff] //grab fS number
lsl w1, w1, 3
ldr d1, [x19, x1] //grab fS double-value
Get_hid2_pse w18
cmp w18, 0
beq 0xC
ins v1.s[0], v1.s[1] //we need to swap ps's so we can store convert then store ps0
fcvt d1, s1 //expand "ps0" to 64-bits before we store
str d1, [x0] //store double-float to EA, stfd::ppc
pc_adjust 0x4
stfd_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stfdu_ppc
stfdu_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
bl float_legal_check
cbnz w0, stfdu_ppc_epilogue
mov x19, x0
mov x20, x1
ldr w2, [x0, doff] //get SIMM value
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x1, x3] //grab rA value
add w0, w2, w4 //calc EA
str w0, [x1, x3] //write new rA value
bl convert
ldr w1, [x19, fDoff] //grab fS number
lsl w1, w1, 3
ldr d1, [x19, x1] //grab fS double-value
Get_hid2_pse w18
cmp w18, 0
beq 0xC
ins v1.s[0], v1.s[1] //we need to swap ps's so we can store convert then store ps0
fcvt d1, s1 //expand "ps0" to 64-bits before we store
str d1, [x0] //store double-float to EA, stfdu::ppc
pc_adjust 0x4
stfdu_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stfdux_ppc
stfdux_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
bl float_legal_check
cbnz w0, stfdux_ppc_epilogue
mov x19, x0
mov x20, x1
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rBoff] //get rB number
lsl w3, w3, 2
ldr w4, [x1, x2] //grab rA value
ldr w5, [x1, x3] //grab rB value
add w0, w4, w5 //calc EA
str w0, [x1, x3] //write new rA value
bl convert
ldr w1, [x19, fDoff] //grab fS number
lsl w1, w1, 3
ldr d1, [x19, x1] //grab fS double-value
Get_hid2_pse w18
cmp w18, 0
beq 0xC
ins v1.s[0], v1.s[1] //we need to swap ps's so we can store convert then store ps0
fcvt d1, s1 //expand "ps0" to 64-bits before we store
str d1, [x0] //store double-float to EA, stfdux::ppc
pc_adjust 0x4
stfdux_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stfdx_ppc
stfdx_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
bl float_legal_check
cbnz w0, stfdx_ppc_epilogue
mov x19, x0
mov x20, x1
ldr w3, [x0, rBoff] //get rB number
lsl w3, w3, 2
ldr w2, [x0, rAoff] //get rA number
cmp w2, 0
beq 0xC
lsl w2, w2, 2
ldr w2, [x1, x2] //grab rA value
ldr w3, [x1, x3] //grab rB value
add w0, w2, w3 //calc EA
bl convert
ldr w1, [x19, fDoff] //grab fS number
lsl w1, w1, 3
ldr d1, [x19, x1] //grab fS double-value
Get_hid2_pse w18
cmp w18, 0
beq 0xC
ins v1.s[0], v1.s[1] //we need to swap ps's so we can store convert then store ps0
fcvt d1, s1 //expand "ps0" to 64-bits before we store
str d1, [x0] //store double-float to EA, stfdx::ppc
pc_adjust 0x4
stfdx_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stfiwx_ppc
stfiwx_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
bl float_legal_check
cbnz w0, stfiwx_ppc_epilogue
mov x19, x0
mov x20, x1
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rBoff] //get rB number
lsl w3, w3, 2
ldr w4, [x1, x2] //grab rA value
ldr w5, [x1, x3] //grab rB value
add w0, w4, w5 //calc EA
bl convert
ldr w1, [x19, fDoff] //grab fS number
lsl w1, w1, 3
add w1, w1, 4
ldr s1, [x19, x1] //grab fS ps1***
str s1, [x0] //store single-float to EA, stfiwx::ppc
pc_adjust 0x4
stfiwx_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stfs_ppc
stfs_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
bl float_legal_check
cbnz w0, stfs_ppc_epilogue
mov x19, x0
mov x20, x1
ldr w2, [x0, doff] //get SIMM value
ldr w3, [x0, rAoff] //get rA number
cmp w3, 0
beq 0xC
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA value
add w0, w2, w3 //calc EA
bl convert
ldr w1, [x19, fDoff] //grab fS number
lsl w1, w1, 3
ldr d1, [x19, x1] //grab entire fS fpr
Get_hid2_pse w18
cmp w18, 0
beq 0xC
ins v1.s[0], v1.s[1] //we need to swap ps's so we can store ps0
b 0x8
fcvt s1, d1 //stfX when PSE low requires to convert to 32-bit single before store
str s1, [x0] //store single-float to EA, stfs::ppc
pc_adjust 0x4
stfs_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stfsu_ppc
stfsu_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
bl float_legal_check
cbnz w0, stfsu_ppc_epilogue
mov x19, x0
mov x20, x1
ldr w2, [x0, doff] //get SIMM value
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x1, x3] //grab rA value
add w0, w2, w4 //calc EA
str w0, [x1, x3] //write new rA value
bl convert
ldr w1, [x19, fDoff] //grab fS number
lsl w1, w1, 3
ldr d1, [x19, x1] //grab entire fS fpr
Get_hid2_pse w18
cmp w18, 0
beq 0xC
ins v1.s[0], v1.s[1] //we need to swap ps's so we can store ps0
b 0x8
fcvt s1, d1 //stfX when PSE low requires to convert to 32-bit single before store
str s1, [x0] //store single-float to EA, stfsu::ppc
pc_adjust 0x4
stfsu_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stfsux_ppc
stfsux_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
bl float_legal_check
cbnz w0, stfsux_ppc_epilogue
mov x19, x0
mov x20, x1
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rBoff] //get rB number
lsl w3, w3, 2
ldr w4, [x1, x2] //grab rA value
ldr w5, [x1, x3] //grab rB value
add w0, w4, w5 //calc EA
str w0, [x1, x3] //write new rA value
bl convert
ldr w1, [x19, fDoff] //grab fS number
lsl w1, w1, 3
ldr d1, [x19, x1] //grab entire fS fpr
Get_hid2_pse w18
cmp w18, 0
beq 0xC
ins v1.s[0], v1.s[1] //we need to swap ps's so we can store ps0
b 0x8
fcvt s1, d1 //stfX when PSE low requires to convert to 32-bit single before store
str s1, [x0] //store single-float to EA, stfsux::ppc
pc_adjust 0x4
stfsux_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stfsx_ppc
stfsx_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
bl float_legal_check
cbnz w0, stfsx_ppc_epilogue
mov x19, x0
mov x20, x1
ldr w3, [x0, rBoff] //get rB number
lsl w3, w3, 2
ldr w2, [x0, rAoff] //get rA number
cmp w2, 0
beq 0xC
lsl w2, w2, 2
ldr w2, [x1, x2] //grab rA value
ldr w3, [x1, x3] //grab rB value
add w0, w2, w3 //calc EA
bl convert
ldr w1, [x19, fDoff] //grab fS number
lsl w1, w1, 3
ldr d1, [x19, x1] //grab entire fS fpr
Get_hid2_pse w18
cmp w18, 0
beq 0xC
ins v1.s[0], v1.s[1] //we need to swap ps's so we can store ps0
b 0x8
fcvt s1, d1 //stfX when PSE low requires to convert to 32-bit single before store
str s1, [x0] //store single-float to EA, stfsx::ppc
pc_adjust 0x4
stfsx_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

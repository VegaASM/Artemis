//TODO add in norms, denorms, nans, conversions etc
//lfsX HID2 PSE low = single coverted to double, place in entire FPR
//lfsX HID2 PSE high = both ps0 and ps1 get loaded with value
//lfdX HID2 PSE low = entire doubleword loaded in entire FPR
//lfdX HID2 PSE high = doubleword converted to 32-bit single, placed into ps0. ps1 is undefined junk (on real hardware, this appears to always be 1.0, fyi none of this is in the Broadway Manual)
//todo put in verify-EA funcs
//todo since arm64 is le, we may need to rev all non-rev loads

.globl lfd_ppc
lfd_ppc:
stp fp, lr, [sp, -0x30]!
stp x19, x20, [sp, 0x10]
str x21, [sp, 0x20]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, lfd_ppc_epilogue
ldr w2, [x0, doff] //get SIMM value
ldr w3, [x0, rAoff] //get rA number
cmp w3, 0
beq 0xC
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA value
add w0, w2, w3 //calc EA
mov w1, 1
mov w21, w0
bl dcache_main
cbz x0, lfd_ppc_epilogue
ldr d3, [x0]
ldr w2, [x19, fDoff] //grab fD number
lsl w2, w2, 3
add x20, x20, fpr0 //adjust to start at fpr part of reg bank table
Get_hid2_pse w18
cmp w18, 0
beq 0x14
fcvt s3, d3
dup v3.2s, v3.s[0] //Need single-float in ps0
fmov s4, 1.0 //value used for undefined
ins v3.s[0], v4.s[0] //place in undefined value
str d3, [x20, x2] //"load" double into fD, lfd::ppc, yes this is STR!
pc_adjust 0x4
lfd_ppc_epilogue:
ldr x21, [sp, 0x20]
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x30
ret

.globl lfdu_ppc
lfdu_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, lfdu_ppc_epilogue
ldr w2, [x0, doff] //get SIMM value
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x1, x3] //grab rA value
add w0, w2, w4 //calc EA
str w0, [x1, x3] //write new rA value
bl convert
ldr d3, [x0]
ldr w2, [x19, fDoff] //grab fD number
lsl w2, w2, 3
add x20, x20, fpr0 //adjust to start at fpr part of reg bank table
Get_hid2_pse w18
cmp w18, 0
beq 0x14
fcvt s3, d3
dup v3.2s, v3.s[0] //Need single-float in ps0
fmov s4, 1.0 //value used for undefined
ins v3.s[0], v4.s[0] //place in undefined value
str d3, [x20, x2] //"load" double into fD, lfdu::ppc, yes this is STR!
pc_adjust 0x4
lfdu_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lfdux_ppc
lfdux_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
bl float_legal_check
cbnz w0, lfdux_ppc_epilogue
mov x19, x0
mov x20, x1
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rBoff] //get rB number
lsl w3, w3, 2
ldr w4, [x1, x3] //grab rA value
ldr w5, [x1, x4] //grab rB value
add w0, w4, w5 //calc EA
str w0, [x1, x3] //write new rA value
bl convert
ldr d3, [x0]
ldr w2, [x19, fDoff] //grab fD number
lsl w2, w2, 3
add x20, x20, fpr0 //adjust to start at fpr part of reg bank table
Get_hid2_pse w18
cmp w18, 0
beq 0x14
fcvt s3, d3
dup v3.2s, v3.s[0] //Need single-float in ps0
fmov s4, 1.0 //value used for undefined
ins v3.s[0], v4.s[0] //place in undefined value
str d3, [x20, x2] //"load" double into fD, lfdux::ppc, yes this is STR!
pc_adjust 0x4
lfdux_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lfdx_ppc
lfdx_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
bl float_legal_check
cbnz w0, lfdx_ppc_epilogue
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
ldr d3, [x0]
ldr w2, [x19, fDoff] //grab fD number
lsl w2, w2, 3
add x20, x20, fpr0 //adjust to start at fpr part of reg bank table
Get_hid2_pse w18
cmp w18, 0
beq 0x14
fcvt s3, d3
dup v3.2s, v3.s[0] //Need single-float in ps0
fmov s4, 1.0 //value used for undefined
ins v3.s[0], v4.s[0] //place in undefined value
str d3, [x20, x2] //"load" double into fD, lfdx::ppc, yes this is STR!
pc_adjust 0x4
lfdx_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lfs_ppc
lfs_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
bl float_legal_check
cbnz w0, lfs_ppc_epilogue
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
ldr s3, [x0]
ldr w2, [x19, fDoff] //grab fD number
lsl w2, w2, 3
add x20, x20, fpr0 //adjust to start at fpr part of reg bank table
Get_hid2_pse w18
cmp w18, 0
beq 0xC
dup v3.2s, v3.s[0] //ps0 needs float as well
b 0x8
fcvt d3, s3 //expand single to 64-bits
str d3, [x20, x2] //"load" singles into fD ps0 and ps1, lfs::ppc, yes this is STR!
pc_adjust 0x4
lfs_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lfsu_ppc
lfsu_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
bl float_legal_check
cbnz w0, lfsu_ppc_epilogue
mov x19, x0
mov x20, x1
ldr w2, [x0, doff] //get SIMM value
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x1, x3] //grab rA value
add w0, w2, w4 //calc EA
str w0, [x1, x3] //write new rA value
bl convert
ldr s3, [x0]
ldr w2, [x19, fDoff] //grab fD number
lsl w2, w2, 3
add x20, x20, fpr0 //adjust to start at fpr part of reg bank table
Get_hid2_pse w18
cmp w18, 0
beq 0xC
dup v3.2s, v3.s[0] //ps0 needs float as well
b 0x8
fcvt d3, s3 //expand single to 64-bits
str d3, [x20, x2] //"load" singles into fD ps0 and ps1, lfsu::ppc, yes this is STR!
pc_adjust 0x4
lfsu_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lfsux_ppc
lfsux_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
bl float_legal_check
cbnz w0, lfsux_ppc_epilogue
mov x19, x0
mov x20, x1
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rBoff] //get rB number
lsl w3, w3, 2
ldr w4, [x1, x3] //grab rA value
ldr w5, [x1, x4] //grab rB value
add w0, w4, w5 //calc EA
str w0, [x1, x3] //write new rA value
bl convert
ldr s3, [x0]
ldr w2, [x19, fDoff] //grab fD number
lsl w2, w2, 3
add x20, x20, fpr0 //adjust to start at fpr part of reg bank table
Get_hid2_pse w18
cmp w18, 0
beq 0xC
dup v3.2s, v3.s[0] //ps0 needs float as well
b 0x8
fcvt d3, s3 //expand single to 64-bits
str d3, [x20, x2] //"load" singles into fD ps0 and ps1, lfsux::ppc, yes this is STR!
pc_adjust 0x4
lfsux_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lfsx_ppc
lfsx_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
bl float_legal_check
cbnz w0, lfsx_ppc_epilogue
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
ldr s3, [x0]
ldr w2, [x19, fDoff] //grab fD number
lsl w2, w2, 3
add x20, x20, fpr0 //adjust to start at fpr part of reg bank table
Get_hid2_pse w18
cmp w18, 0
beq 0xC
dup v3.2s, v3.s[0] //ps0 needs float as well
b 0x8
fcvt d3, s3 //expand single to 64-bits
str d3, [x20, x2] //"load" singles into fD ps0 and ps1, lfsx::ppc, yes this is STR!
pc_adjust 0x4
lfsx_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

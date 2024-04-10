//TODO add in norms, denorms, nans, conversions etc
//lfsX HID2 PSE low = single coverted to double, place in entire FPR
//lfsX HID2 PSE high = both ps0 and ps1 get loaded with value
//lfdX HID2 PSE doesn't matter = entire fpr loaded with value
//todo put in verify-EA funcs
//todo since arm64 is le, we may need to rev all non-rev loads

.globl lfd_ppc
lfd_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, lfd_ppc_epilogue
ldr w2, [x0, doff] //get SIMM value
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA value
add w0, w2, w3 //calc EA
bl convert
ldr d0, [x0]
ldr w2, [x19, fDoff] //grab fD number
lsl w2, w2, 3
add x20, x20, fpr0 //adjust to start at fpr part of reg bank table
str d0, [x20, x2] //"load" double into fD, lfd::ppc, yes this is STR!
pc_adjust 0x4
lfd_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
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
ldr d0, [x0]
ldr w2, [x19, fDoff] //grab fD number
lsl w2, w2, 3
add x20, x20, fpr0 //adjust to start at fpr part of reg bank table
str d0, [x20, x2] //"load" double into fD, lfdu::ppc, yes this is STR!
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
ldr d0, [x0]
ldr w2, [x19, fDoff] //grab fD number
lsl w2, w2, 3
add x20, x20, fpr0 //adjust to start at fpr part of reg bank table
str d0, [x20, x2] //"load" double into fD, lfdux::ppc, yes this is STR!
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
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rBoff] //get rB number
lsl w3, w3, 2
ldr w4, [x1, x2] //grab rA value
ldr w5, [x1, x3] //grab rB value
add w0, w4, w5 //calc EA
bl convert
ldr d0, [x0]
ldr w2, [x19, fDoff] //grab fD number
lsl w2, w2, 3
add x20, x20, fpr0 //adjust to start at fpr part of reg bank table
str d0, [x20, x2] //"load" double into fD, lfd::ppc, yes this is STR!
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
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA value
add w0, w2, w3 //calc EA
bl convert
ldr s0, [x0] //atm single float is in ps1, needs to be in both ps0 and ps1
dup v0.2s, v0.2s[0]
ldr w2, [x19, fDoff] //grab fD number
lsl w2, w2, 3
add x20, x20, fpr0 //adjust to start at fpr part of reg bank table
str d0, [x20, x2] //"load" singles into fD ps0 and ps1, lfs::ppc, yes this is STR!
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
ldr s0, [x0] //atm single float is in ps1, needs to be in both ps0 and ps1
dup v0.2s, v0.2s[0]
ldr w2, [x19, fDoff] //grab fD number
lsl w2, w2, 3
add x20, x20, fpr0 //adjust to start at fpr part of reg bank table
str d0, [x20, x2] //"load" singles into fD ps0 and ps1, lfs::ppc, yes this is STR!
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
ldr s0, [x0] //atm single float is in ps1, needs to be in both ps0 and ps1
dup v0.2s, v0.2s[0]
ldr w2, [x19, fDoff] //grab fD number
lsl w2, w2, 3
add x20, x20, fpr0 //adjust to start at fpr part of reg bank table
str d0, [x20, x2] //"load" singles into fD ps0 and ps1, lfs::ppc, yes this is STR!
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
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rBoff] //get rB number
lsl w3, w3, 2
ldr w4, [x1, x2] //grab rA value
ldr w5, [x1, x3] //grab rB value
add w0, w4, w5 //calc EA
bl convert
ldr s0, [x0] //atm single float is in ps1, needs to be in both ps0 and ps1
dup v0.2s, v0.2s[0]
ldr w2, [x19, fDoff] //grab fD number
lsl w2, w2, 3
add x20, x20, fpr0 //adjust to start at fpr part of reg bank table
str d0, [x20, x2] //"load" singles into fD ps0 and ps1, lfs::ppc, yes this is STR!
pc_adjust 0x4
lfsx_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

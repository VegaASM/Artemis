//Important NOTE: single float load instructions load both into both ps0 and ps1

.globl lfd_ppc
lfd_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov x19, x0
mov x20, x1
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
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lfdu_ppc
lfdu_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov x19, x0
mov x20, x1
ldr w2, [x0, doff] //get SIMM value
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x1, x3] //grab rA value
add w0, w2, w4 //calc EA
str w4, [x1, x3] //write new rA value
bl convert
ldr d0, [x0]
ldr w2, [x19, fDoff] //grab fD number
lsl w2, w2, 3
add x20, x20, fpr0 //adjust to start at fpr part of reg bank table
str d0, [x20, x2] //"load" double into fD, lfdu::ppc, yes this is STR!
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lfdux_ppc
lfdux_ppc:
pc_adjust 0x4
ret

.globl lfdx_ppc
lfdx_ppc:
pc_adjust 0x4
ret

.globl lfs_ppc
lfs_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
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
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lfsu_ppc
lfsu_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov x19, x0
mov x20, x1
ldr w2, [x0, doff] //get SIMM value
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x1, x3] //grab rA value
add w0, w2, w4 //calc EA
str w4, [x1, x3] //write new rA value
bl convert
ldr s0, [x0] //atm single float is in ps1, needs to be in both ps0 and ps1
dup v0.2s, v0.2s[0]
ldr w2, [x19, fDoff] //grab fD number
lsl w2, w2, 3
add x20, x20, fpr0 //adjust to start at fpr part of reg bank table
str d0, [x20, x2] //"load" singles into fD ps0 and ps1, lfs::ppc, yes this is STR!
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lfsux_ppc
lfsux_ppc:
pc_adjust 0x4
ret

.globl lfsx_ppc
lfsx_ppc:
pc_adjust 0x4
ret

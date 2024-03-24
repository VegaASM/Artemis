//Important. On single float stores, ps0 gets stored, NOT ps1

.globl stfd_ppc
stfd_ppc:
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
ldr w1, [x19, fDoff] //grab fD number
lsl w1, w1, 3
ldr d1, [x19, x1] //grab fD double-value
str d1, [x0] //store double-float to EA, stfd::ppc
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stfdu_ppc
stfdu_ppc:
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
ldr w1, [x19, fDoff] //grab fD number
lsl w1, w1, 3
ldr d1, [x19, x1] //grab fD double-value
str d1, [x0] //store double-float to EA, stfdu::ppc
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stfdux_ppc
stfdux_ppc:
pc_adjust 0x4
ret

.globl stfdx_ppc
stfdx_ppc:
pc_adjust 0x4
ret

.globl stfiwx_ppc
stfiwx_ppc:
pc_adjust 0x4
ret

.globl stfs_ppc
stfs_ppc:
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
ldr w1, [x19, fDoff] //grab fD number
lsl w1, w1, 3
ldr s1, [x19, x1] //grab fD ps0
str s1, [x0] //store double-float to EA, stfs::ppc
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stfsu_ppc
stfsu_ppc:
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
ldr w1, [x19, fDoff] //grab fD number
lsl w1, w1, 3
ldr s1, [x19, x1] //grab fD ps0
str s1, [x0] //store double-float to EA, stfsu::ppc
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stfsux_ppc
stfsux_ppc:
pc_adjust 0x4
ret

.globl stfsx_ppc
stfsx_ppc:
pc_adjust 0x4
ret


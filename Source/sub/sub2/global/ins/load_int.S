.globl lbz_ppc
lbz_ppc:
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
ldrb w0, [x0]
ldr w2, [x19, rDoff] //grab rD number
lsl w2, w2, 2
str w0, [x20, x2] //"load" byte into rD, lbz::ppc, yes this is STR!
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lbzu_ppc
lbzu_ppc:
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
ldrb w0, [x0]
ldr w2, [x19, rDoff] //grab rD number
lsl w2, w2, 2
str w0, [x20, x2] //"load" byte into rD, lbzu::ppc, yes this is STR!
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lbzux_ppc
lbzux_ppc:
pc_adjust 0x4
ret

.globl lbzx_ppc
lbzx_ppc:
pc_adjust 0x4
ret

.globl lha_ppc
lha_ppc:
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
ldrsh w0, [x0]
ldr w2, [x19, rDoff] //grab rD number
lsl w2, w2, 2
str w0, [x20, x2] //"load" signed halfword into rD, lha::ppc, yes this is STR!
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lhau_ppc
lhau_ppc:
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
ldrsh w0, [x0]
ldr w2, [x19, rDoff] //grab rD number
lsl w2, w2, 2
str w0, [x20, x2] //"load" signed halfword into rD, lhau::ppc, yes this is STR!
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lhaux_ppc
lhaux_ppc:
pc_adjust 0x4
ret

.globl lhax_ppc
lhax_ppc:
pc_adjust 0x4
ret

.globl lhbrx_ppc
lhbrx_ppc:
pc_adjust 0x4
ret

.globl lhz_ppc
lhz_ppc:
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
ldrh w0, [x0]
ldr w2, [x19, rDoff] //grab rD number
lsl w2, w2, 2
str w0, [x20, x2] //"load" halfword into rD, lhz::ppc, yes this is STR!
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lhzu_ppc
lhzu_ppc:
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
ldrh w0, [x0]
ldr w2, [x19, rDoff] //grab rD number
lsl w2, w2, 2
str w0, [x20, x2] //"load" halfword into rD, lhzu::ppc, yes this is STR!
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lhzux_ppc
lhzux_ppc:
pc_adjust 0x4
ret

.globl lhzx_ppc
lhzx_ppc:
pc_adjust 0x4
ret

.globl lmw_ppc
lmw_ppc:
pc_adjust 0x4
ret

.globl lswi_ppc
lswi_ppc:
pc_adjust 0x4
ret

.globl lswx_ppc
lswx_ppc:
pc_adjust 0x4
ret

.globl lwarx_ppc
lwarx_ppc:
pc_adjust 0x4
ret

.globl lwbrx_ppc
lwbrx_ppc:
pc_adjust 0x4
ret

.globl lwz_ppc
lwz_ppc:
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
ldr w0, [x0]
ldr w2, [x19, rDoff] //grab rD number
lsl w2, w2, 2
str w0, [x20, x2] //"load" word into rD, lhz::ppc, yes this is STR!
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lwzu_ppc
lwzu_ppc:
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
ldr w0, [x0]
ldr w2, [x19, rDoff] //grab rD number
lsl w2, w2, 2
str w0, [x20, x2] //"load" word into rD, lwzu::ppc, yes this is STR!
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lwzux_ppc
lwzux_ppc:
pc_adjust 0x4
ret

.globl lwzx_ppc
lwzx_ppc:
pc_adjust 0x4
ret

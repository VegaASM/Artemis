//todo verify-ea on all ins funcs
//todo since arm64 is le, we may need to rev all non-rev loads

.globl lbz_ppc
lbz_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
ldr w2, [x0, doff] //get SIMM value
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA value
add w0, w2, w3 //calc EA
bl verify_data_ea
cbz w0, 0x10
//Call exception address that was returned back
mov w1, w19
blr x0
b lbz_ppc_epilogue
//EA is good, continue with instruction
bl convert
ldrb w0, [x0]
ldr w2, [x19, rDoff] //grab rD number
lsl w2, w2, 2
str w0, [x20, x2] //"load" byte into rD, lbz::ppc, yes this is STR!
pc_adjust 0x4
lbz_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lbzu_ppc
lbzu_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
ldr w2, [x0, doff] //get SIMM value
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x1, x3] //grab rA value
add w0, w2, w4 //calc EA
str w0, [x1, x3] //write new rA value
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
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
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
ldrb w0, [x0]
ldr w2, [x19, rDoff] //grab rD number
lsl w2, w2, 2
str w0, [x20, x2] //"load" byte into rD, lbzux::ppc, yes this is STR!
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lbzx_ppc
lbzx_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
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
ldrb w0, [x0]
ldr w2, [x19, rDoff] //grab rD number
lsl w2, w2, 2
str w0, [x20, x2] //"load" byte into rD, lbzx::ppc, yes this is STR!
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lha_ppc
lha_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
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
mov fp, sp
mov x19, x0
mov x20, x1
ldr w2, [x0, doff] //get SIMM value
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x1, x3] //grab rA value
add w0, w2, w4 //calc EA
str w0, [x1, x3] //write new rA value
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
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
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
ldrsh w0, [x0]
ldr w2, [x19, rDoff] //grab rD number
lsl w2, w2, 2
str w0, [x20, x2] //"load" signed halfword into rD, lhaux::ppc, yes this is STR!
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lhax_ppc
lhax_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
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
ldrsh w0, [x0]
ldr w2, [x19, rDoff] //grab rD number
lsl w2, w2, 2
str w0, [x20, x2] //"load" signed halfword into rD, lhax::ppc, yes this is STR!
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lhbrx_ppc
lhbrx_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
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
ldrh w0, [x0]
rev16 w0, w0
ldr w2, [x19, rDoff] //grab rD number
lsl w2, w2, 2
str w0, [x20, x2] //"load" halfword into rD, lhbrx::ppc, yes this is STR!
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lhz_ppc
lhz_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
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
mov fp, sp
mov x19, x0
mov x20, x1
ldr w2, [x0, doff] //get SIMM value
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x1, x3] //grab rA value
add w0, w2, w4 //calc EA
str w0, [x1, x3] //write new rA value
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
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
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
ldrh w0, [x0]
ldr w2, [x19, rDoff] //grab rD number
lsl w2, w2, 2
str w0, [x20, x2] //"load" halfword into rD, lhzux::ppc, yes this is STR!
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lhzx_ppc
lhzx_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
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
ldrh w0, [x0]
ldr w2, [x19, rDoff] //grab rD number
lsl w2, w2, 2
str w0, [x20, x2] //"load" halfword into rD, lhzx::ppc, yes this is STR!
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
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
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
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
ldr w0, [x0]
rev w0, w0
ldr w2, [x19, rDoff] //grab rD number
lsl w2, w2, 2
str w0, [x20, x2] //"load" word into rD, lwbrx::ppc, yes this is STR!
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lwz_ppc
lwz_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
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
mov fp, sp
mov x19, x0
mov x20, x1
ldr w2, [x0, doff] //get SIMM value
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x1, x3] //grab rA value
add w0, w2, w4 //calc EA
str w0, [x1, x3] //write new rA value
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
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
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
ldr w0, [x0]
ldr w2, [x19, rDoff] //grab rD number
lsl w2, w2, 2
str w0, [x20, x2] //"load" word into rD, lwzux::ppc, yes this is STR!
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lwzx_ppc
lwzx_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
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
ldr w0, [x0]
ldr w2, [x19, rDoff] //grab rD number
lsl w2, w2, 2
str w0, [x20, x2] //"load" word into rD, lwzx::ppc, yes this is STR!
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

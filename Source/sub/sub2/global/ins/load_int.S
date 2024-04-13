//todo verify-ea on all ins funcs, but we need to rewrite and write a bunch of funcs like is_dis_met? and is_isi_met, isi_mce_met? etc etc

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
ldrh w0, [x0]
rev16 w0, w0
sxth w0, w0
rev16 w0, w0
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
ldrh w0, [x0]
rev16 w0, w0
sxth w0, w0
rev16 w0, w0
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
ldrh w0, [x0]
rev16 w0, w0
sxth w0, w0
rev16 w0, w0
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
ldrh w0, [x0]
rev16 w0, w0
sxth w0, w0
rev16 w0, w0
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
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
ldr w2, [x0, doff] //get SIMM value
ldr w3, [x0, rAoff] //get rA number
lsl w3, w21, 2
ldr w3, [x1, x3] //grab rA value
add w0, w2, w3 //calc EA
bl convert
//Set loop counter based on rD's number relative to r31
ldr w2, [x19, rDoff] //grab rD number
sub w3, w2, 32
neg w3, w3
//Set initial rD reg bank ptr
lsl w2, w2, 2
add x2, x20, x2
//do lmw::ppc
ldr w1, [x0], 4
str w1, [x2], 4 //"load" word into current rD, lmw::ppc, yes this is STR!
subs w3, w3, 1
bne -0xC
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lswi_ppc
lswi_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
ldr w0, [x0, rAoff] //get rA number, save in non-volatile register
lsl w0, w0, 2
ldr w0, [x1, x0] //grab rA value
bl convert
//Set loop counter based on NB value
ldr w3, [x19, NBoff] //grab NB value
//Set initial rD reg bank ptr
ldr w2, [x19, rDoff] //grab rD number
lsl w2, w2, 2
add x2, x20, x2 //Set start rD reg bank ptr for loop
//do lswi::ppc
ldrb w1, [x0], 1
strb w1, [x2], 1 //"load" current byte into current rD, lswi::ppc, yes this is STR!
subs w3, w3, 1
bne -0xC
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lswx_ppc
lswx_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
ldr w0, [x0, rAoff] //get rA number, save in non-volatile register
lsl w0, w0, 2
ldr w0, [x1, x0] //grab rA value
bl convert
//Set loop counter based on rB's value
ldr w3, [x19, rBoff] //grab rB number
lsl w3, w3, 2
ldr w3, [x20, x3] //grab rB value
//Set initial rD reg bank ptr
ldr w2, [x19, rDoff] //grab rD number
lsl w2, w2, 2
add x2, x20, x2 //Set start rD reg bank ptr for loop
//do lswx::ppc
ldrb w1, [x0], 1
strb w1, [x2], 1 //"load" current byte into current rD, lswx::ppc, yes this is STR!
subs w3, w3, 1
bne -0xC
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl lwarx_ppc
lwarx_ppc:
//TODO; for now just do standard lwzx
b lwzx_ppc

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

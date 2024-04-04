//todo verify-ea on all ins func's
//todo since arm64 is LE, do we need to rev/16 all the non-reverse stores?

.globl stb_ppc
stb_ppc:
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
ldr w1, [x19, rDoff] //grab rD number
lsl w1, w1, 2
ldr w1, [x19, x1] //grab rD value
strb w1, [x0] //store byte to EA, stb::ppc
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stbu_ppc
stbu_ppc:
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
ldr w1, [x19, rDoff] //grab rD number
lsl w1, w1, 2
ldr w1, [x19, x1] //grab rD value
strb w1, [x0] //store byte to EA, stbu::ppc
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stbux_ppc
stbux_ppc:
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
ldr w1, [x19, rDoff] //grab rD number
lsl w1, w1, 2
ldr w1, [x19, x1] //grab rD value
strb w1, [x0] //store byte to EA, stbux::ppc
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stbx_ppc
stbx_ppc:
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
ldr w1, [x19, rDoff] //grab rD number
lsl w1, w1, 2
ldr w1, [x19, x1] //grab rD value
strb w1, [x0] //store byte to EA, stbux::ppc
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl sth_ppc
sth_ppc:
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
ldr w1, [x19, rDoff] //grab rD number
lsl w1, w1, 2
ldr w1, [x19, x1] //grab rD value
strh w1, [x0] //store halfword to EA, sth::ppc
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl sthbrx_ppc
sthbrx_ppc:
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
ldr w1, [x19, rDoff] //grab rD number
lsl w1, w1, 2
ldr w1, [x19, x1] //grab rD value
rev16 w1, w1 //TODO double check me!
strh w1, [x0] //store byte to EA, sthbrx::ppc
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl sthu_ppc
sthu_ppc:
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
ldr w1, [x19, rDoff] //grab rD number
lsl w1, w1, 2
ldr w1, [x19, x1] //grab rD value
strh w1, [x0] //store halfword to EA, sthu::ppc
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl sthux_ppc
sthux_ppc:
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
ldr w1, [x19, rDoff] //grab rD number
lsl w1, w1, 2
ldr w1, [x19, x1] //grab rD value
strh w1, [x0] //store byte to EA, sthux::ppc
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl sthx_ppc
sthx_ppc:
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
ldr w1, [x19, rDoff] //grab rD number
lsl w1, w1, 2
ldr w1, [x19, x1] //grab rD value
strh w1, [x0] //store byte to EA, sthx::ppc
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stmw_ppc
stmw_ppc:
pc_adjust 0x4
ret

.globl stswi_ppc
stswi_ppc:
pc_adjust 0x4
ret

.globl stswx_ppc
stswx_ppc:
pc_adjust 0x4
ret

.globl stw_ppc
stw_ppc:
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
ldr w1, [x19, rDoff] //grab rD number
lsl w1, w1, 2
ldr w1, [x19, x1] //grab rD value
str w1, [x0] //store word to EA, stw::ppc
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stwbrx_ppc
stwbrx_ppc:
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
ldr w1, [x19, rDoff] //grab rD number
lsl w1, w1, 2
ldr w1, [x19, x1] //grab rD value
rev w1, w1 //TODO double check me!
str w1, [x0] //store byte to EA, stwbrx::ppc
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stwcxRC_ppc
stwcxRC_ppc:
pc_adjust 0x4
ret

.globl stwu_ppc
stwu_ppc:
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
ldr w1, [x19, rDoff] //grab rD number
lsl w1, w1, 2
ldr w1, [x19, x1] //grab rD value
str w1, [x0] //store word to EA, stwu::ppc
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stwux_ppc
stwux_ppc:
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
ldr w1, [x19, rDoff] //grab rD number
lsl w1, w1, 2
ldr w1, [x19, x1] //grab rD value
str w1, [x0] //store byte to EA, stwux::ppc
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stwx_ppc
stwx_ppc:
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
ldr w1, [x19, rDoff] //grab rD number
lsl w1, w1, 2
ldr w1, [x19, x1] //grab rD value
str w1, [x0] //store byte to EA, stwx::ppc
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

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
cmp w3, 0
beq 0xC
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
stbx_ppc: //todo rA literal zero rule
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
cmp w3, 0
beq 0xC
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
sthbrx_ppc: //todo rA literal zero rule
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
sthx_ppc: //todo rA literal zero rule
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
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
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
//Set loop counter based on rS's number relative to r31
ldr w2, [x19, rSoff] //grab rD number
sub w3, w2, 32
neg w3, w3
//Set initial rS reg bank ptr
lsl w2, w2, 2
add x2, x20, x2
//do stmw:ppc
ldr w1, [x2], 4 //grab current rS value in question
str w1, [x0], 4 //store word to EA in question, stmw::ppc
subs w3, w3, 1
bne -0xC
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stswi_ppc
stswi_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
ldr w0, [x0, rAoff] //get rA number
cmp w0, 0
beq 0xC
lsl w0, w0, 2
ldr w0, [x1, x0] //grab rA value
bl convert
//Set loop counter based on NB value
ldr w3, [x19, NBoff] //grab NB value
//Set initial rD reg bank ptr
ldr w2, [x19, rSoff] //grab rS number
lsl w2, w2, 2
add x2, x20, x2
//do stswi::ppc
ldrb w1, [x2], 1 //grab current rS byte value in question
strb w1, [x0], 1 //store byte to EA in question stswi::ppc
subs w3, w3, 1
bne -0xC
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl stswx_ppc
stswx_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
ldr w0, [x0, rAoff] //get rA number
cmp w0, 0
beq 0xC
lsl w0, w0, 2
ldr w0, [x1, x0] //grab rA value
bl convert
//Set loop counter based on rB's value
ldr w3, [x19, rBoff] //grab rB number
lsl w3, w3, 2
ldr w3, [x20, x3] //grab rB value
//Set initial rD reg bank ptr
ldr w2, [x19, rSoff] //grab rS number
lsl w2, w2, 2
add x2, x20, x2
//do stswx::ppc
ldrb w1, [x2], 1 //grab current rS byte value in question
strb w1, [x0], 1 //store byte to EA in question stswx::ppc
subs w3, w3, 1
bne -0xC
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
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
cmp w3, 0
beq 0xC
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
stwbrx_ppc: //todo rA literal zero rule
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
//TODO for now just do stwx
b stwx_ppc
record_feature w3 //TODO

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
stwx_ppc: //todo rA literal zero rule
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

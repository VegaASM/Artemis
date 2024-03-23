.globl b_ppc
b_ppc:
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
ldr w3, [x1, pc]
add w3, w2, w3
str w3, [x1, pc] //b::ppc
ret

.globl ba_ppc
ba_ppc:
//TODO is this even right? does the absolute addr get sign extended????
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
str w2, [x1, pc] //ba::ppc
ret

.globl bl_ppc
bl_ppc:
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc] //bl::ppc
add w3, w2, w3
str w3, [x1, pc] //bl::ppc
ret

.globl bla_ppc
bla_ppc:
//TODO is this even right? does the absolute addr get sign extended????
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc] //bla::ppc
str w3, [x1, pc] //bla::ppc
ret

.globl bc_ppc
bc_ppc:
ldr w2, [x0, BDoff] //load bc SIMM
ldr w3, [x0, BO_nohintoff] //grab BO value
cmp w3, 0 //Check BO Operand Encoding
beq bdnzf_ppc
cmp w3, 1
beq bdzf_ppc
cmp w3, 2
beq bcf_ppc
cmp w3, 4
beq bdnzt_ppc
cmp w3, 5
beq bdzt_ppc
cmp w3, 6
beq bct_ppc
cmp w3, 8
beq bdnz_ppc
cmp w3, 9
beq bdz_ppc
#w2 = 0xA
ldr w4, [x1, pc]
add w4, w2, w4
str w4, [x1, pc]
ret
bdnzf_ppc: //TODO finish these....
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
beq bc_stop
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right bye
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
bne bc_stop //bne is taken is branch is true which is NOT what we want
ldr w3, [x1, pc]
add w3, w3, 2
str w3, [x1, pc] //bdznf::ppc
ret
//TODO put in condition crap
bdzf_ppc:
bcf_ppc:
bdnzt_ppc:
bdzt_ppc:
bct_ppc:
bdnz_ppc:
bdz_ppc:
ret
bc_stop:
ret

.globl bca_ppc
bca_ppc:
ret

.globl bcl_ppc
bcl_ppc:
ret

.globl bcla_ppc
bcla_ppc:
ret

.globl bcctr_ppc
bcctr_ppc:
ret

.globl bcctrl_ppc
bcctrl_ppc:
ret

.globl bclr_ppc
bclr_ppc:
ret

.globl bclrl_ppc
bclrl_ppc:
ret




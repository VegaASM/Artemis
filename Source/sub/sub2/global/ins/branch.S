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

/*==========================*/

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
#w2 = 0xA (branch always)
ldr w4, [x1, pc]
add w4, w2, w4
str w4, [x1, pc]
ret
bdnzf_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
beq 0x30
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
bne 0x10 //bne is taken if branch is true which is NOT what we want
ldr w3, [x1, pc]
add w3, w3, w2
str w3, [x1, pc] //bdnzf::ppc
ret
bdzf_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
bne 0x30
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
bne 0x10 //bne is taken if branch is true which is NOT what we want
ldr w3, [x1, pc]
add w3, w3, w2
str w3, [x1, pc] //bdzf::ppc
ret
bcf_ppc:
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
bne 0x10 //bne is taken if branch is true which is NOT what we want
ldr w3, [x1, pc]
add w3, w3, w2
str w3, [x1, pc] //bcf::ppc
ret
bdnzt_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
beq 0x30
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
beq 0x10
ldr w3, [x1, pc]
add w3, w3, w2
str w3, [x1, pc] //bdznt::ppc
ret
bdzt_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
bne 0x30
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
beq 0x10
ldr w3, [x1, pc]
add w3, w3, w2
str w3, [x1, pc] //bdnzt::ppc
ret
bct_ppc:
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
beq 0x10
ldr w3, [x1, pc]
add w3, w3, w2
str w3, [x1, pc] //bct::ppc
ret
bdnz_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
beq 0x10
ldr w3, [x1, pc]
add w3, w3, w2
str w3, [x1, pc] //bdnz::ppc
ret
bdz_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
bne 0x10
ldr w3, [x1, pc]
add w3, w3, w2
str w3, [x1, pc] //bdz::ppc
ret

/*==========================*/

.globl bca_ppc
bca_ppc:
ldr w2, [x0, BDoff] //load bc SIMM
ldr w3, [x0, BO_nohintoff] //grab BO value
cmp w3, 0 //Check BO Operand Encoding
beq bdnzfa_ppc
cmp w3, 1
beq bdzfa_ppc
cmp w3, 2
beq bcfa_ppc
cmp w3, 4
beq bdnzta_ppc
cmp w3, 5
beq bdzta_ppc
cmp w3, 6
beq bcta_ppc
cmp w3, 8
beq bdnza_ppc
cmp w3, 9
beq bdza_ppc
#w2 = 0xA (branch always)
ldr w4, [x0, LI_SIMMoff]
str w4, [x1, pc]
ret
bdnzfa_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
beq 0x2C
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
bne 0xC //bne is taken if branch is true which is NOT what we want
ldr w4, [x0, LI_SIMMoff]
str w4, [x1, pc]
ret
bdzfa_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
bne 0x2C
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
bne 0xC //bne is taken if branch is true which is NOT what we want
ldr w4, [x0, LI_SIMMoff]
str w4, [x1, pc]
ret
bcfa_ppc:
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
bne 0xC //bne is taken if branch is true which is NOT what we want
ldr w4, [x0, LI_SIMMoff]
str w4, [x1, pc]
ret
bdnzta_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
beq 0x2C
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
beq 0xC
ldr w4, [x0, LI_SIMMoff]
str w4, [x1, pc]
ret
bdzta_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
bne 0x2C
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
beq 0xC
ldr w4, [x0, LI_SIMMoff]
str w4, [x1, pc]
ret
bcta_ppc:
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
beq 0xC
ldr w4, [x0, LI_SIMMoff]
str w4, [x1, pc]
ret
bdnza_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
beq 0xC
ldr w4, [x0, LI_SIMMoff]
str w4, [x1, pc]
ret
bdza_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
bne 0xC
ldr w4, [x0, LI_SIMMoff]
str w4, [x1, pc]
ret

/*==========================*/

.globl bcl_ppc
bcl_ppc:
ldr w2, [x0, BDoff] //load bc SIMM
ldr w3, [x0, BO_nohintoff] //grab BO value
cmp w3, 0 //Check BO Operand Encoding
beq bdnzfl_ppc
cmp w3, 1
beq bdzfl_ppc
cmp w3, 2
beq bcfl_ppc
cmp w3, 4
beq bdnztl_ppc
cmp w3, 5
beq bdztl_ppc
cmp w3, 6
beq bctl_ppc
cmp w3, 8
beq bdnzl_ppc
cmp w3, 9
beq bdzl_ppc
#w2 = 0xA (branch always)
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc]
add w3, w2, w3
str w3, [x1, pc]
ret
bdnzfl_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
beq 0x3C
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
bne 0x1C //bne is taken if branch is true which is NOT what we want
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc]
add w3, w2, w3
str w3, [x1, pc]
ret
bdzfl_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
bne 0x3C
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
bne 0x1C //bne is taken if branch is true which is NOT what we want
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc]
add w3, w2, w3
str w3, [x1, pc]
ret
bcfl_ppc:
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
bne 0x1C //bne is taken if branch is true which is NOT what we want
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc]
add w3, w2, w3
str w3, [x1, pc]
ret
bdnztl_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
beq 0x3C
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
beq 0x1C
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc]
add w3, w2, w3
str w3, [x1, pc]
ret
bdztl_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
bne 0x3C
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
beq 0x1C
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc]
add w3, w2, w3
str w3, [x1, pc]
ret
bctl_ppc:
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
beq 0x1C
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc]
add w3, w2, w3
str w3, [x1, pc]
ret
bdnzl_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
beq 0x1C
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc]
add w3, w2, w3
str w3, [x1, pc]
ret
bdzl_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
bne 0x1C
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc]
add w3, w2, w3
str w3, [x1, pc]
ret

/*==========================*/

.globl bcla_ppc
bcla_ppc:
ldr w2, [x0, BDoff] //load bc SIMM
ldr w3, [x0, BO_nohintoff] //grab BO value
cmp w3, 0 //Check BO Operand Encoding
beq bdnzfla_ppc
cmp w3, 1
beq bdzfla_ppc
cmp w3, 2
beq bcfla_ppc
cmp w3, 4
beq bdnztla_ppc
cmp w3, 5
beq bdztla_ppc
cmp w3, 6
beq bctla_ppc
cmp w3, 8
beq bdnzla_ppc
cmp w3, 9
beq bdzla_ppc
#w2 = 0xA (branch always)
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc] //bla::ppc
str w3, [x1, pc] //bla::ppc
ret
bdnzfla_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
beq 0x38
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
bne 0x18 //bne is taken if branch is true which is NOT what we want
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc] //bla::ppc
str w3, [x1, pc] //bla::ppc
ret
bdzfla_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
bne 0x38
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
bne 0x18 //bne is taken if branch is true which is NOT what we want
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc] //bla::ppc
str w3, [x1, pc] //bla::ppc
ret
bcfla_ppc:
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
bne 0x18 //bne is taken if branch is true which is NOT what we want
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc] //bla::ppc
str w3, [x1, pc] //bla::ppc
ret
bdnztla_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
beq 0x38
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
beq 0x18
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc] //bla::ppc
str w3, [x1, pc] //bla::ppc
ret
bdztla_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
bne 0x38
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
beq 0x18
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc] //bla::ppc
str w3, [x1, pc] //bla::ppc
ret
bctla_ppc:
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
beq 0x18
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc] //bla::ppc
str w3, [x1, pc] //bla::ppc
ret
bdnzla_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
beq 0x18
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc] //bla::ppc
str w3, [x1, pc] //bla::ppc
ret
bdzla_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
bne 0x18
ldr w2, [x0, LI_SIMMoff] //Load 26-bit SIMM
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc] //bla::ppc
str w3, [x1, pc] //bla::ppc
ret

/*==========================*/

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

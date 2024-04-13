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
str w2, [x1, pc] //bla::ppc
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
str w4, [x1, lrppc] //bcla::ppc
str w3, [x1, pc] //bcla::ppc
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
str w4, [x1, lrppc] //bcla::ppc
str w2, [x1, pc] //bcla::ppc
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
str w4, [x1, lrppc] //bcla::ppc
str w2, [x1, pc] //bcla::ppc
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
str w4, [x1, lrppc] //bcla::ppc
str w2, [x1, pc] //bcla::ppc
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
str w4, [x1, lrppc] //bcla::ppc
str w2, [x1, pc] //bcla::ppc
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
str w4, [x1, lrppc] //bcla::ppc
str w2, [x1, pc] //bcla::ppc
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
str w4, [x1, lrppc] //bcla::ppc
str w2, [x1, pc] //bcla::ppc
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
str w4, [x1, lrppc] //bcla::ppc
str w2, [x1, pc] //bcla::ppc
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
str w4, [x1, lrppc] //bcla::ppc
str w2, [x1, pc] //bcla::ppc
ret

/*==========================*/

.globl bcctr_ppc
bcctr_ppc:
ldr w3, [x0, BO_nohintoff] //grab BO value
cmp w3, 0 //Check BO Operand Encoding
beq bdnzfctr_ppc
cmp w3, 1
beq bdzfctr_ppc
cmp w3, 2
beq bcfctr_ppc
cmp w3, 4
beq bdnztctr_ppc
cmp w3, 5
beq bdztctr_ppc
cmp w3, 6
beq bctctr_ppc
cmp w3, 8
beq bdnzctr_ppc
cmp w3, 9
beq bdzctr_ppc
#w2 = 0xA (branch always)
ldr w4, [x1, ctr]
str w4, [x1, pc]
ret
bdnzfctr_ppc:
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
ldr w3, [x1, ctr]
str w3, [x1, pc] //bdnzfctr::ppc
ret
bdzfctr_ppc:
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
ldr w3, [x1, ctr]
str w3, [x1, pc] //bdzfctr::ppc
ret
bcfctr_ppc:
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
bne 0xC //bne is taken if branch is true which is NOT what we want
ldr w3, [x1, ctr]
str w3, [x1, pc] //bcfctr::ppc
ret
bdnztctr_ppc:
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
ldr w3, [x1, ctr]
str w3, [x1, pc] //bdzntctr::ppc
ret
bdztctr_ppc:
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
ldr w3, [x1, ctr]
str w3, [x1, pc] //bdnztctr::ppc
ret
bctctr_ppc:
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
beq 0xC
ldr w3, [x1, ctr]
str w3, [x1, pc] //bctctr::ppc
ret
bdnzctr_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
beq 0xC
ldr w3, [x1, ctr]
str w3, [x1, pc] //bdnzctr::ppc
ret
bdzctr_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
bne 0xC
ldr w3, [x1, ctr]
str w3, [x1, pc] //bdzctr::ppc
ret

/*==========================*/

.globl bcctrl_ppc
bcctrl_ppc:
ldr w3, [x0, BO_nohintoff] //grab BO value
cmp w3, 0 //Check BO Operand Encoding
beq bdnzfctrl_ppc
cmp w3, 1
beq bdzfctrl_ppc
cmp w3, 2
beq bcfctrl_ppc
cmp w3, 4
beq bdnztctrl_ppc
cmp w3, 5
beq bdztctrl_ppc
cmp w3, 6
beq bctctrl_ppc
cmp w3, 8
beq bdnzctrl_ppc
cmp w3, 9
beq bdzctrl_ppc
#w2 = 0xA (branch always)
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc]
ldr w3, [x1, ctr]
str w3, [x1, pc]
ret
bdnzfctrl_ppc:
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
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc]
ldr w3, [x1, ctr]
str w3, [x1, pc]
ret
bdzfctrl_ppc:
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
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc]
ldr w3, [x1, ctr]
str w3, [x1, pc]
ret
bcfctrl_ppc:
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
bne 0x18 //bne is taken if branch is true which is NOT what we want
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc]
ldr w3, [x1, ctr]
str w3, [x1, pc]
ret
bdnztctrl_ppc:
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
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc]
ldr w3, [x1, ctr]
str w3, [x1, pc]
ret
bdztctrl_ppc:
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
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc]
ldr w3, [x1, ctr]
str w3, [x1, pc]
ret
bctctrl_ppc:
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
beq 0x18
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc]
ldr w3, [x1, ctr]
str w3, [x1, pc]
ret
bdnzctrl_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
beq 0x18
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc]
ldr w3, [x1, ctr]
str w3, [x1, pc]
ret
bdzctrl_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
bne 0x18
ldr w3, [x1, pc]
add w4, w3, 4
str w4, [x1, lrppc]
ldr w3, [x1, ctr]
str w3, [x1, pc]
ret

/*==========================*/

.globl bclr_ppc
bclr_ppc:
ldr w3, [x0, BO_nohintoff] //grab BO value
cmp w3, 0 //Check BO Operand Encoding
beq bdnzflr_ppc
cmp w3, 1
beq bdzflr_ppc
cmp w3, 2
beq bcflr_ppc
cmp w3, 4
beq bdnztlr_ppc
cmp w3, 5
beq bdztlr_ppc
cmp w3, 6
beq bctlr_ppc
cmp w3, 8
beq bdnzlr_ppc
cmp w3, 9
beq bdzlr_ppc
#w2 = 0xA (branch always)
ldr w4, [x1, lr]
str w4, [x1, pc]
ret
bdnzflr_ppc:
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
ldr w3, [x1, lr]
str w3, [x1, pc] //bdnzflr::ppc
ret
bdzflr_ppc:
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
ldr w3, [x1, lr]
str w3, [x1, pc] //bdzflr::ppc
ret
bcflr_ppc:
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
bne 0xC //bne is taken if branch is true which is NOT what we want
ldr w3, [x1, lr]
str w3, [x1, pc] //bcflr::ppc
ret
bdnztlr_ppc:
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
ldr w3, [x1, lr]
str w3, [x1, pc] //bdzntlr::ppc
ret
bdztlr_ppc:
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
ldr w3, [x1, lr]
str w3, [x1, pc] //bdnztlr::ppc
ret
bctlr_ppc:
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
beq 0xC
ldr w3, [x1, lr]
str w3, [x1, pc] //bctlr::ppc
ret
bdnzlr_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
beq 0xC
ldr w3, [x1, lr]
str w3, [x1, pc] //bdnzlr::ppc
ret
bdzlr_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
bne 0xC
ldr w3, [x1, lr]
str w3, [x1, pc] //bdzlr::ppc
ret

/*==========================*/

.globl bclrl_ppc
bclrl_ppc:
ldr w3, [x0, BO_nohintoff] //grab BO value
cmp w3, 0 //Check BO Operand Encoding
beq bdnzflrl_ppc
cmp w3, 1
beq bdzflrl_ppc
cmp w3, 2
beq bcflrl_ppc
cmp w3, 4
beq bdnztlrl_ppc
cmp w3, 5
beq bdztlrl_ppc
cmp w3, 6
beq bctlrl_ppc
cmp w3, 8
beq bdnzlrl_ppc
cmp w3, 9
beq bdzlrl_ppc
#w2 = 0xA (branch always)
ldr w3, [x1, pc]
add w4, w3, 4
ldr w5, [x1, lrppc]
str w4, [x1, lrppc]
str w5, [x1, pc]
ret
bdnzflrl_ppc:
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
ldr w3, [x1, pc]
add w4, w3, 4
ldr w5, [x1, lrppc]
str w4, [x1, lrppc]
str w5, [x1, pc]
ret
bdzflrl_ppc:
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
ldr w3, [x1, pc]
add w4, w3, 4
ldr w5, [x1, lrppc]
str w4, [x1, lrppc]
str w5, [x1, pc]
ret
bcflrl_ppc:
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
bne 0x18 //bne is taken if branch is true which is NOT what we want
ldr w3, [x1, pc]
add w4, w3, 4
ldr w5, [x1, lrppc]
str w4, [x1, lrppc]
str w5, [x1, pc]
ret
bdnztlrl_ppc:
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
ldr w3, [x1, pc]
add w4, w3, 4
ldr w5, [x1, lrppc]
str w4, [x1, lrppc]
str w5, [x1, pc]
ret
bdztlrl_ppc:
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
ldr w3, [x1, pc]
add w4, w3, 4
ldr w5, [x1, lrppc]
str w4, [x1, lrppc]
str w5, [x1, pc]
ret
bctlrl_ppc:
ldr w4, [x0, BIoff] //this loads BI's VALUE, not a number to lsl..
ldr w5, [x1, cr] //grab CR value
sub w4, w4, 31
neg w4, w4 //this gives us value to rotate right by
ror w5, w5, w4 //This will place the bit we need on LSB slot
and w5, w5, 0xFFFFFFFE //only leave LSB
cmp w5, 0
beq 0x18
ldr w3, [x1, pc]
add w4, w3, 4
ldr w5, [x1, lrppc]
str w4, [x1, lrppc]
str w5, [x1, pc]
ret
bdnzlrl_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
beq 0x18
ldr w3, [x1, pc]
add w4, w3, 4
ldr w5, [x1, lrppc]
str w4, [x1, lrppc]
str w5, [x1, pc]
ret
bdzlrl_ppc:
ldr w4, [x1, ctr] //grab CTR value
sub w4, w4, 1
str w4, [x1, ctr]
cmp w4, 0
bne 0x18
ldr w3, [x1, pc]
add w4, w3, 4
ldr w5, [x1, lrppc]
str w4, [x1, lrppc]
str w5, [x1, pc]
ret

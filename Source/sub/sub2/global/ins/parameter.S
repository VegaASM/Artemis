/*#include "extractedPPCstuffOffsets.S" already defined in disassemble.S*/

.macro pc_adjust amount
ldr x1, [x27, 0x20]
ldr w0, [x1, pc]
add w0, w0, \amount
str w0, [x1, pc]
.endm

//add rD rA rB
.globl add_ppc
add_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
add w3, w3, w4 //add::ppc
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

.globl addRC_ppc
addRC_ppc:
ret

.globl addo_ppc
addo_ppc:
ret

.globl addoRC_ppc
addoRC_ppc:
ret

.globl addc_ppc
addc_ppc:
ret

.globl addcRC_ppc
addcRC_ppc:
ret

.globl addco_ppc
addco_ppc:
ret

.globl addcoRC_ppc
addcoRC_ppc:
ret

.globl adde_ppc
adde_ppc:
ret

.globl addeRC_ppc
addeRC_ppc:
ret

.globl addeo_ppc
addeo_ppc:
ret

.globl addeoRC_ppc
addeoRC_ppc:
ret

//addi rD, rA, SIMM
.globl addi_ppc
addi_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
cmp w3, 0
lsl w3, w3, 2
ldr w4, [x0, SIMMoff] //get SIMM
beq 0x8
ldr w3, [x1, x3] //grab rA's value
add w3, w3, w4 //addi::ppc
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

//addic rD, rA, SIMM
.globl addic_ppc
addic_ppc:
ret

//addic. rD, rA, SIMM
.globl addicRC_ppc
addicRC_ppc:
ret

//addis rD, rA, SIMM
.globl addis_ppc
addis_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
cmp w3, 0
lsl w3, w3, 2
ldr w4, [x0, UIMMoff] //get UIMM
beq 0x8
ldr w3, [x1, x3] //grab rA's value
lsl w4, w4, 16 //addis::ppc
add w3, w3, w4 //addis::ppc
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

//addme rD, rA
.globl addme_ppc
addme_ppc:

//addme. rD, rA
.globl addmeRC_ppc
addmeRC_ppc:

//addmeo rD, rA
.globl addmeo_ppc
addmeo_ppc:

//addmeo. rD, rA
.globl addmeoRC_ppc
addmeoRC_ppc:

//addze rD, rA
.globl addze_ppc
addze_ppc:

//addze. rD, rA
.globl addzeRC_ppc
addzeRC_ppc:

//addzeo rD, rA
.globl addzeo_ppc
addzeo_ppc:

//addzeo. rD, rA
.globl addzeoRC_ppc
addzeoRC_ppc:

//and rA, rS, rB
.globl and_ppc
and_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
and w3, w3, w4 //and::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//and. rA, rS, rB
.globl andRC_ppc
andRC_ppc:

//andc rA, rS, rB
.globl andc_ppc
andc_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
bic w3, w3, w4 //andc::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//andc. rA, rS, rB
.globl andcRC_ppc
andcRC_ppc:
ret

//andi. rA, rS, UIMM
.globl andiRC_ppc
andiRC_ppc:
ret

//andis. rA, rS, UIMM
.globl andisRC_ppc
andisRC_ppc:
ret

//divw
.globl divw_ppc
divw_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
sdiv w3, w3, w4 //divw::ppc
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

//divwu
.globl divwu_ppc
divwu_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
udiv w3, w3, w4 //divwu::ppc
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

//eqv/xnor
.globl eqv_ppc
eqv_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
eor w3, w3, w4 //eqv::ppc
mvn w3, w3 //eqv::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//extsb
.globl extsb_ppc
extsb_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rS's value
sxtb w3, w3 //extsb::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//extsh
.globl extsh_ppc
extsh_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rS's value
sxth w3, w3 //extsh::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//nand
.globl nand_ppc
nand_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
and w3, w3, w4 //nand::ppc
mvn w3, w3 //nand::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//neg
.globl neg_ppc
neg_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA's value
neg w3, w3 //neg::ppc
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

//nor
.globl nor_ppc
nor_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
orr w3, w3, w4 //nor::ppc
mvn w3, w3 //nor::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//or
.globl or_ppc
or_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
orr w3, w3, w4 //or::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//orc
.globl orc_ppc
orc_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
orn w3, w3, w4 //orc::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//ori
.globl ori_ppc
ori_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, UIMMoff] //get UIMM
ldr w3, [x1, x3] //grab rS's value
orr w3, w3, w4 //ori::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//oris
.globl oris_ppc
oris_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, UIMMoff] //get UIMM
ldr w3, [x1, x3] //grab rS's value
lsl w4, w4, 16 //oris::ppc
orr w3, w3, w4 //oris::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//xor
.globl xor_ppc
xor_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
eor w3, w3, w4 //xor::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//xori
.globl xori_ppc
xori_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, UIMMoff] //get UIMM
ldr w3, [x1, x3] //grab rS's value
eor w3, w3, w4 //xori::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//xoris
.globl xoris_ppc
xoris_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, UIMMoff] //get UIMM
ldr w3, [x1, x3] //grab rS's value
lsl w4, w4, 16 //xoris::ppc
eor w3, w3, w4 //xoris::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret


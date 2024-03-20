/*#include "extractedPPCstuffOffsets.S" already defined in disassemble.S*/

/*x0 = extracted pcp items ptr, register numbers (NOT values) and IMMs reside here*/
/*x1 = register bank ppc ptr (register VALUES reside here)*/

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
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
add w3, w3, w4 //addRC::ppc
str w3, [x1, x2] //write rD
record_feature w3
pc_adjust 0x4
ret

.globl addo_ppc
addo_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
adds w3, w3, w4 //addo::ppc
str w3, [x1, x2] //write rD
oe_feature
pc_adjust 0x4
ret

.globl addoRC_ppc
addoRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
adds w3, w3, w4 //addo::ppc
str w3, [x1, x2] //write rD
oe_feature
record_feature w3
pc_adjust 0x4
ret

.globl addc_ppc
addc_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
adds w3, w3, w4 //addc::ppc
str w3, [x1, x2] //write rD
mrs x5, NZCV //grab ARM64 flags
ubfx w5, w5, 29, 1 //extract Carry flag
ldr w6, [x1, xer] //grab ppc xer value
bfi w6, w5, 29, 1 //replace xer's current carry flag
str w6, [x1, xer] //update ppc xer value
pc_adjust 0x4
ret

.globl addcRC_ppc
addcRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
adds w3, w3, w4 //addc::ppc
str w3, [x1, x2] //write rD
mrs x5, NZCV //grab ARM64 flags
ubfx w5, w5, 29, 1 //extract Carry flag
ldr w6, [x1, xer] //grab ppc xer value
bfi w6, w5, 29, 1 //replace xer's current carry flag
str w6, [x1, xer] //update ppc xer value
record_feature w3
pc_adjust 0x4
ret

.globl addco_ppc
addco_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
adds w3, w3, w4 //addc::ppc
str w3, [x1, x2] //write rD
mrs x5, NZCV //grab ARM64 flags
ubfx w5, w5, 29, 1 //extract Carry flag
ldr w6, [x1, xer] //grab ppc xer value
bfi w6, w5, 29, 1 //replace xer's current carry flag
str w6, [x1, xer] //update ppc xer value
oe_feature
pc_adjust 0x4
ret

.globl addcoRC_ppc
addcoRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
adds w3, w3, w4 //addc::ppc
str w3, [x1, x2] //write rD
mrs x5, NZCV //grab ARM64 flags
ubfx w5, w5, 29, 1 //extract Carry flag
ldr w6, [x1, xer] //grab ppc xer value
bfi w6, w5, 29, 1 //replace xer's current carry flag
str w6, [x1, xer] //update ppc xer value
oe_feature
record_feature w3
pc_adjust 0x4
ret

.globl adde_ppc
adde_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
add w3, w3, w4 //adde::ppc
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
add w3, w3, w5 //adde::ppc
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

.globl addeRC_ppc
addeRC_ppc:
//TODO figure out how to do adde , addze, addme withusing current CA bit because using an adds instruciton will edit our CA bit!
//We may be good for adde. addme. and addze. cuz we should be able to do regular add THEN the rc macro
//But setting SO weill be an issue cuz we need and addS arm64 instruction
pc_adjust 0x4
ret

.globl addeo_ppc
addeo_ppc:
pc_adjust 0x4
ret

.globl addeoRC_ppc
addeoRC_ppc:
pc_adjust 0x4
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
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
cmp w3, 0
lsl w3, w3, 2
ldr w4, [x0, SIMMoff] //get SIMM
beq 0x8
ldr w3, [x1, x3] //grab rA's value
add w3, w3, w4 //addic::ppc
str w3, [x1, x2] //write rD
mrs x5, NZCV //grab ARM64 flags
ubfx w5, w5, 29, 1 //extract Carry flag
ldr w6, [x1, xer] //grab ppc xer value
bfi w6, w5, 29, 1 //replace xer's current carry flag
str w6, [x1, xer] //update ppc xer value
pc_adjust 0x4
ret

//addic. rD, rA, SIMM
.globl addicRC_ppc
addicRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
cmp w3, 0
lsl w3, w3, 2
ldr w4, [x0, SIMMoff] //get SIMM
beq 0x8
ldr w3, [x1, x3] //grab rA's value
add w3, w3, w4 //addic::ppc
str w3, [x1, x2] //write rD
mrs x5, NZCV //grab ARM64 flags
ubfx w5, w5, 29, 1 //extract Carry flag
ldr w6, [x1, xer] //grab ppc xer value
bfi w6, w5, 29, 1 //replace xer's current carry flag
str w6, [x1, xer] //update ppc xer value
record_feature w3
pc_adjust 0x4
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
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA's value
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
add w3, w3, w5 //addme::ppc
mov w4, -1 //addme::ppc NOTE addme = rA + CA + 0xFFFFFFFF according to BW manual
add w3, w3, w4 //addme::ppc
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

//addme. rD, rA
.globl addmeRC_ppc
addmeRC_ppc:
pc_adjust 0x4
ret

//addmeo rD, rA
.globl addmeo_ppc
addmeo_ppc:
pc_adjust 0x4
ret

//addmeo. rD, rA
.globl addmeoRC_ppc
addmeoRC_ppc:
pc_adjust 0x4
ret

//addze rD, rA
.globl addze_ppc
addze_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA's value
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
add w3, w3, w5 //addze::ppc
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

//addze. rD, rA
.globl addzeRC_ppc
addzeRC_ppc:
pc_adjust 0x4
ret

//addzeo rD, rA
.globl addzeo_ppc
addzeo_ppc:
pc_adjust 0x4
ret

//addzeo. rD, rA
.globl addzeoRC_ppc
addzeoRC_ppc:
pc_adjust 0x4
ret

//cmp
.globl cmp_ppc
cmp_ppc:
pc_adjust 0x4
ret

//cmpi
.globl cmpi_ppc
cmpi_ppc:
pc_adjust 0x4
ret

//cmpl
.globl cmpl_ppc
cmpl_ppc:
pc_adjust 0x4
ret

//cmpli
.globl cmpli_ppc
cmpli_ppc:
pc_adjust 0x4
ret

//cntlzw
.globl cntlzw_ppc
cntlzw_ppc:
pc_adjust 0x4
ret

//cntlzw
.globl cntlzwRC_ppc
cntlzwRC_ppc:
pc_adjust 0x4
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

//divw.
.globl divwRC_ppc
divwRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
sdiv w3, w3, w4 //divwRC::ppc
str w3, [x1, x2] //write rD
record_feature w3
pc_adjust 0x4
ret

//divwo
.globl divwo_ppc
divwo_ppc:
pc_adjust 0x4
ret

//divwo.
.globl divwoRC_ppc
divwoRC_ppc:
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

//divwu.
.globl divwuRC_ppc
divwuRC_ppc:
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
record_feature w3
pc_adjust 0x4
ret

//divwuo
.globl divwuo_ppc
divwuo_ppc:
pc_adjust 0x4
ret

//divwuo.
.globl divwuoRC_ppc
divwuoRC_ppc:
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

//extsb.
.globl extsbRC_ppc
extsbRC_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rS's value
sxtb w3, w3 //extsbRC::ppc
str w3, [x1, x2] //write rA
record_feature w3
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

//extsh
.globl extshRC_ppc
extshRC_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rS's value
sxth w3, w3 //extshRC::ppc
str w3, [x1, x2] //write rA
record_feature w3
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

//neg.
.globl negRC_ppc
negRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA's value
neg w3, w3 //negRC::ppc
str w3, [x1, x2] //write rD
record_feature w3
pc_adjust 0x4
ret

//nego
//TODO figure out how to set SO in the nego and nego. instructions
.globl nego_ppc
nego_ppc:
pc_adjust 0x4
ret

//nego.
//TODO figure out how to set SO in the nego and nego. instructions
.globl negoRC_ppc
negoRC_ppc:
pc_adjust 0x4
ret




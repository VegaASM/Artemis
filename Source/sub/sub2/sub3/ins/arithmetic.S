/*#include "extractedPPCstuffOffsets.S" already defined in disassemble.S*/

/*x0 = extracted pcp items ptr, register numbers (NOT values) and IMMs reside here*/
/*x1 = register bank ppc ptr (register VALUES reside here)*/

//add rD, rA, rB
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

//add. rD, rA, rB
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

//addo rD, rA, rB
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

//addo. rD, rA, rB
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

//addc rD, rA, rB; & set XER[CA]
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

//addc. rD, rA, rB
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

//addco rD, rA, rB
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

//addco. rD, rA, rB
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
add w3, w3, w5 //adde::ppc, rD = rA + rB + XER[CA]
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

.globl addeRC_ppc
addeRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
add w3, w3, w4 //addeRC::ppc
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
add w3, w3, w5 //addeRC::ppc, rD = rA + rB + XER[CA]; and do cmpwi rD, 0
str w3, [x1, x2] //write rD
record_feature w3
pc_adjust 0x4
ret

.globl addeo_ppc
addeo_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
adds w3, w3, w4 //addeRC::ppc; set V flag for later use of oe_feature macro
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
add w3, w3, w5 //addeRC::ppc, rD = rA + rB + XER[CA]; and adjust XER SO+OV
str w3, [x1, x2] //write rD
oe_feature
pc_adjust 0x4
ret

.globl addeoRC_ppc
addeoRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
adds w3, w3, w4 //addeRC::ppc; set V flag for later use of oe_feature macro
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
add w3, w3, w5 //addeRC::ppc, rD = rA + rB + XER[CA]; and do cmpwi rD, 0and adjust XER SO+OV
str w3, [x1, x2] //write rD
oe_feature
record_feature w3
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
lsl w3, w3, 2
ldr w4, [x0, SIMMoff] //get SIMM
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
lsl w3, w3, 2
ldr w4, [x0, SIMMoff] //get SIMM
ldr w3, [x1, x3] //grab rA's value
add w3, w3, w4 //addicRC::ppc
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
mov w4, -1 //addme::ppc NOTE addme = rA + XER[CA] + 0xFFFFFFFF
add w3, w3, w4 //addme::ppc
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

//addme. rD, rA
.globl addmeRC_ppc
addmeRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA's value
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
add w3, w3, w5 //addmeRC::ppc
mov w4, -1 //addmeRC::ppc, rD = rA + XER[CA] + 0xFFFFFFFF
add w3, w3, w4 //addmeRC::ppc
str w3, [x1, x2] //write rD
record_feature w3
pc_adjust 0x4
ret

//addmeo rD, rA
.globl addmeo_ppc
addmeo_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA's value
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
adds w3, w3, w5 //addmeo::ppc, set ARM64 V flag for oe_feature macro
mov w4, -1 //addmeo::ppc, rD = rA + XER[CA] + 0xFFFFFFFF
add w3, w3, w4 //addmeo::ppc
str w3, [x1, x2] //write rD
oe_feature
pc_adjust 0x4
ret

//addmeo. rD, rA
.globl addmeoRC_ppc
addmeoRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA's value
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
adds w3, w3, w5 //addmeoRC::ppc, set ARM64 V flag for oe_feature macro
mov w4, -1 //addmeoRC::ppc, rD = rA + XER[CA] + 0xFFFFFFFF
add w3, w3, w4 //addmeoRC::ppc
str w3, [x1, x2] //write rD
oe_feature
record_feature w3
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
add w3, w3, w5 //addze::ppc, rD = rA + XER[CA]
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

//addze. rD, rA
.globl addzeRC_ppc
addzeRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA's value
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
add w3, w3, w5 //addze::ppc, rD = rA + XER[CA]
str w3, [x1, x2] //write rD
record_feature w3
pc_adjust 0x4
ret

//addzeo rD, rA
.globl addzeo_ppc
addzeo_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA's value
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
adds w3, w3, w5 //addze::ppc, rD = rA + XER[CA]; set ARM64 V flag for oe_feature macro
str w3, [x1, x2] //write rD
oe_feature
pc_adjust 0x4
ret

//addzeo. rD, rA
.globl addzeoRC_ppc
addzeoRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA's value
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
adds w3, w3, w5 //addze::ppc, rD = rA + XER[CA]; set ARM64 V flag for oe_feature macro
str w3, [x1, x2] //write rD
oe_feature
record_feature w3
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
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
sdiv w3, w3, w4 //divwRC::ppc
ldr w5, [x1, x2] //grab current rD value
oe_feature_dmn w3 w5
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

//divwo.
.globl divwoRC_ppc
divwoRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
sdiv w3, w3, w4 //divwRC::ppc
ldr w5, [x1, x2] //grab current rD value
oe_feature_dmn w3 w5
str w3, [x1, x2] //write rD
record_feature w3
pc_adjust 0x4
ret

//divwu rD, rA, rB
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

//divwu. rD, rA, rB
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

//divwuo rD, rA, rB
.globl divwuo_ppc
divwuo_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
udiv w3, w3, w4 //divwu::ppc
ldr w5, [x1, x2] //grab current rD value
oe_feature_dmn w3 w5
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

//divwuo. rD, rA, rB
.globl divwuoRC_ppc
divwuoRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
udiv w3, w3, w4 //divwu::ppc
ldr w5, [x1, x2] //grab current rD value
oe_feature_dmn w3 w5
str w3, [x1, x2] //write rD
record_feature w3
pc_adjust 0x4
ret

//mulhw rD, rA, rB
.globl mulhw_ppc
mulhw_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
smull x3, w3, w4 //mulhw::ppc
asr x3, x3, 32 //place upper 32-bits of 64-bit signed result into lower 32-bits of register
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

//mulhw. rD, rA, rB
.globl mulhwRC_ppc
mulhwRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
smull x3, w3, w4 //mulhw::ppc
asr x3, x3, 32 //place upper 32-bits of 64-bit signed result into lower 32-bits of register
str w3, [x1, x2] //write rD
record_feature w3
pc_adjust 0x4
ret

//mulhwu rD, rA, rB
.globl mulhwu_ppc
mulhwu_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
umull x3, w3, w4 //mulhwu::ppc
lsr x3, x3, 32 //place upper 32-bits of 64-bit unsigned result into lower 32-bits of register
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

//mulhwu. rD, rA, rB
.globl mulhwuRC_ppc
mulhwuRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
umull x3, w3, w4 //mulhwu::ppc
lsr x3, x3, 32 //place upper 32-bits of 64-bit unsigned result into lower 32-bits of register
str w3, [x1, x2] //write rD
record_feature w3
pc_adjust 0x4
ret

//mulli rD, rA, SIMM
.globl mulli_ppc
mulli_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, SIMMoff] //get SIMM
ldr w3, [x1, x3] //grab rA's value
mul w3, w3, w4 //mulli::ppc
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

//mullw rD, rA, rB
.globl mullw_ppc
mullw_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
mul w3, w3, w4 //mullw::ppc
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

//mullw. rD, rA, rB
.globl mullwRC_ppc
mullwRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
mul w3, w3, w4 //mullwRC::ppc
str w3, [x1, x2] //write rD
record_feature w3
pc_adjust 0x4
ret

//mullwo rD, rA, rB
.globl mullwo_ppc
mullwo_ppc:
//TODO stuff most likely wrong cuz it overflow looks at 64-bit, not 32-bit
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
mul w3, w3, w4 //mullwRC::ppc
ldr w5, [x1, x2] //grab current rD value
oe_feature_dmn w3 w5
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

//mullwo. rD, rA, rB
.globl mullwoRC_ppc
mullwoRC_ppc:
//TODO stuff most likely wrong cuz it overflow looks at 64-bit, not 32-bit
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
mul w3, w3, w4 //mullwRC::ppc
ldr w5, [x1, x2] //grab current rD value
oe_feature_dmn w3 w5
str w3, [x1, x2] //write rD
record_feature w3
pc_adjust 0x4
ret

//neg rD, rA
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

//neg. rD, rA
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

//nego rD, rA
.globl nego_ppc
nego_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA's value
neg w3, w3 //negRC::ppc
ldr w4, [x1, x2] //grab current rD value
oe_feature_dmn w3 w4
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

//nego. rD, rA
.globl negoRC_ppc
negoRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA's value
neg w3, w3 //negRC::ppc
ldr w4, [x1, x2] //grab current rD value
oe_feature_dmn w3 w4
str w3, [x1, x2] //write rD
record_feature w3
pc_adjust 0x4
ret

.globl subf_ppc
subf_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
sub w3, w4, w3 //subf::ppc
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

.globl subfRC_ppc
subfRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
sub w3, w4, w3 //subf::ppc
str w3, [x1, x2] //write rD
record_feature w3
pc_adjust 0x4
ret

.globl subfo_ppc
subfo_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
sub w3, w4, w3 //subf::ppc
str w3, [x1, x2] //write rD
oe_feature
record_feature w3
pc_adjust 0x4
ret

.globl subfoRC_ppc
subfoRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
sub w3, w4, w3 //subf::ppc
str w3, [x1, x2] //write rD
oe_feature
record_feature w3
pc_adjust 0x4
ret

.globl subfc_ppc
subfc_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
subs w3, w4, w3 //subfc::ppc
str w3, [x1, x2] //write rD
mrs x5, NZCV //grab ARM64 flags
ubfx w5, w5, 29, 1 //extract Carry flag
ldr w6, [x1, xer] //grab ppc xer value
bfi w6, w5, 29, 1 //replace xer's current carry flag
str w6, [x1, xer] //update ppc xer value
pc_adjust 0x4
ret

.globl subfcRC_ppc
subfcRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
subs w3, w4, w3 //subfc::ppc
str w3, [x1, x2] //write rD
mrs x5, NZCV //grab ARM64 flags
ubfx w5, w5, 29, 1 //extract Carry flag
ldr w6, [x1, xer] //grab ppc xer value
bfi w6, w5, 29, 1 //replace xer's current carry flag
str w6, [x1, xer] //update ppc xer value
record_feature w3
pc_adjust 0x4
ret

.globl subfco_ppc
subfco_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
subs w3, w4, w3 //subfc::ppc
str w3, [x1, x2] //write rD
mrs x5, NZCV //grab ARM64 flags
ubfx w5, w5, 29, 1 //extract Carry flag
ldr w6, [x1, xer] //grab ppc xer value
bfi w6, w5, 29, 1 //replace xer's current carry flag
str w6, [x1, xer] //update ppc xer value
oe_feature
pc_adjust 0x4
ret

.globl subfcoRC_ppc
subfcoRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
subs w3, w4, w3 //subfc::ppc
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

.globl subfe_ppc
subfe_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
mvn w3, w3
add w3, w4, w3 //subfe::ppc
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
add w3, w3, w5 //subfe::ppc, rD = !rA + rB + XER[CA]
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

.globl subfeRC_ppc
subfeRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
mvn w3, w3
add w3, w4, w3 //subfe::ppc
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
add w3, w3, w5 //subfe::ppc, rD = !rA + rB + XER[CA]
str w3, [x1, x2] //write rD
record_feature w3
pc_adjust 0x4
ret

.globl subfeo_ppc
subfeo_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
mvn w3, w3
add w3, w4, w3 //subfe::ppc
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
adds w3, w3, w5 //subfe::ppc, rD = !rA + rB + XER[CA]
str w3, [x1, x2] //write rD
oe_feature
pc_adjust 0x4
ret

.globl subfeoRC_ppc
subfeoRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rA's value
ldr w4, [x1, x4] //grab rB's value
mvn w3, w3
add w3, w4, w3 //subfe::ppc
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
adds w3, w3, w5 //subfe::ppc, rD = !rA + rB + XER[CA]
str w3, [x1, x2] //write rD
oe_feature
record_feature w3
pc_adjust 0x4
ret

.globl subfic_ppc
subfic_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
cmp w3, 0 //literal 0 rule for rA
lsl w3, w3, 2
ldr w4, [x0, SIMMoff] //get SIMM
beq 0x8
ldr w3, [x1, x3] //grab rA's value
sub w3, w4, w3 //subfic::ppc
str w3, [x1, x2] //write rD
mrs x5, NZCV //grab ARM64 flags
ubfx w5, w5, 29, 1 //extract Carry flag
ldr w6, [x1, xer] //grab ppc xer value
bfi w6, w5, 29, 1 //replace xer's current carry flag
str w6, [x1, xer] //update ppc xer value
pc_adjust 0x4
ret

.globl subfme_ppc
subfme_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA's value
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
mvn w3, w3
add w3, w3, w5 //subfme::ppc
mov w4, 1 //subfme::ppc NOTE addme = !rA + CA - 1 according to BW manual
sub w3, w3, w4 //subfme::ppc
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

.globl subfmeRC_ppc
subfmeRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA's value
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
mvn w3, w3
add w3, w3, w5 //subfmeRC::ppc
mov w4, 1 //subfmeRC::ppc NOTE addme = !rA + CA - 1 according to BW manual
sub w3, w3, w4 //subfmeRC::ppc
str w3, [x1, x2] //write rD
record_feature w3
pc_adjust 0x4
ret

.globl subfmeo_ppc
subfmeo_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA's value
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
mvn w3, w3
add w3, w3, w5 //subfmeo::ppc
mov w4, 1 //subfmeo::ppc NOTE addme = !rA + CA - 1 according to BW manual
subs w3, w3, w4 //subfmeo::ppc
str w3, [x1, x2] //write rD
oe_feature
pc_adjust 0x4
ret

.globl subfmeoRC_ppc
subfmeoRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA's value
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
mvn w3, w3
add w3, w3, w5 //subfmeoRC::ppc
mov w4, 1 //subfmeoRC::ppc NOTE addme = !rA + CA - 1 according to BW manual
subs w3, w3, w4 //subfmeoRC::ppc
str w3, [x1, x2] //write rD
oe_feature
record_feature w3
pc_adjust 0x4
ret

.globl subfze_ppc
subfze_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA's value
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
mvn w3, w3
add w3, w3, w5 //subfze::ppc , rD = !(rA) + XER[CA]
str w3, [x1, x2] //write rD
pc_adjust 0x4
ret

.globl subfzeRC_ppc
subfzeRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA's value
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
mvn w3, w3
add w3, w3, w5 //subfzeRC::ppc , rD = !(rA) + XER[CA]
str w3, [x1, x2] //write rD
record_feature w3
pc_adjust 0x4
ret

.globl subfzeo_ppc
subfzeo_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA's value
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
mvn w3, w3
adds w3, w3, w5 //subfzeo::ppc , rD = !(rA) + XER[CA]
str w3, [x1, x2] //write rD
oe_feature
pc_adjust 0x4
ret

.globl subfzeoRC_ppc
subfzeoRC_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, rAoff] //get rA number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rA's value
ldr w5, [x1, xer] //grab ppc xer value
ubfx w5, w5, 29, 1 //extract xer[ca]
mvn w3, w3
adds w3, w3, w5 //subfzeoRC::ppc , rD = !(rA) + XER[CA]
str w3, [x1, x2] //write rD
oe_feature
record_feature w3
pc_adjust 0x4
ret

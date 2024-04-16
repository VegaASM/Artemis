//TODO... fix Xer SO -> crF SO stuff
//According to PPC Programmign Environments Manual. crfD SO bit is just a copy of Xer[SO].
//Remember only mtxer or mcrxr can set SO low once its been set high!

.macro pc_adjust amount
ldr x18, [x27, 0x20] //Just in case x1 got corrupted beforehand
ldr w17, [x18, pc]
add w17, w17, \amount
str w17, [x18, pc]
.endm

.macro record_feature wregister //For setting CR cr0's approriate bits from a (.) being used in a PPC instruction
/*NOTE if instruction requires both oe_feature and record_feature, make sure oe_feature is *FIRST*!, NOT this macro*/
cmp \wregister, 0
mrs x18, NZCV //grab ARM64 flags, fyi we don't need C bit
ldr x17, [x27, 0x20] 
ldr w16, [x17, cr] //grab ppc CR value
//Place NZV flags in their own register
ubfx w13, w18, 31, 1 //N
ubfx w14, w18, 30, 1 //Z
ubfx w15, w18, 28, 1 //V
//Does N =/= V, if so set cr0 LT, other clear cr0 LT
eor w12, w13, w15
bfi w16, w12, 31, 1
//Is Z low && N == V? If so set cr0 GT, otherwise clear cr0 GT
eon w12, w13, w15 //eqv, smart!
bic w12, w12, w14 //and w/ complement, smart!
bfi w16, w12, 30, 1
//Is Z high? If so set cr0 EQ, other clear cr0 EQ
bfi w16, w14, 29, 1
//Is V high? if so set cr0 SO, otherwise clear cr0 SO
bfi w16, w15, 28, 1
//TODO above 99% wrong in regards to V flag. According to PPC manuals, crfX SO bit is a copy of Xer SO (sticky overflow) bit. Double check this before editing this one macro
//Write new CR value to register bank
str w16, [x17, cr]
.endm

.macro oe_feature //NOTE this assumes the previous s-appended ARM64 instruction was executed and NZCV flags are true to that
//Grab Reg Bank ptr, then grab ppc xer value
ldr x18, [x27, 0x20]
ldr w17, [x18, xer]
//Grab ARM64 Overflow flag
mrs x16, NZCV
ubfx w16, w16, 28, 1
//Replace OV flag of XER with V flag of ARM64
bfi w17, w16, 30, 1
//Set XER SO flag *ONLY* if ARM64 V is high
//Only mtspr can set Xer SO low!
cmp w16, 1
bne 0x8
bfi w17, w16, 31, 1
//Write new ppc XER 
str w17, [x18, xer]
//Copy XER SO bit cr0 SO bit slot
ldr w16, [x18, cr]
bfi w16, w17, 28, 1
str w16, [x18, cr]
.endm

.macro oe_feature_dmn wregisterOLD wregisterNEW //NOTE for divide, multiply, and negate instructions
cmp \wregisterNEW, \wregisterOLD
mrs x16, NZCV
ubfx x16, x16, 28, 1
//Set XER OV flag
ldr x18, [x27]
ldr w17, [x18, xer]
bfi w17, w16, 30, 1
//Set XER SO flag *ONLY* if ARM64 V is high
//Only mtspr can set Xer SO low!
cmp w16, 1
bne 0x8
bfi w17, w16, 31, 1
//Write new ppc XER
str w17, [x18, xer]
//Copy XER SO bit cr0 SO bit slot
ldr w16, [x18, cr]
bfi w16, w17, 28, 1
str w16, [x18, cr]
.endm

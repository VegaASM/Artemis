/*x0 = extracted pcp items ptr, register numbers (NOT values) and IMMs reside here*/
/*x1 = register bank ppc ptr (register VALUES reside here)*/

//cmpw crfD, rA, rB
.globl cmp_ppc
cmp_ppc:
ldr w2, [x0, rAoff] //Load rA number
lsl w2, w2, 2
ldr w3, [x0, rBoff] //Load rB number
lsl w3, w3, 2
ldr w2, [x1, x2] //Load rA Value
ldr w3, [x1, x2] //Load rB Value
ldr w4, [x0, crfDoff] //Load crfD number
ldr w5, [x1, cr]
//Based on crfD number, we must do an equation to get the ror imm value to place crfD digit at right side
lsl w6, w4, 2 //mulli by 4
sub w6, w6, 28
neg w7, w6
//Now we have ror imm value to rotate the CR by
ror w5, w5, w7
//NOTE we don't need to clear last digit cuz every bit in digit will be mask inserted
//crfD is now clear, Do the ARM64 comparison and grab ARM64 flags
cmp w2, w3
mrs x8, nzcv
//Place all flags in their own register
ubfx w9, w8, 31, 1 //Get N flag
ubfx w10, w8, 30, 1 //Get Z flag
ubfx w11, w8, 28, 1 //Get V flag
//Does N=/=V? If so, set LT, otherwise clear it
eor w12, w9, w11
bfi w5, w12, 3, 1
//Is Z low && N==V? If so, set GT, otherwise clear it
eon w12, w9, w11 //eqv aka xnor, smart!
bic w12, w12, w10 //and w/ complement, smart!
bfi w5, w12, 2, 1
//Set Z bit as EQ bit
bfi w5, w9, 1, 1
//Set V bit as SO bit
bfi w5, w11, 0, 1
//New CR has been created, now rotate it back to where it was
add w6, w6, 32
ror w5, w5, w6
//Write new CR value!
str w5, [x1, cr]
pc_adjust 0x4
ret

//cmpwi crfD, rA, SIMM
.globl cmpi_ppc
cmpi_ppc:
ldr w2, [x0, rAoff] //Load rA number
lsl w2, w2, 2
ldr w3, [x0, SIMMoff] //Load SIMM value
ldr w2, [x1, x2] //Load rA Value
ldr w4, [x0, crfDoff] //Load crfD number
ldr w5, [x1, cr]
//Based on crfD number, we must do an equation to get the ror imm value to place crfD digit at right side
lsl w6, w4, 2 //mulli by 4
sub w6, w6, 28
neg w7, w6
//Now we have ror imm value to rotate the CR by
ror w5, w5, w7
//NOTE we don't need to clear last digit cuz every bit in digit will be mask inserted
//crfD is now clear, Do the ARM64 comparison and grab ARM64 flags
cmp w2, w3
mrs x8, nzcv
//Place all flags in their own register
ubfx w9, w8, 31, 1 //Get N flag
ubfx w10, w8, 30, 1 //Get Z flag
ubfx w11, w8, 28, 1 //Get V flag
//Does N=/=V? If so, set LT, otherwise clear it
eor w12, w9, w11
bfi w5, w12, 3, 1
//Is Z low && N==V? If so, set GT, otherwise clear it
eon w12, w9, w11 //eqv aka xnor, smart!
bic w12, w12, w10 //and w/ complement, smart!
bfi w5, w12, 2, 1
//Set Z bit as EQ bit
bfi w5, w9, 1, 1
//Set V bit as SO bit
bfi w5, w11, 0, 1
//New CR has been created, now rotate it back to where it was
add w6, w6, 32
ror w5, w5, w6
//Write new CR value!
str w5, [x1, cr]
pc_adjust 0x4
ret

//cmplw crfD, rA, rB
.globl cmpl_ppc
cmpl_ppc:
ldr w2, [x0, rAoff] //Load rA number
lsl w2, w2, 2
ldr w3, [x0, rBoff] //Load rB number
lsl w3, w3, 2
ldr w2, [x1, x2] //Load rA Value
ldr w3, [x1, x2] //Load rB Value
ldr w4, [x0, crfDoff] //Load crfD number
ldr w5, [x1, cr]
//Based on crfD number, we must do an equation to get the ror imm value to place crfD digit at right side
lsl w6, w4, 2 //mulli by 4
sub w6, w6, 28
neg w7, w6
//Now we have ror imm value to rotate the CR by
ror w5, w5, w7
//NOTE we don't need to clear last digit cuz every bit in digit will be mask inserted
//crfD is now clear, Do the ARM64 comparison and grab ARM64 flags
cmp w2, w3
mrs x8, nzcv
//Place all flags in their own register
ubfx w9, w8, 30, 1 //Get Z flag
ubfx w10, w8, 29, 1 //Get C flag
ubfx w11, w8, 28, 1 //Get V flag
//Is C low? If so, set LT, otherwise clear it (flip C bit and set it as LT bit)
mvn w12, w10 //Flip bit
bfi w5, w12, 3, 1
//Set C bit as GT bit
bfi w5, w10, 2, 1
//Set Z bit as EQ bit
bfi w5, w9, 1, 1
//Set V bit as SO bit
bfi w5, w11, 0, 1
//New CR has been created, now rotate it back to where it was
add w6, w6, 32
ror w5, w5, w6
//Write new CR value!
str w5, [x1, cr]
pc_adjust 0x4
ret

//cmplwi crfD, rA, UIMM
.globl cmpli_ppc
cmpli_ppc:
ldr w2, [x0, rAoff] //Load rA number
lsl w2, w2, 2
ldr w3, [x0, UIMMoff] //Load UIMM value
ldr w2, [x1, x2] //Load rA Value
ldr w4, [x0, crfDoff] //Load crfD number
ldr w5, [x1, cr]
//Based on crfD number, we must do an equation to get the ror imm value to place crfD digit at right side
lsl w6, w4, 2 //mulli by 4
sub w6, w6, 28
neg w7, w6
//Now we have ror imm value to rotate the CR by
ror w5, w5, w7
//NOTE we don't need to clear last digit cuz every bit in digit will be mask inserted
//crfD is now clear, Do the ARM64 comparison and grab ARM64 flags
cmp w2, w3
mrs x8, nzcv
//Place all flags in their own register
ubfx w9, w8, 30, 1 //Get Z flag
ubfx w10, w8, 29, 1 //Get C flag
ubfx w11, w8, 28, 1 //Get V flag
//Is C low? If so, set LT, otherwise clear it (flip C bit and set it as LT bit)
mvn w12, w10 //Flip bit
bfi w5, w12, 3, 1
//Set C bit as GT bit
bfi w5, w10, 2, 1
//Set Z bit as EQ bit
bfi w5, w9, 1, 1
//Set V bit as SO bit
bfi w5, w11, 0, 1
//New CR has been created, now rotate it back to where it was
add w6, w6, 32
ror w5, w5, w6
//Write new CR value!
str w5, [x1, cr]
pc_adjust 0x4
ret

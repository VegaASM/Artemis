#include "subfinal/float_legal_check.S"
#include "subfinal/float_value_types_bool.S" //TODO this should be somewhere not here, cuz we may get assembler kickout if for w/e reason in execute.S the float.S gets established After paired_singles.S

//Single Precision Important NOTES
//math HID2 PSE low (i.e. fadds) = entire FPR for input and output
//math HID2 PSE high (i.e. fadds) = ps0's used for input. ps0 and ps1 get output
//fres HID2 PSE low = can only be used on single precision floats, entire FPR used
//fres HID2 PSE high = can only be used on single precision floats. ps0 input, ps0 and ps1 get output
//frsp HID2 PSE low = can only be used on double floats, entire FPR used
//frsp HID2 PSE high= can only be used on double floats. ps0 gets output, ps1 destination register left undefined (junk)
//frsqrte HID2 PSE low = entire FPR for input and output
//frsqrte HID2 PSE high = ps0 for input & output. ps1 left UNCHANGED! (left out of Broadway Manual)
//fmr HID2 PSE low = entire FPR copied
//fmr HID2 PSE high = ps0 and ps1 get output (Broadway manual is WRONG!!!!!!!)
//fabs, fnabs, fneg (HID2 PSE doesn't matter) = bit0 of whole FPR is only thing that gets edited

//fabs fD, fB
.globl fabs_ppc
fabs_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fabs_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr d3, [x1, x3] //Grab fB's value
fabs d3, d3
str d3, [x1, x2] //Write new fB
pc_adjust 0x4
fabs_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl fabsRC_ppc
fabsRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fabsRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr d3, [x1, x3] //Grab fB's value
fabs d3, d3
str d3, [x1, x2] //Write new fB
//TODO cr1 fp bits
pc_adjust 0x4
fabsRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fadd fD, fA, fB
.globl fadd_ppc
fadd_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fadd_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
fadd d3, d3, d4 //fadd::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
fadd_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fadd. fD, fA, fB
.globl faddRC_ppc
faddRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, faddRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
fadd d3, d3, d4 //faddRC::ppc
str d3, [x1, x2] //Write fD's value
//TODO cr1 stuff
pc_adjust 0x4
faddRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fadds fD, fA, fB
.globl fadds_ppc
fadds_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fadds_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x10
fadd v3.2s, v3.2s, v4.2s //fadds::ppc
dup v3.2s, v3.s[1] //ps1 must get output as well
b 0x10
fadd d3, d3, d4
fcvt s3, d3
fcvt d3, s3 //Result needs to be single precision but using 64-bits in width
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
fadds_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fadds. fD, fA, fB
.globl faddsRC_ppc
faddsRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, faddsRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x10
fadd v3.2s, v3.2s, v4.2s //faddsRC::ppc
dup v3.2s, v3.s[1] //ps1 must get output as well
b 0x10
fadd d3, d3, d4
fcvt s3, d3
fcvt d3, s3 //Result needs to be single precision but using 64-bits in width
str d3, [x1, x2] //Write fD's value
//TODO cr1 stuff
pc_adjust 0x4
faddsRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fcmpo crfD, fA, fB
.globl fcmpo_ppc
fcmpo_ppc:
//Hmm nothing in Broadway manual about HID2 PSE effect instruction?
//TODO fpscr and ordered/unordered stuff
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fcmpo_ppc_epilogue
ldr w2, [x19, fAoff] //Load fA number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //Load fB number
lsl w3, w3, 3
ldr d2, [x1, x2] //Load fA Value
ldr d3, [x1, x2] //Load fB Value
ldr w4, [x19, crfDoff] //Load crfD number
ldr w5, [x1, cr]
//Based on crfD number, we must do an equation to get the ror imm value to place crfD digit at right side
lsl w6, w4, 2 //mulli by 4
sub w6, w6, 28
neg w7, w6
//Now we have ror imm value to rotate the CR by
ror w5, w5, w7
//NOTE we don't need to clear last digit cuz every bit in digit will be mask inserted
//crfD is now clear, Do the ARM64 comparison and grab ARM64 flags
fcmp d2, d3
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
fcmpo_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fcmpu crfD, fA, fB
.globl fcmpu_ppc
fcmpu_ppc:
//Hmm nothing in Broadway manual about HID2 PSE effect instruction?
//TODO fpscr and ordered/unordered stuff
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fcmpu_ppc_epilogue
ldr w2, [x19, fAoff] //Load fA number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //Load fB number
lsl w3, w3, 3
ldr d2, [x1, x2] //Load fA Value
ldr d3, [x1, x2] //Load fB Value
ldr w4, [x19, crfDoff] //Load crfD number
ldr w5, [x1, cr]
//Based on crfD number, we must do an equation to get the ror imm value to place crfD digit at right side
lsl w6, w4, 2 //mulli by 4
sub w6, w6, 28
neg w7, w6
//Now we have ror imm value to rotate the CR by
ror w5, w5, w7
//NOTE we don't need to clear last digit cuz every bit in digit will be mask inserted
//crfD is now clear, Do the ARM64 comparison and grab ARM64 flags
fcmp d2, d3
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
fcmpu_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fctiw fD, fB
.globl fctiw_ppc
fctiw_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fctiw_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr d3, [x1, x3] //Grab fB's value
fcvtas w3, d3 //or would it be fcvtn? check me in future
str w3, [x1, x2] //Write fD's value
pc_adjust 0x4
fctiw_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fctiw. fD, fB
.globl fctiwRC_ppc
fctiwRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fctiwRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr d3, [x1, x3] //Grab fB's value
fcvtas w3, d3 //or would it be fcvtn? check me in future
str w3, [x1, x2] //Write fD's value
//TODO cr1 stuff
pc_adjust 0x4
fctiwRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fctiwz fD, fB
.globl fctiwz_ppc
fctiwz_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fctiwz_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr d3, [x1, x3] //Grab fB's value
fcvtzs w3, d3
str w3, [x1, x2] //Write fD's value
pc_adjust 0x4
fctiwz_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fctiwz. fD, fB
.globl fctiwzRC_ppc
fctiwzRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fctiwzRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr d3, [x1, x3] //Grab fB's value
fcvtzs w3, d3
str w3, [x1, x2] //Write fD's value
//TODO cr1 stuff
pc_adjust 0x4
fctiwzRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fdiv fD, fA, fB
.globl fdiv_ppc
fdiv_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fdiv_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
fdiv d3, d3, d4 //fdiv::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
fdiv_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fdiv. fD, fA, fB
.globl fdivRC_ppc
fdivRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fdivRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
fdiv d3, d3, d4 //fdivRC::ppc
str d3, [x1, x2] //Write fD's value
//TODO cr1 stuff
pc_adjust 0x4
fdivRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fdivs fD, fA, fB
.globl fdivs_ppc
fdivs_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fdivs_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x10
fdiv v3.2s, v3.2s, v4.2s //fdivs::ppc
dup v3.2s, v3.s[1] //ps1 must get output as well
b 0x10
fdiv d3, d3, d4
fcvt s3, d3
fcvt d3, s3 //Result needs to be single precision but using 64-bits in width
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
fdivs_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fdivs. fD, fA, fB
.globl fdivsRC_ppc
fdivsRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fdivsRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x10
fdiv v3.2s, v3.2s, v4.2s //fdivsRC::ppc
dup v3.2s, v3.s[1] //ps1 must get output as well
b 0x10
fdiv d3, d3, d4
fcvt s3, d3
fcvt d3, s3 //Result needs to be single precision but using 64-bits in width
str d3, [x1, x2] //Write fD's value
//TODO cr1 stuff
pc_adjust 0x4
fdivsRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fmadd fD, fA, fC, fB
.globl fmadd_ppc
fmadd_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fmadd_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fmadd d3, d3, d4, d5 //fmadd::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
fmadd_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fmadd. fD, fA, fC, fB
.globl fmaddRC_ppc
fmaddRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fmaddRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fmadd d3, d3, d4, d5 //fmaddRC::ppc
str d3, [x1, x2] //Write fD's value
//TODO cr1 stuff
pc_adjust 0x4
fmaddRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fmadds fD, fA, fC, fB
.globl fmadds_ppc
fmadds_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fmadds_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x14
fmul v3.2s, v3.2s, v4.2s
fadd v3.2s, v3.2s, v5.2s
dup v3.2s, v3.s[1] //ps1 must get output as well
b 0x14
fmul d3, d3, d4
fadd d3, d3, d5
fcvt s3, d3
fcvt d3, s3 //Result needs to be single precision but using 64-bits in width
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
fmadds_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fmadds. fD, fA, fC, fB
.globl fmaddsRC_ppc
fmaddsRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fmaddsRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x14
fmul v3.2s, v3.2s, v4.2s
fadd v3.2s, v3.2s, v5.2s
dup v3.2s, v3.s[1] //ps1 must get output as well
b 0x14
fmul d3, d3, d4
fadd d3, d3, d5
fcvt s3, d3
fcvt d3, s3 //Result needs to be single precision but using 64-bits in width
str d3, [x1, x2] //Write fD's value
//TODO cr1 stuff
pc_adjust 0x4
fmaddsRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fmr fD, fB
.globl fmr_ppc
fmr_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fmr_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr w3, [x1, x2] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x8 //for fmr with PSE low, we can simply just write to fD in reg bank
dup v3.2s, v3.s[1] //ps1 gets output as well
str x3, [x1, x2] //write new fD value
pc_adjust 0x4
fmr_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fmr. fD, fB
.globl fmrRC_ppc
fmrRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fmrRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr w3, [x1, x2] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x8 //for fmr with PSE low, we can simply just write to fD in reg bank
dup v3.2s, v3.s[1] //ps1 gets output as well
str x3, [x1, x2] //write new fD value
pc_adjust 0x4
fmrRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fmsub fD, fA, fC, fB
.globl fmsub_ppc
fmsub_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fmsub_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fmsub d3, d3, d4, d5 //fmsub::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
fmsub_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fmsub. fD, fA, fC, fB
.globl fmsubRC_ppc
fmsubRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fmsubRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fmsub d3, d3, d4, d5 //fmsubRC::ppc
str d3, [x1, x2] //Write fD's value
//TODO cr1 stuff
pc_adjust 0x4
fmsubRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fmsubs fD, fA, fC, fB
.globl fmsubs_ppc
fmsubs_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fmsubs_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x14
fmul v3.2s, v3.2s, v4.2s
fsub v3.2s, v3.2s, v5.2s
dup v3.2s, v3.s[1] //ps1 must get output as well
b 0x14
fmul d3, d3, d4
fsub d3, d3, d5
fcvt s3, d3
fcvt d3, s3 //Result needs to be single precision but using 64-bits in width
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
fmsubs_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fmsubs. fD, fA, fC, fB
.globl fmsubsRC_ppc
fmsubsRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fmsubsRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x14
fmul v3.2s, v3.2s, v4.2s
fsub v3.2s, v3.2s, v5.2s
dup v3.2s, v3.s[1] //ps1 must get output as well
b 0x14
fmul d3, d3, d4
fsub d3, d3, d5
fcvt s3, d3
fcvt d3, s3 //Result needs to be single precision but using 64-bits in width
str d3, [x1, x2] //Write fD's value
//TODO cr1 stuff
pc_adjust 0x4
fmsubsRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fmul fD, fA, fC
.globl fmul_ppc
fmul_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fmul_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
fmul d3, d3, d4 //fmul::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
fmul_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret


//fmul. fD, fA, fC
.globl fmulRC_ppc
fmulRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fmulRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
fmul d3, d3, d4 //fmulRC::ppc
str d3, [x1, x2] //Write fD's value
//TODO cr1 stuff
pc_adjust 0x4
fmulRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl fmuls_ppc
fmuls_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fmuls_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
Get_hid2_pse w18
cmp w18, 0
beq 0x10
fmul v3.2s, v3.2s, v4.2s //fmuls::ppc
dup v3.2s, v3.s[1] //ps1 must get output as well
b 0x10
fmul d3, d3, d4
fcvt s3, d3
fcvt d3, s3 //Result needs to be single precision but using 64-bits in width
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
fmuls_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl fmulsRC_ppc
fmulsRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fmulsRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
Get_hid2_pse w18
cmp w18, 0
beq 0x10
fmul v3.2s, v3.2s, v4.2s //fmuls::ppc
dup v3.2s, v3.s[1] //ps1 must get output as well
str d3, [x1, x2] //Write fD's value
b 0x10
fmul d3, d3, d4
fcvt s3, d3
fcvt d3, s3 //Result needs to be single precision but using 64-bits in width
str d3, [x1, x2] //Write fD's value
//TODO cr1 stuff
pc_adjust 0x4
fmulsRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl fnabs_ppc
fnabs_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fnabs_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr d3, [x1, x3] //Grab fB's value
fabs d3, d3
fneg d3, d3
str d3, [x1, x2] //Write new fB
pc_adjust 0x4
fnabs_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl fnabsRC_ppc
fnabsRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fnabsRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr d3, [x1, x3] //Grab fB's value
fabs d3, d3
fneg d3, d3
str d3, [x1, x2] //Write new fB
//todo cr1 fp bit stuff
pc_adjust 0x4
fnabsRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl fneg_ppc
fneg_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fneg_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr d3, [x1, x3] //Grab fB's value
fneg d3, d3
str d3, [x1, x2] //Write new fB
pc_adjust 0x4
fneg_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl fnegRC_ppc
fnegRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fnegRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr d3, [x1, x3] //Grab fB's value
fneg d3, d3
str d3, [x1, x2] //Write new fB
//TODO cr1 fp bit stuff
pc_adjust 0x4
fnegRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl fnmadd_ppc
fnmadd_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fnmadd_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fnmadd d3, d3, d4, d5 //fnmadd::ppc
pc_adjust 0x4
fnmadd_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl fnmaddRC_ppc
fnmaddRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fnmaddRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fnmadd d3, d3, d4, d5 //fnmaddRC::ppc
//TODO cr1 stuff
pc_adjust 0x4
fnmaddRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl fnmadds_ppc
fnmadds_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fnmadds_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x18
fmul v3.2s, v3.2s, v4.2s
fadd v3.2s, v3.2s, v5.2s
fneg v3.2s, v3.2s
dup v3.2s, v3.s[1] //ps1 must get output as well
b 0x18
fmul d3, d3, d4
fadd d3, d3, d5
fneg d3, d3
fcvt s3, d3
fcvt d3, s3 //Result needs to be single precision but using 64-bits in width
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
fnmadds_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl fnmaddsRC_ppc
fnmaddsRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fnmaddsRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x18
fmul v3.2s, v3.2s, v4.2s
fadd v3.2s, v3.2s, v5.2s
fneg v3.2s, v3.2s
dup v3.2s, v3.s[1] //ps1 must get output as well
b 0x18
fmul d3, d3, d4
fadd d3, d3, d5
fneg d3, d3
fcvt s3, d3
fcvt d3, s3 //Result needs to be single precision but using 64-bits in width
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
fnmaddsRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl fnmsub_ppc
fnmsub_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fnmsub_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fnmsub d3, d3, d4, d5 //fnmsub::ppc
pc_adjust 0x4
fnmsub_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl fnmsubRC_ppc
fnmsubRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fnmsubRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fnmsub d3, d3, d4, d5 //fnmsubRC::ppc
//TODO cr1 stuff
pc_adjust 0x4
fnmsubRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl fnmsubs_ppc
fnmsubs_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fnmsubs_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x18
fmul v3.2s, v3.2s, v4.2s
fsub v3.2s, v3.2s, v5.2s
fneg v3.2s, v3.2s
dup v3.2s, v3.s[1] //ps1 must get output as well
b 0x18
fmul d3, d3, d4
fsub d3, d3, d5
fneg d3, d3
fcvt s3, d3
fcvt d3, s3 //Result needs to be single precision but using 64-bits in width
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
fnmsubs_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl fnmsubsRC_ppc
fnmsubsRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fnmsubsRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x18
fmul v3.2s, v3.2s, v4.2s
fsub v3.2s, v3.2s, v5.2s
fneg v3.2s, v3.2s
dup v3.2s, v3.s[1] //ps1 must get output as well
b 0x18
fmul d3, d3, d4
fsub d3, d3, d5
fneg d3, d3
fcvt s3, d3
fcvt d3, s3 //Result needs to be single precision but using 64-bits in width
str d3, [x1, x2] //Write fD's value
//TODO cr1 stuff
pc_adjust 0x4
fnmsubsRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl fres_ppc
fres_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fres_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr d3, [x1, x3] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x10
frecpe v3.2s, v3.2s
dup v3.2s, v3.s[1] //ps1 must get output as well
b 0x10
frecpe d3, d3
fcvt s3, d3
fcvt d3, s3 //Result needs to be single precision but using 64-bits in width
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
fres_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl fresRC_ppc
fresRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fresRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr d3, [x1, x3] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x10
frecpe v3.2s, v3.2s
dup v3.2s, v3.s[1] //ps1 must get output as well
b 0x10
frecpe d3, d3
fcvt s3, d3
fcvt d3, s3 //Result needs to be single precision but using 64-bits in width
str d3, [x1, x2] //Write fD's value
//TODO cr1 stuff
pc_adjust 0x4
fresRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl frsp_ppc
frsp_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, frsp_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr d3, [x1, x3] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x10
fcvt s3, d3
dup v3.2s, v3.s[1] //ps0 needs to have result. ps1 is suppose to be undefined. We could put some "junk" random value for ps1 now..., but I'll let it be (TODO)
b 0xC
fcvt s3, d3 //do the frsp conversion
fcvt d3, s3 //Result needs to be single precision but using 64-bits in width
str s3, [x1, x2]
pc_adjust 0x4
frsp_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl frspRC_ppc
frspRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, frspRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr d3, [x1, x3] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x10
fcvt s3, d3
dup v3.2s, v3.s[1] //ps0 needs to have result. ps1 is suppose to be undefined. We could put some "junk" random value for ps1 now..., but I'll let it be (TODO)
b 0xC
fcvt s3, d3 //do the frsp conversion
fcvt d3, s3 //Result needs to be single precision but using 64-bits in width
str s3, [x1, x2]
//TODO cr1 stuff
pc_adjust 0x4
frspRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl frsqrte_ppc
frsqrte_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, frsqrte_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr d3, [x1, x3] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x10
ldr d4, [x1, x2] //get current fD value
frsqrte v3.2s, v3.2s
ins v3.s[0], v4.s[0] //ps0 is output with keeping original fD ps1 intact
b 0x8
frsqrte d3, d3 //NOTE do NOT do fcvt twice to make a 64-bit width single precision result. This instruction is meant to output double-precision result (when HID2 PSE is low)
str d3, [x1, x2] //Write new fD
pc_adjust 0x4
frsqrte_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl frsqrteRC_ppc
frsqrteRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, frsqrteRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr d3, [x1, x3] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x10
ldr d4, [x1, x2] //get current fD value
frsqrte v3.2s, v3.2s
ins v3.s[0], v4.s[0] //ps0 is output with keeping original fD ps1 intact
b 0x8
frsqrte d3, d3 //NOTE do NOT do fcvt twice to make a 64-bit width single precision result. This instruction is meant to output double-precision result (when HID2 PSE is low)
str d3, [x1, x2] //Write new fD
pc_adjust 0x4
frsqrteRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl fsel_ppc
fsel_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fsel_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
movi d6, 0
fcmp d3, d6
fcsel d7, d4, d5, ge
str d7, [x1, x2]
pc_adjust 0x4
fsel_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl fselRC_ppc
fselRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fselRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
movi d6, 0
fcmp d3, d6
fcsel d7, d4, d5, ge
str d7, [x1, x2]
//todo cr1 fp stuff
pc_adjust 0x4
fselRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fsub fD, fA, fB
.globl fsub_ppc
fsub_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fsub_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
fsub d3, d3, d4 //fsub::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
fsub_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fsub. fD, fA, fB
.globl fsubRC_ppc
fsubRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fsubRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
fsub d3, d3, d4 //fsubRC::ppc
str d3, [x1, x2] //Write fD's value
//TODO cr1 stuff
pc_adjust 0x4
fsubRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fsubs fD, fA, fB
.globl fsubs_ppc
fsubs_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fsubs_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x10
fsub v3.2s, v3.2s, v4.2s //fsubs::ppc
dup v3.2s, v3.s[1] //ps1 must get output as well
b 0x10
fsub d3, d3, d4
fcvt s3, d3
fcvt d3, s3 //Result needs to be single precision but using 64-bits in width
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
fsubs_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

//fsubs. fD, fA, fB
.globl fsubsRC_ppc
fsubsRC_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl float_legal_check
cbnz w0, fsubsRC_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
Get_hid2_pse w18
cmp w18, 0
beq 0x10
fsub v3.2s, v3.2s, v4.2s //fsubs::ppc
dup v3.2s, v3.s[1] //ps1 must get output as well
b 0x10
fsub d3, d3, d4
fcvt s3, d3
fcvt d3, s3 //Result needs to be single precision but using 64-bits in width
str d3, [x1, x2] //Write fD's value
//TODO cr1 stuff
pc_adjust 0x4
fsubsRC_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

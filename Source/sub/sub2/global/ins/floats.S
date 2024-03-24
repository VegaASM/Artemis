//Important NOTES
//lfsX = both ps0 and ps1 get loaded with value
//lfdX = entire fpr loaded with value
//stfsX = ps0 only gets stored
//stfdX = entire fpr gets stored
//math (fadd/s) = ps0's used for input. ps0 and ps1 get output
//fres = can only be used on single float. ps0 input, ps0 and ps1 get output
//frsp = can only be used on double float. ps0 gets output, ps1 destination register left undefined
//fmr = when used on single floats, ps0's is input&output, ps1 of Destination register LEFT UNCHANGED!!!!
//fabs, fnabs, fneg = when used on single floats, ps0's is input&output, ps1 of Destination register left undefined

//fabs fD, fB
.globl fabs_ppc
fabs_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fBoff] //load fB number
lsl w3, w3, 3
ldr w3, [x1, x2] //Grab fB's value
//TODO put in code to tell if we do double or single precision..
pc_adjust 0x4
ret

.globl fabsRC_ppc
fabsRC_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fBoff] //load fB number
lsl w3, w3, 3
ldr w3, [x1, x2] //Grab fB's value
//TODO put in code to tell if we do double or single precision..
//TODO put in code to edit cr1 FP bits
pc_adjust 0x4
ret

//fadd fD, fA, fB
.globl fadd_ppc
fadd_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
fadd d3, d3, d4 //fadd::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ret

//fadd. fD, fA, fB
.globl faddRC_ppc
faddRC_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
fadd d3, d3, d4 //faddsRC::ppc
str d3, [x1, x2] //Write fD's value
//TODO put in code to edit cr1 FP bits
pc_adjust 0x4
ret

//fadds fD, fA, fB
.globl fadds_ppc
fadds_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
fadd v3.2s, v3.2s, v4.2s //fadds::ppc
dup v3.2s, v3.s[1] //ps1 must get output as well
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ret

//fadds. fD, fA, fB
.globl faddsRC_ppc
faddsRC_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
fadd v3.2s, v3.2s, v4.2s //fadds::ppc
dup v3.2s, v3.s[1] //ps1 must get output as well
str d3, [x1, x2] //Write fD's value
//TODO put in crap for cr1 FP bits
pc_adjust 0x4
ret

.globl fcmpo_ppc
fcmpo_ppc:
pc_adjust 0x4
ret

.globl fcmpu_ppc
fcmpu_ppc:
pc_adjust 0x4
ret

//fctiw fD, fB
.globl fctiw_ppc
fctiw_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fBoff] //load fB number
lsl w3, w3, 3
ldr d3, [x1, x3] //Grab fB's value
//TODO put in code to tell single vs double float
fcvtas w3, d3 //or would it be fcvtn? check me in future
str w3, [x1, x2] //Write fD's value
pc_adjust 0x4
ret

//fctiw. fD, fB
.globl fctiwRC_ppc
fctiwRC_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fBoff] //load fB number
lsl w3, w3, 3
ldr d3, [x1, x3] //Grab fB's value
//TODO put in code to tell single vs double float
fcvtas w3, d3 //or would it be fcvtn? check me in future
str w3, [x1, x2] //Write fD's value
//TODO put in code for cr1 FP bits
pc_adjust 0x4
ret

//fctiwz fD, fB
.globl fctiwz_ppc
fctiwz_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fBoff] //load fB number
lsl w3, w3, 3
ldr d3, [x1, x3] //Grab fB's value
//TODO put in code to tell single vs double float
fcvtzs w3, d3 //or would it be fcvtn? check me in future
str w3, [x1, x2] //Write fD's value
pc_adjust 0x4
ret

//fctiwz. fD, fB
.globl fctiwzRC_ppc
fctiwzRC_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fBoff] //load fB number
lsl w3, w3, 3
ldr d3, [x1, x3] //Grab fB's value
//TODO put in code to tell single vs double float
fcvtzs w3, d3 //or would it be fcvtn? check me in future
str w3, [x1, x2] //Write fD's value
//TODO put in code for cr1 FP bits
pc_adjust 0x4
ret

//fdiv fD, fA, fB
.globl fdiv_ppc
fdiv_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
fdiv d3, d3, d4 //fdiv::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ret

//fdiv. fD, fA, fB
.globl fdivRC_ppc
fdivRC_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
fdiv d3, d3, d4 //fdiv::ppc
str d3, [x1, x2] //Write fD's value
//TODO put in code for cr1 FP bits
pc_adjust 0x4
ret

//fdivs fD, fA, fB
.globl fdivs_ppc
fdivs_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
fdiv v3.2s, v3.2s, v4.2s //fdivs::ppc
dup v3.2s, v3.s[1] //ps1 must get output as well
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ret

//fdivs. fD, fA, fB
.globl fdivsRC_ppc
fdivsRC_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
fdiv v3.2s, v3.2s, v4.2s //fdivs::ppc
dup v3.2s, v3.s[1] //ps1 must get output as well
str d3, [x1, x2] //Write fD's value
//TODO put in code for cr1 FP bits
pc_adjust 0x4
ret

//fmadd fD, fA, fC, fB
.globl fmadd_ppc
fmadd_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x0, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fmadd d3, d3, d4, d5 //fmadd::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ret

//fmadd. fD, fA, fC, fB
.globl fmaddRC_ppc
fmaddRC_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x0, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fmadd d3, d3, d4, d5 //fmadd::ppc
str d3, [x1, x2] //Write fD's value
//TODO put in code for cr1 FP bits
pc_adjust 0x4
ret

//fmadds fD, fA, fC, fB
.globl fmadds_ppc
fmadds_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x0, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fmul v3.2s, v3.2s, v4.2s
fadd v3.2s, v3.2s, v5.2s
dup v3.2s, v3.s[1] //ps1 must get output as well
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ret

//fmadds. fD, fA, fC, fB
.globl fmaddsRC_ppc
fmaddsRC_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x0, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fmul v3.2s, v3.2s, v4.2s
fadd v3.2s, v3.2s, v5.2s
dup v3.2s, v3.s[1] //ps1 must get output as well
str d3, [x1, x2] //Write fD's value
//TODO put in code for cr1 FP bits
pc_adjust 0x4
ret

//fmr fD, fB
.globl fmr_ppc
fmr_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fBoff] //load fB number
lsl w3, w3, 3
ldr w3, [x1, x2] //Grab fB's value
//TODO put in code to tell if we do double or single precision..
//Leave ps1 of dest reg unchanged
pc_adjust 0x4
ret

//fmr. fD, fB
.globl fmrRC_ppc
fmrRC_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fBoff] //load fB number
lsl w3, w3, 3
ldr w3, [x1, x2] //Grab fB's value
//TODO put in code to tell if we do double or single precision..
//Leave ps1 of dest reg unchanged
//TODO put in code for cr1 FP bits
pc_adjust 0x4
ret

//fmsub fD, fA, fC, fB
.globl fmsub_ppc
fmsub_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x0, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fmsub d3, d3, d4, d5 //fmsub::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ret

//fmsub. fD, fA, fC, fB
.globl fmsubRC_ppc
fmsubRC_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x0, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fmsub d3, d3, d4, d5 //fmsub::ppc
str d3, [x1, x2] //Write fD's value
//TODO put in cr1 FP stuff
pc_adjust 0x4
ret

//fmsubs fD, fA, fC, fB
.globl fmsubs_ppc
fmsubs_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x0, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fmul v3.2s, v3.2s, v4.2s
fsub v3.2s, v3.2s, v5.2s
dup v3.2s, v3.s[1] //ps1 must get output as well
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ret

//fmsubs. fD, fA, fC, fB
.globl fmsubsRC_ppc
fmsubsRC_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x0, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fmul v3.2s, v3.2s, v4.2s
fsub v3.2s, v3.2s, v5.2s
dup v3.2s, v3.s[1] //ps1 must get output as well
str d3, [x1, x2] //Write fD's value
//TODO put in cr1 FP stuff
pc_adjust 0x4
ret

//fmul fD, fA, fC
.globl fmul_ppc
fmul_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fCoff] //load fC number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
fmul d3, d3, d4 //fmul::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ret

//fmul. fD, fA, fC
.globl fmulRC_ppc
fmulRC_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fCoff] //load fC number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
fmul d3, d3, d4 //fmulRC::ppc
str d3, [x1, x2] //Write fD's value
//TODO put in cr1 FP bits
pc_adjust 0x4
ret

.globl fmuls_ppc
fmuls_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fCoff] //load fC number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
fmul v3.2s, v3.2s, v4.2s //fmuls::ppc
dup v3.2s, v3.s[1] //ps1 must get output as well
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ret

.globl fmulsRC_ppc
fmulsRC_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fCoff] //load fC number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
fmul v3.2s, v3.2s, v4.2s //fmulsRC::ppc
dup v3.2s, v3.s[1] //ps1 must get output as well
str d3, [x1, x2] //Write fD's value
//TODO put in cr1 FP bits
pc_adjust 0x4
ret

.globl fnabs_ppc
fnabs_ppc:
pc_adjust 0x4
ret

.globl fnabsRC_ppc
fnabsRC_ppc:
pc_adjust 0x4
ret

.globl fneg_ppc
fneg_ppc:
pc_adjust 0x4
ret

.globl fnegRC_ppc
fnegRC_ppc:
pc_adjust 0x4
ret

.globl fnmadd_ppc
fnmadd_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x0, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fnmadd d3, d3, d4, d5 //fnmadd::ppc
pc_adjust 0x4
ret

.globl fnmaddRC_ppc
fnmaddRC_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x0, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fnmadd d3, d3, d4, d5 //fnmaddRC::ppc
//TODO cr1 FP bit stuff
pc_adjust 0x4
ret

.globl fnmadds_ppc
fnmadds_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x0, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fmul v3.2s, v3.2s, v4.2s
fadd v3.2s, v3.2s, v5.2s
fneg v3.2s, v3.2s
dup v3.2s, v3.s[1] //ps1 must get output as well
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ret

.globl fnmaddsRC_ppc
fnmaddsRC_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x0, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fmul v3.2s, v3.2s, v4.2s
fadd v3.2s, v3.2s, v5.2s
fneg v3.2s, v3.2s
dup v3.2s, v3.s[1] //ps1 must get output as well
str d3, [x1, x2] //Write fD's value
//TODO cr1 FP bit stuff
pc_adjust 0x4
ret

.globl fnmsub_ppc
fnmsub_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x0, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fnmsub d3, d3, d4, d5 //fnmsub::ppc
pc_adjust 0x4
ret

.globl fnmsubRC_ppc
fnmsubRC_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x0, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fnmsub d3, d3, d4, d5 //fnmsub::ppc
//TODO cr1 FP bit stuff
pc_adjust 0x4
ret

.globl fnmsubs_ppc
fnmsubs_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x0, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fmul v3.2s, v3.2s, v4.2s
fsub v3.2s, v3.2s, v5.2s
fneg v3.2s, v3.2s
dup v3.2s, v3.s[1] //ps1 must get output as well
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ret

.globl fnmsubsRC_ppc
fnmsubsRC_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x0, fBoff] //load fB number
lsl w5, w5, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fmul v3.2s, v3.2s, v4.2s
fsub v3.2s, v3.2s, v5.2s
fneg v3.2s, v3.2s
dup v3.2s, v3.s[1] //ps1 must get output as well
str d3, [x1, x2] //Write fD's value
//TODO cr1 FP bit stuff
pc_adjust 0x4
ret

.globl fres_ppc
fres_ppc:
pc_adjust 0x4
ret

.globl fresRC_ppc
fresRC_ppc:
pc_adjust 0x4
ret

.globl frsp_ppc
frsp_ppc:
pc_adjust 0x4
ret

.globl frspRC_ppc
frspRC_ppc:
pc_adjust 0x4
ret

.globl frsqrte_ppc
frsqrte_ppc:
pc_adjust 0x4
ret

.globl frsqrteRC_ppc
frsqrteRC_ppc:
pc_adjust 0x4
ret

.globl fsel_ppc
fsel_ppc:
pc_adjust 0x4
ret

.globl fselRC_ppc
fselRC_ppc:
pc_adjust 0x4
ret


//fsub fD, fA, fB
.globl fsub_ppc
fsub_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
fsub d3, d3, d4 //fsub::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ret

//fsub. fD, fA, fB
.globl fsubRC_ppc
fsubRC_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
fsub d3, d3, d4 //fsubRC::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ret

//fsubs fD, fA, fB
.globl fsubs_ppc
fsubs_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
fsub v3.2s, v3.2s, v4.2s //fsubs::ppc
dup v3.2s, v3.s[1] //ps1 must get output as well
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ret

//fsubs. fD, fA, fB
.globl fsubsRC_ppc
fsubsRC_ppc:
add x1, x1, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x0, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x0, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x0, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
fsub v3.2s, v3.2s, v4.2s //fsubs::ppc
dup v3.2s, v3.s[1] //ps1 must get output as well
str d3, [x1, x2] //Write fD's value
//TODO cr1 FP bits
pc_adjust 0x4
ret


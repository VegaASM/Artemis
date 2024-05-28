/*NOTE currently unused*/

//NOTES
//When HID2 PSE is high, ps0 determines the FPSCR bits 15 thru 19 except for ps_cmpu1, ps_cmpo1, and ps_sum1. In those instructions, the FPSCR bits are determined by ps1 result.
//For fpscr bits 0 thru 14 and 22+23, either ps0 or ps1 CAN set a bit.
//When float/ps instruction has RC high, cr1 field is set from fpscr bits 0 thru 3.
//Following instructions have zero effect on fpscr, RC versions still update cr1
//move, abs/nabs, neg, and ps merges

on normal cmps, crX SO is NOT copy of XER, however it is only if one or both fA/fB is NaN

/*Symbols*/
.set cr1_lt, 4
.set cr1_gt, 5
.set cr1_eq, 6
.set cr1_so, 7
.set cr1_fx, cr1_lt
.set cr1_fex, cr1_gt
.set cr1_vx, cr1_eq
.set cr1_ox, cr1_so
.set cr1_result_nan, cr1_ox

/*if RC in instruction is used
cr1 lt = fx
cr1 gt = fex
cr1 eq = vx
cr1 so = ox*/

//args
//x0 = old fD
//x1 = new fD
//w2 bool  (0 = no RC); (1 = RC)
//w3 int (type)
/*
0 = Add
1 = Subtract
2 = Divide
3 = Multiply
4 = Ordered compare
5 = Unordered compare
6 = rsqrte
7 = int convert of any kind
8 = other
*/
.globl rc_fp_cr1
rc_fp_cr1:
/*Prologue*/
stp fp, lr, [sp, -0x30]!
stp x19, x20, [sp, 0x10]
stp x21, x22, [sp, 0x10]
mov fp, sp

/*Backup Args*/
mov x19, x0
mov x20, x1
mov w21, w2
mov w22, w3

/*Load fpscr*/
ldr x4, [x27, regbank_ptr]
ldr w5, [x4, fpscr]




VE and ZE




//Set OX
//If previous sign bit was 0, and latest sign bit was 1
//Grab old fD sign bit
ubfx wX, wX, X, X
ubfx wY, wY, x< X
eor wz, wX, X
beq
cmp wNEW, wOLD
blo

//Set UX
//Opposite of OX


//Set ZX
//If Source Register is 0/-0 and it's any divide
cmp w2, 0
beq
cmp w3, 0 //clear out evrything but sign bit for zero compare
bne


//Set XX
//Sticky version of FI, do NOT mask insert




//FEX = (VX & VE) ^ (OX & OE) ^ (UX & UE) ^ (ZX & ZE) ^ (XX & XE)
ubfx w15, w5, fpscr_ve_b, 1
ubfx w14, w5, fpscr_oe_b, 1
ubfx w13, w5, fpscr_ue_b, 1
ubfx w12, w5, fpscr_ze_b, 1
ubfx w11, w5, fpscr_xe_b, 1
and w10, w16, w15
and w9, wX, w14
and w8, wX, w13
and w7, wX, w12
and w6, wX, w11
eor w10, w10, w9
eor w9, w8, w7
eor w10, w10, w9
eor w10, w10, w6
/*w10 = FEX*/
orr w5, w5, w10 // but remember this is sticky, so we just orr in it, NOT insert

=====================================

/*Check Invalid Operand Exception Condition*/
check_invalid_operand_exception_condition:
/*Check VE bit*/
ubfx w0, w5, fpscr_ve_b, 1
cbz w0, check_zero_divide_exception_condition

/*Section 3.3.6.1.1*/
/*First, Is any Source Register a SNaN*/
ldr
cmp dX, SNaN
beq 0x10
ldr
cmp dX, SNaN
bne 0x8
orr w5, w5, fpscr_vxsnan_b

/*Is ma*/
cmp
beq fcompute_sub_infi_both
/*Is divide where both source registers are infi's?*/
cmp
beq fcompute_div_infi_both
/*Is divide where both source registers are 0?*/
cmp
beq fcompute_div_zero_both
/*Is multiplication*/
cmp
beq fcompute_mul
/*Is ordered compare where source Register(s) is NaN*/
cmp
beq fcompute_ocompare_nan
/*Is rsqrte on a negative number?*/
cmp
beq fcompute_inv_rsqrte
/*Is int convert where Source Register is infi or Nan?*/
cmp
bne check_fex_fe0_fe1

/*fcompute_inv_int_conv: label name not needed*/
orr w5, w5, fpscr_vxcvi
b 0x40

/*All below are sticky bits, there use orr, NOT bfi*/
fcompute_snan:

b 0x38

fcompute_sub_infi_both:
orr w5, w5, fpscr_vxisi
b 0x30

fcompute_div_infi_both:
orr w5, w5, fpscr_vxidi
b 0x28

fcompute_div_zero_both:
orr w5, w5, fpscr_vxzdz
b 0x20

fcompute_mul:
orr w5, w5, fpscr_vximz
b 0x18

fcompute_ocompare_nan:
orr w5, w5, fpscr_vxvc
b 0x10

fcompute_inv_rsqrte:
orr w5, w5, fpscr_vxsqrt
b 0x8

/*Set VX high "raw" instead of doing all the logical ORing*/
orr w5, w5, fpscr_vx

/*Was instruciton a compare instruction*/
/*If so, fpcc is set to reflect unordered, set bit 19 high*
use bfi as these are NOT stickies*/
TODO

=======================

/*Check for zero divide exception conditon*/
check_zero_divide_exception_condition:
/*Force set VX low "raw" instead of doign all the logical ORing at end*/
bfc w5, fpscr_vx_b, 1
/*Check OE bit*/
ubfx w0, w5, fpscr_oe_b, 1
cbz w0, execute_float_compute_instruction

/*Section 3.3.6.1.2*/
/*Is instruction a divide and is it dividing by Zero*/
...
cmp dX, 0
bne execute_float_compute_instruction

/*Set ZX high and clear FR + FI*/
orr w5, w5, fpscr_zx
bfc w5, xx, xx
bfc w5, xx, xx
/*Now see if we take an exception based on this*/
b

execute_float_compute_instruction:
/*get fD
is fD = 0 or postive INFI?
if so, do rouning shit, set fi, fr, fprf apporiately
if not, check for overflow, underflow, and inexact exception conditions
*/
cmp dX, 0
beq 0xC
cmp dX, infi
bne check_overflow_underflow_and_inexact_exception_conditions

/*Do rounding based on FPSCR Rn*/
and wX, w5, fpscr_rn
...
/*Set FI, FP, and FPRF approriately*/
...
b continue_float_compute_instruction

check_overflow_underflow_and_inexact_exception_conditions:
OMG have you see the diagram for this? LOOL






/*Is either fe0 or fe1 high?
If true, is FEX high?
If true, take a Program Exception*//
check_fex_fe0_fe1:
/*Frist insert VX*/
//vX = (VXSNAN | VXISI | VXIDI | VXZDZ | VXIMZ | VXVC)
//TODO may be best to set VX high, bu tif zero divide route is taken then VX gest set low
/*now set OX*

and w11, w16, w10
cbz w11, fpscr_epilogue
/*Take Program Exception*/
bl program_exception
b fpscr_epilogue


/*If RC high, then insert big endian bits 0-3 of fpscr to big endian bits 4 thru 7 of CR*/
cbz w2, no_RC
ldr w9, [x4, cr]
ubfx w10, w5, 28, 4
bfi w9, w10, 24, 4
str w9, [x4, cr]
no_RC:

//Update fpscr
str wZ, [x1, fpscr]

/*Epilogue*/
fpscr_epilogue:
ldp x21, x22, [sp, 0x20]
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x30
ret

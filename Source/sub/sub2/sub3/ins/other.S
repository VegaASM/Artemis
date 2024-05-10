
.globl eciwx_ppc
eciwx_ppc:
//If EAR[E] = 0, then DSI (todo)
//If EA not div'd by 4, then Alignment
//What about priority for "normal" DSI?? Hmmm
//Otherwise nop since Artemis does not simulate
stp fp, lr, [sp, -0x20]!
str x19, [sp, 0x10]
mov fp, sp
ldr w2, [x0, rBoff] //get rA number
ldr w3, [x0, rAoff] //get rB number
lsl w2, w2, 2
lsl w3, w3, 2
ldr w2, [x1, x2] //grab rA value
ldr w3, [x1, x3] //grab rB value
add w0, w2, w3 //calc & save EA
mov w19, w0
bl data_ea_to_pa_plus_verify //x1 already set
cbz w0, 0x14
//Call exception address that was returned back
mov w0, w1
mov x18, x0
blr x18
b 0x8
//Is EA 4-byte aligned?
tbz w19, 3, 0x10
mov w0, w19
bl alignment_exception_vector
b 0x8
pc_adjust 0x4
ldr x19, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl ecowx_ppc
ecowx_ppc:
//If EAR[E] = 0, then DSI (todo)
//If EA not div'd by 4, then Alignment
//What about priority for "normal" DSI?? Hmmm
//Otherwise nop since Artemis does not simulate
stp fp, lr, [sp, -0x20]!
str x19, [sp, 0x10]
mov fp, sp
ldr w2, [x0, rBoff] //get rA number
ldr w3, [x0, rAoff] //get rB number
lsl w2, w2, 2
lsl w3, w3, 2
ldr w2, [x1, x2] //grab rA value
ldr w3, [x1, x3] //grab rB value
add w0, w2, w3 //calc & save EA
mov w19, w0 //x1 already set
bl data_ea_to_pa_plus_verify
cbz w0, 0x14
//Call exception address that was returned back
mov w0, w1
mov x18, x0
blr x18
b 0x8
//Is EA 4-byte aligned?
tbz w19, 3, 0x10
mov w0, w19
bl alignment_exception_vector
b 0x8
pc_adjust 0x4
ldr x19, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl eieio_ppc
eieio_ppc:
//Just nop since Artemis does not simulate store gathering
pc_adjust 0x4
ret

.globl mcrf_ppc
mcrf_ppc:
ldr w2, [x0, crfDoff] //grab crfD number
ldr w3, [x0, crfSoff] //grab crfS number
ldr w4, [x1, cr] //grab CR register value
lsl w3, w3, 2 //mulli crfS number by 4
sub w3, w3, 28
neg w6, w3
ror w5, w4, w6
and w5, w5, 0xF
/**/
lsl w2, w2, 2
sub w2, w2, 28
neg w7, w2
ror w6, w4, w7
and w6, w6, 0xFFFFFFF0 //not using bfc for preference
/**/
orr w6, w6, w5
add w2, w2, 32
ror w6, w6, w2
str w6, [x1, cr]
pc_adjust 0x4
ret

//mcrfs crfD, crfS
.globl mcrfs_ppc
mcrfs_ppc:
pc_adjust 0x4
ret

//mcrxr crfD
.globl mcrxr_ppc
mcrxr_ppc:
ldr w2, [x0, crfDoff] //get crfD value
ldr w3, [x1, xer] //get XER value
ubfx w3, w3, 28, 4 //get XER bits big endian 0 thru 3
ldr w4, [x1, cr] //get CR
lsl w2, w2, 2 //mulli crfD by 4
sub w2, w2, 28 //subtract 28 from result
neg w3, w2 //neg it to get positive amount to ROR by
ror w4, w4, w2
bfi w4, w3, 0, 4 //Insert XER bits
add w2, w2, 32 //get new amount to ROR back to
ror w4, w4, 2
bfc w3, 28, 4 //clear XER big endian bits 0 thru 3
str w3, [x1, xer] //write new XER value
str w4, [x1, cr] //write new CR value
pc_adjust 0x4
ret

//mfcr rD
.globl mfcr_ppc
mfcr_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x1, cr] //get CR value
str w3, [x1, x2] //mfcr::ppc
pc_adjust 0x4
ret

.globl mffs_ppc
mffs_ppc:
ldr w2, [x1, fpscr]
ldr w3, [x0, fDoff]
lsl w3, w3, 3
add x1, x1, fpr0
ldr x4, [x1, x3] //yes do a int load, NOT float
bfc x4, 32, 32 //clear out bottom 32 bits TODO CHECK ME
orr x4, x4, x2 //place fpscr into lower 32 bits of emulated float register
str x4, [x1, x3] //mffsRC::ppc
pc_adjust 0x4
ret

.globl mffsRC_ppc
mffsRC_ppc:
ldr w2, [x1, fpscr]
ldr w3, [x0, fDoff]
lsl w3, w3, 3
add x1, x1, fpr0
ldr x4, [x1, x3] //yes do a int load, NOT float
bfc x4, 32, 32 //clear out bottom 32 bits TODO CHECK ME
orr x4, x4, x2 //place fpscr into lower 32 bits of emulated float register
str x4, [x1, x3] //mffsRC::ppc
pc_adjust 0x4
//todo cr1 fp stuff
ret

.globl mfmsr_ppc
mfmsr_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x1, msr] //grab MSR value
str w3, [x1, x2] //copy MSR to rD
pc_adjust 0x4
ret

.globl mfspr_ppc
mfspr_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, SPRoff] //grab SPR number
cmp w3, 1
beq 0x2C4
cmp w3, 8
beq 0x2C4
cmp w3, 9
beq 0x2C4
cmp w3, 18
beq 0x2C4
cmp w3, 19
beq 0x2C4
cmp w3, 22
beq 0x2C4
cmp w3, 25
beq 0x2C4
cmp w3, 26
beq 0x2C4
cmp w3, 27
beq 0x2C4
cmp w3, 272
beq 0x2C4
cmp w3, 273
beq 0x2C4
cmp w3, 274
beq 0x2C4
cmp w3, 275
beq 0x2C4
cmp w3, 282
beq 0x2C4
cmp w3, 287
beq 0x2C4
cmp w3, 528
beq 0x2C4
cmp w3, 529
beq 0x2C4
cmp w3, 530
beq 0x2C4
cmp w3, 531
beq 0x2C4
cmp w3, 532
beq 0x2C4
cmp w3, 533
beq 0x2C4
cmp w3, 534
beq 0x2C4
cmp w3, 535
beq 0x2C4
cmp w3, 560
beq 0x2C4
cmp w3, 561
beq 0x2C4
cmp w3, 562
beq 0x2C4
cmp w3, 563
beq 0x2C4
cmp w3, 564
beq 0x2C4
cmp w3, 565
beq 0x2C4
cmp w3, 566
beq 0x2C4
cmp w3, 567
beq 0x2C4
cmp w3, 536
beq 0x2C4
cmp w3, 537
beq 0x2C4
cmp w3, 538
beq 0x2C4
cmp w3, 539
beq 0x2C4
cmp w3, 540
beq 0x2C4
cmp w3, 541
beq 0x2C4
cmp w3, 542
beq 0x2C4
cmp w3, 543
beq 0x2C4
cmp w3, 568
beq 0x2C4
cmp w3, 569
beq 0x2C4
cmp w3, 570
beq 0x2C4
cmp w3, 571
beq 0x2C4
cmp w3, 572
beq 0x2C4
cmp w3, 573
beq 0x2C4
cmp w3, 574
beq 0x2C4
cmp w3, 575
beq 0x2C4
cmp w3, 912
beq 0x2C4
cmp w3, 913
beq 0x2C4
cmp w3, 914
beq 0x2C4
cmp w3, 915
beq 0x2C4
cmp w3, 916
beq 0x2C4
cmp w3, 917
beq 0x2C4
cmp w3, 918
beq 0x2C4
cmp w3, 919
beq 0x2C4
cmp w3, 920
beq 0x2C4
cmp w3, 921
beq 0x2C4
cmp w3, 922
beq 0x2C4
cmp w3, 923
beq 0x2C4
cmp w3, 936
beq 0x2C4
cmp w3, 937
beq 0x2C4
cmp w3, 938
beq 0x2C4
cmp w3, 939
beq 0x2C4
cmp w3, 940
beq 0x2C4
cmp w3, 941
beq 0x2C4
cmp w3, 942
beq 0x2C4
cmp w3, 943
beq 0x2C4
cmp w3, 952
beq 0x2C4
cmp w3, 953
beq 0x2C4
cmp w3, 954
beq 0x2C4
cmp w3, 955
beq 0x2C4
cmp w3, 956
beq 0x2C4
cmp w3, 957
beq 0x2C4
cmp w3, 958
beq 0x2C4
cmp w3, 959
beq 0x2C4
cmp w3, 1008
beq 0x2C4
cmp w3, 1009
beq 0x2C4
cmp w3, 1010
beq 0x2C4
cmp w3, 1011
beq 0x2C4
cmp w3, 1012
beq 0x2C4
cmp w3, 1013
beq 0x2C4
cmp w3, 1017
beq 0x2C4
cmp w3, 1018
beq 0x2C4
cmp w3, 1019
beq 0x2C4
cmp w3, 1020
beq 0x2C4
cmp w3, 1021
beq 0x2C4
cmp w3, 1022
beq 0x2C4
cmp w3, 925
beq 0x2C4
cmp w3, 926
beq 0x2C4
mov w3, cidl /*927 aka ecid3*/
b finish_mfspr
mov w3, xer
b finish_mfspr
mov w3, lrppc
b finish_mfspr
mov w3, ctr
b finish_mfspr
mov w3, dsisr
b finish_mfspr
mov w3, dar
b finish_mfspr
mov w3, dec
b finish_mfspr
mov w3, sdr1
b finish_mfspr
mov w3, srr0
b finish_mfspr
mov w3, srr1
b finish_mfspr
mov w3, sprg0
b finish_mfspr
mov w3, sprg1
b finish_mfspr
mov w3, sprg2
b finish_mfspr
mov w3, sprg3
b finish_mfspr
mov w3, ear
b finish_mfspr
mov w3, pvr
b finish_mfspr
mov w3, ibat0u
b finish_mfspr
mov w3, ibat0l
b finish_mfspr
mov w3, ibat1u
b finish_mfspr
mov w3, ibat1l
b finish_mfspr
mov w3, ibat2u
b finish_mfspr
mov w3, ibat2l
b finish_mfspr
mov w3, ibat3u
b finish_mfspr
mov w3, ibat3l
b finish_mfspr
mov w3, ibat4u
b finish_mfspr
mov w3, ibat4l
b finish_mfspr
mov w3, ibat5u
b finish_mfspr
mov w3, ibat5l
b finish_mfspr
mov w3, ibat6u
b finish_mfspr
mov w3, ibat6l
b finish_mfspr
mov w3, ibat7u
b finish_mfspr
mov w3, ibat7l
b finish_mfspr
mov w3, dbat0u
b finish_mfspr
mov w3, dbat0l
b finish_mfspr
mov w3, dbat1u
b finish_mfspr
mov w3, dbat1l
b finish_mfspr
mov w3, dbat2u
b finish_mfspr
mov w3, dbat2l
b finish_mfspr
mov w3, dbat3u
b finish_mfspr
mov w3, dbat3l
b finish_mfspr
mov w3, dbat4u
b finish_mfspr
mov w3, dbat4l
b finish_mfspr
mov w3, dbat5u
b finish_mfspr
mov w3, dbat5l
b finish_mfspr
mov w3, dbat6u
b finish_mfspr
mov w3, dbat6l
b finish_mfspr
mov w3, dbat7u
b finish_mfspr
mov w3, dbat7l
b finish_mfspr
mov w3, gqr0
b finish_mfspr
mov w3, gqr1
b finish_mfspr
mov w3, gqr2
b finish_mfspr
mov w3, gqr3
b finish_mfspr
mov w3, gqr4
b finish_mfspr
mov w3, gqr4
b finish_mfspr
mov w3, gqr5
b finish_mfspr
mov w3, gqr6
b finish_mfspr
mov w3, gqr7
b finish_mfspr
mov w3, hid2
b finish_mfspr
mov w3, wpar
b finish_mfspr
mov w3, dma_u
b finish_mfspr
mov w3, dma_l
b finish_mfspr
mov w3, ummcr0
b finish_mfspr
mov w3, upmc1
b finish_mfspr
mov w3, upmc2
b finish_mfspr
mov w3, usia
b finish_mfspr
mov w3, ummcr1
b finish_mfspr
mov w3, upmc3
b finish_mfspr
mov w3, upmc4
b finish_mfspr
mov w3, usda
b finish_mfspr
mov w3, mmcr0
b finish_mfspr
mov w3, pmc1
b finish_mfspr
mov w3, pmc2
b finish_mfspr
mov w3, sia
b finish_mfspr
mov w3, mmcr1
b finish_mfspr
mov w3, pmc3
b finish_mfspr
mov w3, pmc4
b finish_mfspr
mov w3, sda
b finish_mfspr
mov w3, hid0
b finish_mfspr
mov w3, hid1
b finish_mfspr
mov w3, iabr
b finish_mfspr
mov w3, hid4
b finish_mfspr
mov w3, tdcl
b finish_mfspr
mov w3, dabr
b finish_mfspr
mov w3, l2cr
b finish_mfspr
mov w3, tdch
b finish_mfspr
mov w3, ictc
b finish_mfspr
mov w3, thrm1
b finish_mfspr
mov w3, thrm2
b finish_mfspr
mov w3, thrm3
b finish_mfspr
mov w3, cidh /*ecid1*/
b finish_mfspr
mov w3, cidm /*ecid2*/
finish_mfspr:
ldr w3, [x1, x3] //load SPR register contents
str w3, [x1, x2] //store SPR register contents to rD
pc_adjust 0x4
ret

.globl mfsr_ppc
mfsr_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x1, SRoff] //get SR number
lsl w3, w3, 2
add x4, x1, sr0 //set x4 ptr to start at sr0
ldr w3, [x3, x4] //grab SR value
str w3, [x1, x2] //copy SR to rD
pc_adjust 0x4
ret

.globl mfsrin_ppc
mfsrin_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x1, rBoff] //get rB number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rB's value
ubfx w3, w3, 28, 4 //get indicated SR number from rB's value
add x4, x1, sr0 //set x4 ptr to start at sr0
ldr w3, [x3, x4] //grab SR value
str w3, [x1, x2] //copy SR to rD
pc_adjust 0x4
ret

.globl mftb_ppc
mftb_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x1, SRoff] //get TBR number
cmp w3, 268
beq 0xC
ldr w3, [x1, tbl]
b 0x8
ldr w3, [x1, tbu]
str w3, [x1, x2] //copy TBU/TBL to rD
pc_adjust 0x4
ret

.globl mtcrf_ppc
mtcrf_ppc:
ldr w2, [x0, rSoff] //get rS number
ldr w3, [x0, CRMoff] //get CRM Value
lsl w2, w2, 2
ldr w2, [x1, x2] //get rS Value
//create CRM mask (w8)
//Set w3 to get ror'd by 1 everytime per loop to get bit of CRM
ror w4, w3, 31
//Prep a lsl shiftor amount for the loop
mov w5, 0
mov w6, 0
//Set loop amount
mov w7, 32
//Loop
crm_mask_loop:
ror w4, w4, 1 //Place current working bit into bit 0 slot
ubfx w8, w4, 0, 1 //Grab Bit
bfi w8, w8, 3, 1 //Copy bit 0 to bits 1 thru 3
bfi w8, w8, 2, 1
bfi w8, w8, 1, 1
lsl w8, w8, w5 //Do the shiftor
orr w6, w6, w8 //Update CRM mask
subs w7, w7, 1
add w5, w5, 4 //Update shiftor
bne crm_mask_loop
//And rS with mask
and w2, w2, w5
//And CR with !mask
mvn w5, w5
and w3, w3, w5
//OR both results to get new CR
orr w2, w2, w3
//Write new CR
str w2, [x1, cr]
pc_adjust 0x4
ret

.globl mtfsb0_ppc
mtfsb0_ppc:
ldr w2, [x0, crbDoff] //load crbD value
ldr w3, [x1, fpscr] //get fpscr value
sub w2, w2, 31
neg w4, w2
ror w3, w3, w4
bfc w3, 0, 1
add w2, w2, 32
ror w3, w3, 2
str w3, [x1, fpscr]
pc_adjust 0x4
ret

.globl mtfsb0RC_ppc
mtfsb0RC_ppc:
ldr w2, [x0, crbDoff] //load crbD value
ldr w3, [x1, fpscr] //get fpscr value
sub w2, w2, 31
neg w4, w2
ror w3, w3, w4
bfc w3, 0, 1
add w2, w2, 32
ror w3, w3, 2
str w3, [x1, fpscr]
pc_adjust 0x4
//todo cr1 fp bits
ret

.globl mtfsb1_ppc
mtfsb1_ppc:
ldr w2, [x0, crbDoff] //load crbD value
ldr w3, [x1, fpscr] //get fpscr value
sub w2, w2, 31
neg w4, w2
ror w3, w3, w4
orr w3, w3, 1
add w2, w2, 32
ror w3, w3, 2
str w3, [x1, fpscr]
pc_adjust 0x4
ret

.globl mtfsb1RC_ppc
mtfsb1RC_ppc:
ldr w2, [x0, crbDoff] //load crbD value
ldr w3, [x1, fpscr] //get fpscr value
sub w2, w2, 31
neg w4, w2
ror w3, w3, w4
orr w3, w3, 1
add w2, w2, 32
ror w3, w3, 2
str w3, [x1, fpscr]
//todo cr1 fp bits
pc_adjust 0x4
ret

.globl mtfsf_ppc
mtfsf_ppc:
ldr w2, [x0, FMoff] //get FM value
add x3, x1, fpr0 //adjust regbank ptr
ldr w4, [x0, fBoff] //get fB number
lsl w4, w4, 8
ldr x4, [x1, x3] //get fB Value as double-int
ldr w5, [x1, fpscr] //get FPRSCR value
//create FM mask (w8)
//Set w2 to get ror'd by 1 everytime per loop to get bit of FM
ror w6, w2, 31
//Prep a lsl shiftor amount for the loop
mov w7, 0
mov w8, 0
//Set loop amount
mov w9, 32
//Loop
fm_mask_loop:
ror w6, w6, 1 //Place current working bit into bit 0 slot
ubfx w10, w6, 0, 1 //Grab Bit
bfi w10, w10, 3, 1 //Copy bit 0 to bits 1 thru 3
bfi w10, w10, 2, 1
bfi w10, w10, 1, 1
lsl w10, w10, w5 //Do the shiftor
orr w8, w8, w10 //Update FM mask
subs w9, w9, 1
add w7, w7, 4 //Update shiftor
bne fm_mask_loop
//And lower 32-bits of fB with mask
and w4, w4, w8
//And FPSCR with !mask
mvn w8, w8
and w5, w5, w8
//OR both results to get new FPSCR
orr w2, w4, w10
//Write new CR
str w2, [x1, fpscr]
pc_adjust 0x4
ret

.globl mtfsfRC_ppc
mtfsfRC_ppc:
ldr w2, [x0, FMoff] //get FM value
add x3, x1, fpr0 //adjust regbank ptr
ldr w4, [x0, fBoff] //get fB number
lsl w4, w4, 8
ldr x4, [x1, x3] //get fB Value as double-int
ldr w5, [x1, fpscr] //get FPRSCR value
//create FM mask (w8)
//Set w2 to get ror'd by 1 everytime per loop to get bit of FM
ror w6, w2, 31
//Prep a lsl shiftor amount for the loop
mov w7, 0
mov w8, 0
//Set loop amount
mov w9, 32
//Loop
fmRC_mask_loop:
ror w6, w6, 1 //Place current working bit into bit 0 slot
ubfx w10, w6, 0, 1 //Grab Bit
bfi w10, w10, 3, 1 //Copy bit 0 to bits 1 thru 3
bfi w10, w10, 2, 1
bfi w10, w10, 1, 1
lsl w10, w10, w5 //Do the shiftor
orr w8, w8, w10 //Update FM mask
subs w9, w9, 1
add w7, w7, 4 //Update shiftor
bne fmRC_mask_loop
//And lower 32-bits of fB with mask
and w4, w4, w8
//And FPSCR with !mask
mvn w8, w8
and w5, w5, w8
//OR both results to get new FPSCR
orr w2, w4, w10
//Write new CR
str w2, [x1, fpscr]
//todo cr1 fp stuff
pc_adjust 0x4
ret

.globl mtfsfi_ppc
mtfsfi_ppc:
ldr w2, [x0, crfDoff] //get crfD value
ldr w3, [x0, IMMoff] //get IMM value
ldr w4, [x1, fpscr] //get FPSCR value
//Set IMM as if it was replacing cr0
lsl w3, w3, 28
//Set Start Mask for crF field
mov w5, 0xF0000000
//Multiply crfD by 4
lsl w2, w2, 2
//Shift right Start mask with Multiplied amount
lsr w5, w5, w2
//Shift right IMM by Multiplied amount
lsr w3, w3, w2
//And FPSCR with !mask
mvn w6, w5
and w4, w4, w6
//Orr in IMM
orr w4, w4, w3
//Write new FPSCR
str w4, [x1, fpscr]
ret

.globl mtfsfiRC_ppc
mtfsfiRC_ppc:
ldr w2, [x0, crfDoff] //get crfD value
ldr w3, [x0, IMMoff] //get IMM value
ldr w4, [x1, fpscr] //get FPSCR value
//Set IMM as if it was replacing cr0
lsl w3, w3, 28
//Set Start Mask for crF field
mov w5, 0xF0000000
//Multiply crfD by 4
lsl w2, w2, 2
//Shift right Start mask with Multiplied amount
lsr w5, w5, w2
//Shift right IMM by Multiplied amount
lsr w3, w3, w2
//And FPSCR with !mask
mvn w6, w5
and w4, w4, w6
//Orr in IMM
orr w4, w4, w3
//Write new FPSCR
str w4, [x1, fpscr]
//todo cr1 fp stuff
ret

.globl mtmsr_ppc
mtmsr_ppc:
ldr w2, [x0, rSoff] //get rS number
lsl w2, w2, 2
ldr w3, [x1, x2] //grab rS value
str w3, [x1, msr] //copy rS to MSR
pc_adjust 0x4
ret

.globl mtspr_ppc
mtspr_ppc:
ldr w3, [x0, SPRoff] //get SPR number
ldr w4, [x0, rSoff] //grab rS number
lsl w4, w4, 2
ldr w4, [x1, x4] //grab rS value
cmp w3, 1
beq 0x2AC
cmp w3, 8
beq 0x2AC
cmp w3, 9
beq 0x2AC
cmp w3, 18
beq 0x2AC
cmp w3, 19
beq 0x2AC
cmp w3, 22
beq 0x2AC
cmp w3, 25
beq 0x2AC
cmp w3, 26
beq 0x2AC
cmp w3, 27
beq 0x2AC
cmp w3, 272
beq 0x2AC
cmp w3, 273
beq 0x2AC
cmp w3, 274
beq 0x2AC
cmp w3, 275
beq 0x2AC
cmp w3, 282
beq 0x2AC
cmp w3, 284
beq 0x2AC
cmp w3, 285
beq 0x2AC
cmp w3, 528
beq 0x2AC
cmp w3, 529
beq 0x2AC
cmp w3, 530
beq 0x2AC
cmp w3, 531
beq 0x2AC
cmp w3, 532
beq 0x2AC
cmp w3, 533
beq 0x2AC
cmp w3, 534
beq 0x2AC
cmp w3, 535
beq 0x2AC
cmp w3, 560
beq 0x2AC
cmp w3, 561
beq 0x2AC
cmp w3, 562
beq 0x2AC
cmp w3, 563
beq 0x2AC
cmp w3, 564
beq 0x2AC
cmp w3, 565
beq 0x2AC
cmp w3, 566
beq 0x2AC
cmp w3, 567
beq 0x2AC
cmp w3, 536
beq 0x2AC
cmp w3, 537
beq 0x2AC
cmp w3, 538
beq 0x2AC
cmp w3, 539
beq 0x2AC
cmp w3, 540
beq 0x2AC
cmp w3, 541
beq 0x2AC
cmp w3, 542
beq 0x2AC
cmp w3, 543
beq 0x2AC
cmp w3, 568
beq 0x2AC
cmp w3, 569
beq 0x2AC
cmp w3, 570
beq 0x2AC
cmp w3, 571
beq 0x2AC
cmp w3, 572
beq 0x2AC
cmp w3, 573
beq 0x2AC
cmp w3, 574
beq 0x2AC
cmp w3, 575
beq 0x2AC
cmp w3, 912
beq 0x2AC
cmp w3, 913
beq 0x2AC
cmp w3, 914
beq 0x2AC
cmp w3, 915
beq 0x2AC
cmp w3, 916
beq 0x2AC
cmp w3, 917
beq 0x2AC
cmp w3, 918
beq 0x2AC
cmp w3, 919
beq 0x2AC
cmp w3, 920
beq 0x2AC
cmp w3, 921
beq 0x2AC
cmp w3, 922
beq 0x2AC
cmp w3, 923
beq 0x2AC
cmp w3, 936
beq 0x2AC
cmp w3, 937
beq 0x2AC
cmp w3, 938
beq 0x2AC
cmp w3, 939
beq 0x2AC
cmp w3, 940
beq 0x2AC
cmp w3, 941
beq 0x2AC
cmp w3, 942
beq 0x2AC
cmp w3, 943
beq 0x2AC
cmp w3, 952
beq 0x2AC
cmp w3, 953
beq 0x2AC
cmp w3, 954
beq 0x2AC
cmp w3, 955
beq 0x2AC
cmp w3, 956
beq 0x2AC
cmp w3, 957
beq 0x2AC
cmp w3, 958
beq 0x2AC
cmp w3, 959
beq 0x2AC
cmp w3, 1008
beq 0x2AC
cmp w3, 1009
beq 0x2AC
cmp w3, 1010
beq 0x2AC
cmp w3, 1011
beq 0x2AC
cmp w3, 1013
beq 0x2AC
cmp w3, 1017
beq 0x2AC
cmp w3, 1019
beq 0x2AC
cmp w3, 1020
beq 0x2AC
cmp w3, 1021
beq 0x2AC
mov w2, thrm3 /*1022*/
b finish_mtspr
mov w2, xer
b finish_mtspr
mov w2, lrppc
b finish_mtspr
mov w2, ctr
b finish_mtspr
mov w2, dsisr
b finish_mtspr
mov w2, dar
b finish_mtspr
mov w2, dec
b finish_mtspr
mov w2, sdr1
b finish_mtspr
mov w2, srr0
b finish_mtspr
mov w2, srr1
b finish_mtspr
mov w2, sprg0
b finish_mtspr
mov w2, sprg1
b finish_mtspr
mov w2, sprg2
b finish_mtspr
mov w2, sprg3
b finish_mtspr
mov w2, ear
b finish_mtspr
mov w2, tbl
b finish_mtspr
mov w2, tbu
b finish_mtspr
mov w2, ibat0u
b finish_mtspr
mov w2, ibat0l
b finish_mtspr
mov w2, ibat1u
b finish_mtspr
mov w2, ibat1l
b finish_mtspr
mov w2, ibat2u
b finish_mtspr
mov w2, ibat2l
b finish_mtspr
mov w2, ibat3u
b finish_mtspr
mov w2, ibat3l
b finish_mtspr
mov w2, ibat4u
b finish_mtspr
mov w2, ibat4l
b finish_mtspr
mov w2, ibat5u
b finish_mtspr
mov w2, ibat5l
b finish_mtspr
mov w2, ibat6u
b finish_mtspr
mov w2, ibat6l
b finish_mtspr
mov w2, ibat7u
b finish_mtspr
mov w2, ibat7l
b finish_mtspr
mov w2, dbat0u
b finish_mtspr
mov w2, dbat0l
b finish_mtspr
mov w2, dbat1u
b finish_mtspr
mov w2, dbat1l
b finish_mtspr
mov w2, dbat2u
b finish_mtspr
mov w2, dbat2l
b finish_mtspr
mov w2, dbat3u
b finish_mtspr
mov w2, dbat3l
b finish_mtspr
mov w2, dbat4u
b finish_mtspr
mov w2, dbat4l
b finish_mtspr
mov w2, dbat5u
b finish_mtspr
mov w2, dbat5l
b finish_mtspr
mov w2, dbat6u
b finish_mtspr
mov w2, dbat6l
b finish_mtspr
mov w2, dbat7u
b finish_mtspr
mov w2, dbat7l
b finish_mtspr
mov w2, gqr0
b finish_mtspr
mov w2, gqr1
b finish_mtspr
mov w2, gqr2
b finish_mtspr
mov w2, gqr3
b finish_mtspr
mov w2, gqr4
b finish_mtspr
mov w2, gqr4
b finish_mtspr
mov w2, gqr5
b finish_mtspr
mov w2, gqr6
b finish_mtspr
mov w2, gqr7
b finish_mtspr
mov w2, hid2
b finish_mtspr
mov w2, wpar
b finish_mtspr
mov w2, dma_u
b finish_mtspr
mov w2, dma_l
b finish_mtspr
mov w2, ummcr0
b finish_mtspr
mov w2, upmc1
b finish_mtspr
mov w2, upmc2
b finish_mtspr
mov w2, usia
b finish_mtspr
mov w2, ummcr1
b finish_mtspr
mov w2, upmc3
b finish_mtspr
mov w2, upmc4
b finish_mtspr
mov w2, usda
b finish_mtspr
mov w2, mmcr0
b finish_mtspr
mov w2, pmc1
b finish_mtspr
mov w2, pmc2
b finish_mtspr
mov w2, sia
b finish_mtspr
mov w2, mmcr1
b finish_mtspr
mov w2, pmc3
b finish_mtspr
mov w2, pmc4
b finish_mtspr
mov w2, sda
b finish_mtspr
mov w2, hid0
b finish_mtspr
mov w2, hid1
b finish_mtspr
mov w2, iabr
b finish_mtspr
mov w2, hid4
b finish_mtspr
mov w2, dabr
b finish_mtspr
mov w2, l2cr
b finish_mtspr
mov w2, ictc
b finish_mtspr
mov w2, thrm1
b finish_mtspr
mov w2, thrm2
finish_mtspr:
str w4, [x1, x2] //copy rS to SPR
pc_adjust 0x4
ret

.globl mtsr_ppc
mtsr_ppc:
ldr w2, [x0, rDoff] //get SR number
lsl w2, w2, 2
ldr w3, [x1, SRoff] //get rS number
lsl w3, w3, 2
add x4, x1, sr0 //set x4 ptr to start at sr0
str w3, [x4, x2] //copy rS to SR
pc_adjust 0x4
ret

.globl mtsrin_ppc
mtsrin_ppc:
ldr w2, [x0, rDoff] //get rS number
lsl w2, w2, 2
ldr w3, [x1, SRoff] //get rB number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rB's value
ubfx w3, w3, 28, 4 //get indicated SR number from rB's value
add x4, x1, sr0 //set x4 ptr to start at sr0
str w2, [x4, x1] //copy rS to SR
pc_adjust 0x4
ret

.globl rfi_ppc
rfi_ppc:
ldr w2, [x1, srr0] //get srr0 value
ldr w3, [x1, srr1] //get srr1 value
str w2, [x1, pc] //rfi::ppc copy srr0 to PC
str w3, [x1, msr] //rfi::ppc copy srr1 to MSR
ret //do NOT use PC adjust macro!

.globl sc_ppc
sc_ppc:
stp fp, lr, [sp, -0x10]!
mov fp, sp
bl syscall_exception_vector
ldp fp, lr, [sp], 0x10
ret

.globl sync_ppc
sync_ppc:
//TODO put in stuff here to wait for all mem accesses to finish
pc_adjust 0x4
ret

.globl tlbie_ppc
tlbie_ppc:
pc_adjust 0x4
ret

.globl tlbsync_ppc
tlbsync_ppc:
pc_adjust 0x4
ret

.globl tw_ppc
tw_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rBoff] //get rB number
lsl w3, w3, 2
ldr w2, [x1, x2] //get rA value
ldr w3, [x1, x3] //get rB value
ldr w4, [x0, TOoff] //get TO Value
cmp w2, w3 //set flags
mrs x2, nzcv //get flags
ubfx w5, w2, 31, 1 //N
ubfx w6, w2, 30, 1 //Z
ubfx w7, w2, 29, 1 //C
ubfx w8, w2, 28, 1 //V
//Make LT flag from ARM64 flags, and place it in big endian bit 27 of dedicated scrap register
eor w9, w5, w8
lsl w9, w9, 4
//Make GT flag from ARM64 flags, and place it in big endian bit 28 of dedicated scrap register
eon w10, w5, w8 //eqv
bic w10, w10, w6 //and w/ complement
bfi w9, w0, 3, 1
//Make EQ flag from ARM64 flags, and place it in big endian bit 29 of dedicated scrap register
bfi w9, w6, 2, 1
//Make Unsigned LT flag from ARM64 flags, and place in big endian bit 30 of dedicated scrap register
mvn w10, w7
bfi w9, w0, 1, 1
//Make Unsigned GT flag from ARM64 flags, and place in big endian bit 31 of dedicated scrap register
bfi w9, w7, 0, 1
//scrap register will be used to do Logical AND with TO field
//if *ANY* bit remains high after ANDing, then Trap!
tst w9, w4
beq 0xC
mov w0, 0x00020000
bl program_exception_vector
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl twi_ppc
twi_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rBoff] //get SIMM
ldr w2, [x1, x2] //get rA value
ldr w4, [x0, TOoff] //get TO Value
cmp w2, w3 //set flags
mrs x2, nzcv //get flags
ubfx w5, w2, 31, 1 //N
ubfx w6, w2, 30, 1 //Z
ubfx w7, w2, 29, 1 //C
ubfx w8, w2, 28, 1 //V
//Make LT flag from ARM64 flags, and place it in big endian bit 27 of dedicated scrap register
eor w9, w5, w8
lsl w9, w9, 4
//Make GT flag from ARM64 flags, and place it in big endian bit 28 of dedicated scrap register
eon w10, w5, w8 //eqv
bic w10, w10, w6 //and w/ complement
bfi w9, w0, 3, 1
//Make EQ flag from ARM64 flags, and place it in big endian bit 29 of dedicated scrap register
bfi w9, w6, 2, 1
//Make Unsigned LT flag from ARM64 flags, and place in big endian bit 30 of dedicated scrap register
mvn w10, w7
bfi w9, w0, 1, 1
//Make Unsigned GT flag from ARM64 flags, and place in big endian bit 31 of dedicated scrap register
bfi w9, w7, 0, 1
//scrap register will be used to do Logical AND with TO field
//if *ANY* bit remains high after ANDing, then Trap!
tst w9, w4
beq 0xC
mov w0, 0x00020000
bl program_exception_vector
pc_adjust 0x4
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl invalid_ppc
invalid_ppc:
stp fp, lr, [sp, -0x10]!
mov fp, sp
mov w0, 0x00080000
bl program_exception_vector
ldp fp, lr, [sp], 0x10
ret

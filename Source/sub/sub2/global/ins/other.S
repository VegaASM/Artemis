
.globl dcbf_ppc
dcbf_ppc:
pc_adjust 0x4
ret

.globl dcbi_ppc
dcbi_ppc:
pc_adjust 0x4
ret

.globl dcbst_ppc
dcbst_ppc:
pc_adjust 0x4
ret

.globl dcbt_ppc
dcbt_ppc:
pc_adjust 0x4
ret

.globl dcbtst_ppc
dcbtst_ppc:
pc_adjust 0x4
ret

.globl dcbz_ppc
dcbz_ppc:
pc_adjust 0x4
ret

.globl dcbz_l_ppc
dcbz_l_ppc:
pc_adjust 0x4
ret

.globl eciwx_ppc
eciwx_ppc:
pc_adjust 0x4
ret

.globl ecowx_ppc
ecowx_ppc:
pc_adjust 0x4
ret

.globl eieio_ppc
eieio_ppc:
pc_adjust 0x4
ret

.globl icbi_ppc
icbi_ppc:
pc_adjust 0x4
ret

.globl isync_ppc
isync_ppc:
pc_adjust 0x4
ret

.globl mcrf_ppc
mcrf_ppc:
ldr w2, [x0, crfDoff] //grab crfD number
ldr w3, [x0, crfSoff] //grab crfS number
ldr w4, [x1, cr] //grab CR register value
lsl w3, w3, 2 //mulli crfS number by 4
add w3, w3, 4
sub w3, w3, 32
neg w3, w3
ror w5, w4, w3
and w5, w5, 0xF
/**/
lsl w2, w2, 2
add w2, w2, 4
sub w2, w2, 32
neg w7, w2
ror w6, w4, w7
and w6, w6, 0xFFFFFFF0
/**/
orr w6, w6, w5
ror w6, w6, w2 //check me!
str w6, [x1, cr]
pc_adjust 0x4
ret

.globl mcrfs_ppc
mcrfs_ppc:
pc_adjust 0x4
ret

.globl mcrxr_ppc
mcrxr_ppc:
pc_adjust 0x4
ret

//mfcr rD
.globl mfcr_ppc
mfcr_ppc:
pc_adjust 0x4
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x1, cr] //get CR value
str w3, [x1, x2] //mfcr::ppc
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
pc_adjust 0x4
ret

.globl mtfsb0_ppc
mtfsb0_ppc:
pc_adjust 0x4
ret

.globl mtfsb0RC_ppc
mtfsb0RC_ppc:
pc_adjust 0x4
ret

.globl mtfsb1_ppc
mtfsb1_ppc:
pc_adjust 0x4
ret

.globl mtfsb1RC_ppc
mtfsb1RC_ppc:
pc_adjust 0x4
ret

.globl mtfsf_ppc
mtfsf_ppc:
pc_adjust 0x4
ret

.globl mtfsfRC_ppc
mtfsfRC_ppc:
pc_adjust 0x4
ret

.globl mtfsfi_ppc
mtfsfi_ppc:
pc_adjust 0x4
ret

.globl mtfsfiRC_ppc
mtfsfiRC_ppc:
pc_adjust 0x4
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
pc_adjust 0x4
ret

.globl twi_ppc
twi_ppc:
pc_adjust 0x4
ret

.globl invalid_ppc
invalid_ppc:
stp fp, lr, [sp, -0x10]!
mov fp, sp
bl program_exception_vector
ldp fp, lr, [sp], 0x10
ret

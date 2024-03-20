/*#include "global/registerbankmap.S"*/ /*Already established in hardreset.S*/

GPRs:
.asciz "r%d: 0x%08X r%d: 0x%08X\n"
FPRs:
.asciz "f%d: 0x%016X f%d: 0x%016X\n"
MainMISC:
.asciz "PC: 0x%08X LR: 0x%08X CTR: 0x%08X CR: 0x%08X\n"
MISC1:
.asciz "XER: 0x%08X MSR: 0x%08X srr0: 0x%08X srr1: 0x%08X\n"
MISC2:
.asciz "TB: 0x%016X FPSCR: 0x%08X DSISR: 0x%08X DAR: 0x%08X\n"
MISC3:
.asciz "HID0: 0x%08X HID1: 0x%08X HID2: 0x%08X HID4: 0x%08X\n"
MISC4:
.asciz "DEC: 0x%08X SDR1: 0x%08X L2CR: 0x%08X WPAR: 0x%08X\n"
IBATs:
.asciz "ibat%d 0x%016X ibat%d 0x%016X\n"
DBATs:
.asciz "dbat%d 0x%016X dbat%d 0x%016X\n"
GQRs:
.asciz "gqr%d: 0x%08X gqr%d: 0x%08X\n"
SRs:
.asciz "sr%d: 0x%08X sr%d: 0x%08X\n"
MISC5:
.asciz "sprg0: 0x%08X sprg1: 0x%08X sprg2: 0x%08X sprg3: 0x%08X\n"
MISC6:
.asciz "IABR: 0x%08X DABR: 0x%08X DMA_U: %08X DMA_L: %08X\n"
MISC7:
.asciz "MMCR0: 0x%08X MMCR1: 0x%08X SIA: 0x%08X SDA: 0x%08X\n"
MISC8:
.asciz "PMC1: 0x%08X PMC2: 0x%08X PMC3: 0x%08X PMC4: 0x%08X\n"
MISC9:
.asciz "UMMCR0: 0x%08X UMMCR1: 0x%08X USIA: 0x%08X USDA: 0x%08X\n"
MISC10:
.asciz "UPMC1: 0x%08X UPMC2: 0x%08X UPMC3: 0x%08X UPMC4: 0x%08X\n"
MISC11:
.asciz "EAR: 0x%08X ICTC: 0x%08X TDCH: 0x%08X TDCL: 0x%08X\n"
MISC12:
.asciz "cidh: 0x%08X cidm: 0x%08X cidl: 0x%08X PVR: 0x%08X\n"
MISCend:
.asciz "thrm0: 0x%08X thrm1: 0x%08X thrm2: 0x%08X thrm3: 0x%08X\n"
convertRegEC:
.asciz "Error! A sprintf error occurred when converting Register Integer Data to ASCII."
.align 2

/*x0 arg = ptr to artemis.html*/

.globl convertregisters
convertregisters:
stp fp, lr, [sp, -0x40]!
stp x19, x20, [sp, 0x10]
stp x21, x22, [sp, 0x20]
stp x23, x24, [sp, 0x30]
mov fp, sp

/*Save arg*/
mov x24, x0

/*Find null after the two instruction strings*/
ldrb w1, [x0], 1
cmp w1, 0
bne -0x8

/*Write Enter at null spot*/
mov w1, 0xA
strb w1, [x0, -0x1]

/*Use x19 for updating-cursor*/
mov x19, x0

/*Set Register Bank ptr in a non-volatile reg*/
ldr x20, [x27, 0x20]

/*Make a copy of it*/
mov x21, x20

/*sprintf all the GPRs*/
mov w22, 0 /*%d counter*/
mov w23, 16 /*loop tracker for GPR sprintf*/
gpr_sprintf_loop:
mov x0, x19 /*Update x0 with new cursor position*/
adr x1, GPRs
mov w2, w22
ldr w3, [x21], 4
add w4, w22, 1
ldr w5, [x21], 4
bl sprintf
cmp w0, 0
ble sprintf_error
subs w23, w23, 1
add w22, w22, 2
add x19, x19, x0 /*Move cursor forward*/
bne gpr_sprintf_loop

/*sprintf all the FPRs*/
mov w22, 0 /*Reset %d counter*/
mov w23, 16
/*FPR reg bak init ptr aleady set from GPR loop since FPRs in register bank reside directly after GPRs*/
fpr_sprintf_loop:
mov x0, x19
adr x1, FPRs
mov w2, w22
ldr x3, [x21], 8
add w4, w22, 1
ldr x5, [x21], 8
bl sprintf
cmp w0, 0
ble sprintf_error
subs w23, w23, 1
add w22, w22, 2
add x19, x19, x0 /*Move cursor forward*/
bne fpr_sprintf_loop

/*sprintf MainMISC reg's*/
adr x1, MainMISC
mov x0, x19
ldr w2, [x20, pc]
ldr w3, [x20, lrppc]
ldr w4, [x20, ctr]
ldr w5, [x20, cr]
bl sprintf
cmp w0, 0
ble sprintf_error
add x19, x19, x0 /*Move cursor forward*/

/*sprintf MISC1 regs*/
adr x1, MISC1
mov x0, x19
ldr w2, [x20, xer]
ldr w3, [x20, msr]
ldr w4, [x20, srr0]
ldr w5, [x20, srr1]
bl sprintf
cmp w0, 0
ble sprintf_error
add x19, x19, x0 /*Move cursor forward*/

/*sprintf MISC2 regs*/
adr x1, MISC2
mov x0, x19
ldr x2, [x20, tb] /*extended register, double-word width*/
ldr w3, [x20, fpscr]
ldr w4, [x20, dsisr]
ldr w5, [x20, dar]
bl sprintf
cmp w0, 0
ble sprintf_error
add x19, x19, x0 /*Move cursor forward*/

/*sprintf MISC3 regs*/
adr x1, MISC3
mov x0, x19
ldr w2, [x20, hid0]
ldr w3, [x20, hid1]
ldr w4, [x20, hid2]
ldr w5, [x20, hid4]
bl sprintf
cmp w0, 0
ble sprintf_error
add x19, x19, x0 /*Move cursor forward*/

/*sprintf MISC4 regs*/
adr x1, MISC4
mov x0, x19
ldr w2, [x20, dec]
ldr w3, [x20, sdr1]
ldr w4, [x20, l2cr]
ldr w5, [x20, wpar]
bl sprintf
cmp w0, 0
ble sprintf_error
add x19, x19, x0 /*Move cursor forward*/

/*sprintf all the IBATs*/
mov w22, 0 /*Reset %d counter*/
mov w23, 16
add x21, x20, ibat0
ibat_sprintf_loop:
mov x0, x19
adr x1, IBATs
mov w2, w22
ldr x3, [x21], 8 /*double word width*/
add w4, w22, 1
ldr x5, [x21], 8 /*double word width*/
bl sprintf
cmp w0, 0
ble sprintf_error
subs w23, w23, 1
add w22, w22, 2
add x19, x19, x0 /*Move cursor forward*/
bne ibat_sprintf_loop

/*sprintf all the DBATs*/
mov w22, 0 /*Reset %d counter*/
mov w23, 16
/*No need to set new x21 as DBATs reside directly after IBATs in reg bank*/
dbat_sprintf_loop:
mov x0, x19
adr x1, DBATs
mov w2, w22
ldr x3, [x21], 8
add w4, w22, 1
ldr x5, [x21], 8
bl sprintf
cmp w0, 0
ble sprintf_error
subs w23, w23, 1
add w22, w22, 2
add x19, x19, x0 /*Move cursor forward*/
bne dbat_sprintf_loop

/*sprintf all the SRs*/
mov w22, 0
mov w23, 8
add x21, x20, sr0
sr_sprintf_loop:
mov x0, x19 /*Update x0 with new cursor position*/
adr x1, SRs
mov w2, w22
ldr w3, [x21], 4
add w4, w22, 1
ldr w5, [x21], 4
bl sprintf
cmp w0, 0
ble sprintf_error
subs w23, w23, 1
add w22, w22, 2
add x19, x19, x0 /*Move cursor forward*/
bne sr_sprintf_loop

/*sprintf all the GQRs*/
mov w22, 0
mov w23, 4
add x21, x20, gqr0
gqr_sprintf_loop:
mov x0, x19 /*Update x0 with new cursor position*/
adr x1, GQRs
mov w2, w22
ldr w3, [x21], 4
add w4, w22, 1
ldr w5, [x21], 4
bl sprintf
cmp w0, 0
ble sprintf_error
subs w23, w23, 1
add w22, w22, 2
add x19, x19, x0 /*Move cursor forward*/
bne gqr_sprintf_loop

/*sprintf MISC5 regs*/
adr x1, MISC5
mov x0, x19
ldr w2, [x20, sprg0]
ldr w3, [x20, sprg1]
ldr w4, [x20, sprg2]
ldr w5, [x20, sprg3]
bl sprintf
cmp w0, 0
ble sprintf_error
add x19, x19, x0 /*Move cursor forward*/

/*sprintf MISC6 regs*/
adr x1, MISC6
mov x0, x19
ldr w2, [x20, iabr]
ldr w3, [x20, dabr]
ldr w4, [x20, dma_u]
ldr w5, [x20, dma_l]
bl sprintf
cmp w0, 0
ble sprintf_error
add x19, x19, x0 /*Move cursor forward*/

/*sprintf MISC7 regs*/
adr x1, MISC7
mov x0, x19
ldr w2, [x20, mmcr0]
ldr w3, [x20, mmcr1]
ldr w4, [x20, sia]
ldr w5, [x20, sda]
bl sprintf
cmp w0, 0
ble sprintf_error
add x19, x19, x0 /*Move cursor forward*/

/*sprintf MISC8 regs*/
adr x1, MISC8
mov x0, x19
ldr w2, [x20, pmc1]
ldr w3, [x20, pmc2]
ldr w4, [x20, pmc3]
ldr w5, [x20, pmc4]
bl sprintf
cmp w0, 0
ble sprintf_error
add x19, x19, x0 /*Move cursor forward*/

/*sprintf MISC9 regs*/
adr x1, MISC9
mov x0, x19
ldr w2, [x20, ummcr0]
ldr w3, [x20, ummcr1]
ldr w4, [x20, usia]
ldr w5, [x20, usda]
bl sprintf
cmp w0, 0
ble sprintf_error
add x19, x19, x0 /*Move cursor forward*/

/*sprintf MISC10 regs*/
adr x1, MISC10
mov x0, x19
ldr w2, [x20, upmc1]
ldr w3, [x20, upmc2]
ldr w4, [x20, upmc3]
ldr w5, [x20, upmc4]
bl sprintf
cmp w0, 0
ble sprintf_error
add x19, x19, x0 /*Move cursor forward*/

/*sprintf MISC11 regs*/
adr x1, MISC11
mov x0, x19
ldr w2, [x20, ear]
ldr w3, [x20, ictc]
ldr w4, [x20, tdch]
ldr w5, [x20, tdcl]
bl sprintf
cmp w0, 0
ble sprintf_error
add x19, x19, x0 /*Move cursor forward*/

/*sprintf MISC12 regs*/
adr x1, MISC12
mov x0, x19
ldr w2, [x20, cidh]
ldr w3, [x20, cidm]
ldr w4, [x20, cidl]
ldr w5, [x20, pvr]
bl sprintf
cmp w0, 0
ble sprintf_error
add x19, x19, x0 /*Move cursor forward*/

/*sprintf MISCend regs*/
adr x1, MISCend
mov x0, x19
ldr w2, [x20, thrm0]
ldr w3, [x20, thrm1]
ldr w4, [x20, thrm2]
ldr w5, [x20, thrm3]
bl sprintf
cmp w0, 0
ble sprintf_error
add x19, x19, x0 /*Move cursor forward*/

/*Calc size of artemis.txt to return back to Parent in x1*/
sub x1, x19, x24
add w1, w1, 1 /*Size can NEVER be beyond 32-bits in width*/

/*Success!*/
mov w0, 0
b convertregs_epilogue

/*Somehow a sprintf error occured*/
sprintf_error:
adr x0, convertRegEC

/*Epilogue*/
convertregs_epilogue:
ldp x23, x24, [sp, 0x30]
ldp x21, x22, [sp, 0x20]
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x40
ret

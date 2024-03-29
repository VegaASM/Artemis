#include "sub/sub2/global/registerbankmap.S"

/*This func will set all registers to their hard reset values*/

.globl hardreset
hardreset:

/*Get pointer to register bank*/
ldr x0, [x27, 0x20]

/*We need to null out the following
LR
CR
CTR
All HID's
FPSCR
XER
TimeBase
srr0
srr1
sdr1
sprg's
l2cr
mmcr
ummcr
all thrm's
pmc
upmc
sia
usia
ictc
all gqr's
wpar
dsisr
dar
dma u & l
*/

mov w1, 0
str w1, [x0, lrppc]
str w1, [x0, cr]
str w1, [x0, ctr]
str w1, [x0, hid0]
str w1, [x0, hid1]
str w1, [x0, hid2]
str w1, [x0, fpscr]
str w1, [x0, xer]
str x1, [x0, tbu] /*Null out entire TBR*/
str x1, [x0, srr0] /*Null out both srr's*/
str w1, [x0, sdr1]
str w1, [x0, sprg0] /*Null out all sprg's, Can no longer use doubleword store due to IMM limitations*/
str w1, [x0, sprg1]
str w1, [x0, sprg2]
str w1, [x0, sprg3]
str w1, [x0, l2cr]
str w1, [x0, ummcr0]
str w1, [x0, mmcr0]
str w1, [x0, thrm0] /*Null out all thrm's*/
str w1, [x0, thrm1]
str w1, [x0, thrm2]
str w1, [x0, thrm3]
str w1, [x0, upmc1]
str w1, [x0, upmc2]
str w1, [x0, upmc3]
str w1, [x0, upmc4]
str w1, [x0, pmc1]
str w1, [x0, pmc2]
str w1, [x0, pmc3]
str w1, [x0, pmc4]
str w1, [x0, usia]
str w1, [x0, sia] /*TODO write some code for ins simulate to always copy sia to usia*/
str w1, [x0, ictc]
str w1, [x0, gqr0] /*Null first 4 GQRs*/
str w1, [x0, gqr1]
str w1, [x0, gqr2]
str w1, [x0, gqr3]
str w1, [x0, gqr4]
str w1, [x0, gqr5]
str w1, [x0, gqr6]
str w1, [x0, gqr7]
str w1, [x0, wpar]
str w1, [x0, dsisr]
str w1, [x0, dar]
str w1, [x0, dma_u] /*Null out both dma reg's*/
str w1, [x0, dma_l]

/*and we set the following values of this for that..
dabr = breakpoint enable bit low, leave all other bits alone
dec = -1
msr = 0x40
pvr = some custom value we will come up with later
cid's = some custom value we will come up with later
pc = 0xFFF00100
*/

/*There's nothing mentioned about ibar hard reset value in the Broadway manual, but i'm sure it must be set up like dabr. its probably in the PPC Programming Environment Manual somewhere*/

/*Set dabr and iabr*/
ldr w1, [x0, dabr]
ldr w2, [x0, iabr]
bfc w1, 2, 1 /*Clear big-endian bit 29*/
bfc w2, 1, 1 /*Clear big-endian bit 30*/
str w1, [x0, dabr]
str w2, [x0, iabr]

/*Set dec, msr, and pc*/
mov w1, -1
str w1, [x0, dec]
mov w1, 0 /*TODO change back to 0x40 once we implement boot.bin fully*/
str w1, [x0, msr]
mov w1, 0x3400
/*movz w1, 0xFFF0, lsl 16  TODO implement in future versions
movk w1, 0x0100*/
str w1, [x0, pc]

/*HID4 big endian bit 0 (MSB) must always be high, thus it always hard resets as 0x80000000*/
mov w1, 0x80000000
str w1, [x0, hid4]

/*Reset Cache Addr list*/
/*
mov w0, Total_Cache_byte_size / 16
movz x1, 0x0001, lsl 32
movk x1, 0x0001
mov x2, x1
ldr x3, [x27, 0x60]
stp x1, x2, [x3], 8
subs w0, w0, 1
bne -0x8
*/

/*End func*/
ret

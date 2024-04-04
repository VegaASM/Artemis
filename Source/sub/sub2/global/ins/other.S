
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
//todo cr1 fp stuff
ret

.globl mfspr_ppc
mfspr_ppc:
ldr w2, [x0, rDoff] //get rD number
lsl w2, w2, 2
ldr w3, [x0, SPRoff] //grab SPR number
//TODO put in shit ton of checks for which SPR value to get
str w3, [x1, x2] //copy SPR to rD
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
ldr w2, [x0, SPRoff] //get SPR number
ldr w3, [x0, rSoff] //grab rS number
lsl w3, w3, 2
ldr w3, [x1, x3] //grab rS value
//TODO put in shit ton of checks for which SPR value to get
//PUT SPR into x2 before the str instruction!!!
str w3, [x1, x2] //copy SPR to rD
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

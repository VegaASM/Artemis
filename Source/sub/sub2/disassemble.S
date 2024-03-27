#include "global/ins/extractedPPCstuffOffsets.S"
#include "global/ins/instruction_strings.S"
#include "global/ppc_idents.S"

/*TODO put in branch, spr, condi-trap, and rotation mnemonicsc*/

disaEC:
.asciz "Error! A sprintf error occurred when running the Disassembler engine."
.align 2

/*Args
x0 = Where to store disassembled instruction
w1 = Instruction to disassemble
x2 = Address to store variables
w3 = Flag (do we store variables to x2 addr?)
*/

/*Returns
w0 = 0 Success, -Negative = sprintf failure
w1 (if w0 = 0); Instruction "Key/Ident"
*/

/*Handy symbols*/
.set rc, 0x00000001
.set oe, 0x00000400
.set lk, 0x00000001
.set aa, 0x00000002

/*Primary masks*/
.set addX, 0x7C000214
.set addcX, 0x7C000014
.set addeX, 0x7C000114
.set addi, 0x38000000
.set addic, 0x30000000
.set addicRC, 0x34000000
.set addis, 0x3C000000
.set addmeX, 0x7C0001D4
.set addzeX, 0x7C000194
.set andX, 0x7C000038
.set andcX, 0x7C000078
.set andiRC, 0x70000000
.set andisRC, 0x74000000
.set bX, 0x48000000
.set bcX, 0x40000000
.set bcctrX, 0x4C000420
.set bclrX, 0x4C000020 
.set cmpw, 0x7C000000 
.set cmpwi, 0x2C000000 
.set cmplw, 0x7C000040 
.set cmplwi, 0x28000000 
.set cntlzwX, 0x7C000034 
.set crand, 0x4C000202 
.set crandc, 0x4C000102 
.set creqv, 0x4C000242 
.set crnand, 0x4C0001C2 
.set crnor, 0x4C000042 
.set cror, 0x4C000382 
.set crorc, 0x4C000342 
.set crxor, 0x4C000182 
.set dcbf, 0x7C0000AC 
.set dcbi, 0x7C0003AC 
.set dcbst, 0x7C00006C 
.set dcbt, 0x7C00022C 
.set dcbtst, 0x7C0001EC 
.set dcbz, 0x7C0007EC 
.set dcbz_l, 0x100007EC 
.set divwX, 0x7C0003D6 
.set divwuX, 0x7C000396 
.set eciwx, 0x7C00026C 
.set ecowx, 0x7C00036C 
.set eieio, 0x7C0006AC 
.set eqvX, 0x7C000238 
.set extsbX, 0x7C000774 
.set extshX, 0x7C000734 
.set fabsX, 0xFC000210 
.set faddX, 0xFC00002A 
.set faddsX, 0xEC00002A 
.set fcmpo, 0xFC000040 
.set fcmpu, 0xFC000000 
.set fctiwX, 0xFC00001C 
.set fctiwzX, 0xFC00001E 
.set fdivX, 0xFC000024 
.set fdivsX, 0xEC000024 
.set fmaddX, 0xFC00003A 
.set fmaddsX, 0xEC00003A 
.set fmrX, 0xFC000090 
.set fmsubX, 0xFC000038 
.set fmsubsX, 0xEC000038 
.set fmulX, 0xFC000032 
.set fmulsX, 0xEC000032 
.set fnabsX, 0xFC000110 
.set fnegX, 0xFC000050 
.set fnmaddX, 0xFC00003E 
.set fnmaddsX, 0xEC00003E 
.set fnmsubX, 0xFC00003C 
.set fnmsubsX, 0xEC00003C 
.set fresX, 0xEC000030 
.set frspX, 0xFC000018 
.set frsqrteX, 0xFC000034 
.set fselX, 0xFC00002E 
.set fsubX, 0xFC000028 
.set fsubsX, 0xEC000028 
.set icbi, 0x7C0007AC 
.set isync, 0x4C00012C 
.set lbz, 0x88000000 
.set lbzu, 0x8C000000 
.set lbzux, 0x7C0000EE 
.set lbzx, 0x7C0000AE 
.set lfd, 0xC8000000 
.set lfdu, 0xCC000000 
.set lfdux, 0x7C0004EE 
.set lfdx, 0x7C0004AE 
.set lfs, 0xC0000000 
.set lfsu, 0xC4000000 
.set lfsux, 0x7C00046E 
.set lfsx, 0x7C00042E 
.set lha, 0xA8000000 
.set lhau, 0xAC000000 
.set lhaux, 0x7C0002EE 
.set lhax, 0x7C0002AE 
.set lhbrx, 0x7C00062C 
.set lhz, 0xA0000000 
.set lhzu, 0xA4000000 
.set lhzux, 0x7C00026E 
.set lhzx, 0x7C00022E 
.set lmw, 0xB8000000 
.set lswi, 0x7C0004AA 
.set lswx, 0x7C00042A 
.set lwarx, 0x7C000028 
.set lwbrx, 0x7C00042C 
.set lwz, 0x80000000 
.set lwzu, 0x84000000 
.set lwzux, 0x7C00006E 
.set lwzx, 0x7C00002E 
.set mcrf, 0x4C000000 
.set mcrfs, 0xFC000080 
.set mcrxr, 0x7C000400 
.set mfcr, 0x7C000026 
.set mffsX, 0xFC00048E 
.set mfmsr, 0x7C0000A6 
.set mfspr, 0x7C0002A6 
.set mfsr, 0x7C0004A6 
.set mfsrin, 0x7C000526 
.set mftb, 0x7C0002E6 
.set mtcrf, 0x7C000120 
.set mtfsb0X, 0xFC00008C 
.set mtfsb1X, 0xFC00004C 
.set mtfsfX, 0xFC00058E 
.set mtfsfiX, 0xFC00010C 
.set mtmsr, 0x7C000124 
.set mtspr, 0x7C0003A6 
.set mtsr, 0x7C0001A4 
.set mtsrin, 0x7C0001E4 
.set mulhwX, 0x7C000096 
.set mulhwuX, 0x7C000016 
.set mulli, 0x1C000000 
.set mullwX, 0x7C0001D6 
.set nandX, 0x7C0003B8 
.set negX, 0x7C0000D0 
.set norX, 0x7C0000F8 
.set orX, 0x7C000378 
.set orcX, 0x7C000338 
.set ori, 0x60000000 
.set oris, 0x64000000 
.set psq_l, 0xE0000000 
.set psq_lu, 0xE4000000 
.set psq_lux, 0x1000004C 
.set psq_lx, 0x1000000C 
.set psq_st, 0xF0000000 
.set psq_stu, 0xF4000000 
.set psq_stux, 0x1000004E 
.set psq_stx, 0x1000000E 
.set ps_absX, 0x10000210 
.set ps_addX, 0x1000002A 
.set ps_cmpo0, 0x10000040 
.set ps_cmpo1, 0x100000C0 
.set ps_cmpu0, 0x10000000 
.set ps_cmpu1, 0x10000080 
.set ps_divX, 0x10000024 
.set ps_maddX, 0x1000003A 
.set ps_madds0X, 0x1000001C 
.set ps_madds1X, 0x1000001E 
.set ps_merge00X, 0x10000420 
.set ps_merge01X, 0x10000460 
.set ps_merge10X, 0x100004A0 
.set ps_merge11X, 0x100004E0 
.set ps_mrX, 0x10000090 
.set ps_msubX, 0x10000038 
.set ps_mulX, 0x10000032 
.set ps_muls0X, 0x10000018 
.set ps_muls1X, 0x1000001A 
.set ps_nabsX, 0x10000110 
.set ps_negX, 0x10000050 
.set ps_nmaddX, 0x1000003E 
.set ps_nmsubX, 0x1000003C 
.set ps_resX, 0x10000030 
.set ps_rsqrteX, 0x10000034 
.set ps_selX, 0x1000002E 
.set ps_subX, 0x10000028 
.set ps_sum0X, 0x10000014 
.set ps_sum1X, 0x10000016 
.set rfi, 0x4C000064 
.set rlwimiX, 0x50000000 
.set rlwinmX, 0x54000000 
.set rlwnmX, 0x5C000000 
.set sc, 0x44000002 
.set slwX, 0x7C000030 
.set srawX, 0x7C000630 
.set srawiX, 0x7C000670 
.set srwX, 0x7C000430 
.set stb, 0x98000000 
.set stbu, 0x9C000000 
.set stbux, 0x7C0001EE 
.set stbx, 0x7C0001AE 
.set stfd, 0xD8000000 
.set stfdu, 0xDC000000 
.set stfdux, 0x7C0005EE 
.set stfdx, 0x7C0005AE 
.set stfiwx, 0x7C0007AE 
.set stfs, 0xD0000000 
.set stfsu, 0xD4000000 
.set stfsux, 0x7C00056E 
.set stfsx, 0x7C00052E 
.set sth, 0xB0000000 
.set sthbrx, 0x7C00072C 
.set sthu, 0xB4000000 
.set sthux, 0x7C00036E 
.set sthx, 0x7C00032E 
.set stmw, 0xBC000000 
.set stswi, 0x7C0005AA 
.set stswx, 0x7C00052A 
.set stw, 0x90000000 
.set stwbrx, 0x7C00052C 
.set stwcxRC, 0x7C00012D 
.set stwu, 0x94000000 
.set stwux, 0x7C00016E 
.set stwx, 0x7C00012E 
.set subX, 0x7C000050 
.set subcX, 0x7C000010
.set subfeX, 0x7C000110 
.set subfic, 0x20000000
.set subfmeX, 0x7C0001D0
.set subfzeX, 0x7C000190
.set sync, 0x7C0004AC
.set tlbie, 0x7C000264
.set tlbsync, 0x7C00046C
.set tw, 0x7C000008
.set twi, 0x0C000000
.set xorX, 0x7C000278
.set xori, 0x68000000
.set xoris, 0x6C000000

/*Symbols for Secondary Check Masks*/
.set check_cmps1, 0x006007FF /*cmpw, fcmpu, ps_cmpu0*/
.set check_cmps2, 0x00600001 /*cmplw, fcmpo, ps_cmpo0, ps_cmpo1, ps_cmpu1*/
.set check_cache, 0x03E00001 /*for all cache related instructions*/
.set check_syncs, 0x03FFF801 /*for eieio, rfi, and all sync-type instructions*/
.set check_res_sqrt, 0x001F07C0 /*for res and rsqrte type instructions*/
.set check_mcrf, 0x0063FFFF /*mcrf*/
.set check_mcrfs, 0x0063F801 /*mcrfs*/
.set check_mcrxr, 0x007FF801 /*mcrxr*/
.set check_cr_msr, 0x001FF801 /*mfcr, mfmsr, mtmsr*/
.set check_fs_fsb, 0x001FF800 /*mffsX, mtfsb0X, mtfsb1X*/
.set check_sr, 0x0010F801 /*mfsr, mtsr*/
.set check_srin, 0x001F0001 /*mfsrin, mtsrin*/
.set check_mtcrf, 0x00100801 /*mtcrf*/
.set check_mtfsfiX, 0x007F0800 /*mtfsfiX*/
.set check_sc, 0x03FFFFFD /*sc*/
.set check_tlbie, 0x03FF0001 /*tlbie*/

.macro check_nullrA /*Also used for fA. Not in second_check since we can AND it in one go.*/
tst w19, 0x001F0000
.endm

.macro float_ps_update_and_store_update_special_check /*NOTE When using this (compared to nullrA), make sure to flip the bool check!!!*/
tst w19, 0x001F0000
.endm

.macro check_nullrB /*Also used for fB. Not in second_check since we can AND it in one go*/
tst w19, 0xF800
.endm

.macro check_nullfC /*Not in second_check since we can AND it in one go*/
tst w19, 0x07C0
.endm

.macro check_cmpXwi /*Not in second_check since we can AND it in one go*/
tst w19, 0x0060
.endm

.macro check_b31 /*For cr ops, ux, and x, mfspr, mftb, mtspr, stfiwx, sthbrx, lwbrx, lswi, stswi, tw .Not in second_check since we can AND it in one go*/
tst w19, 1
.endm

.macro check_mtfsfX /*For mtfsfX. Not in second_check since we can AND it in one go*/
movz w0, 0x0201
tst w19, w0
.endm

.macro check_b21 /*For mulhwX and mulhwuX. Not in second_check since we can AND it in one go*/
tst w19, 0x0200
.endm


/*Macros for Handy instructions*/

/*Macros for rD/rS/etc slot*/
.macro rD register
ubfx \register, w19, 21, 5
.endm

.macro rS register
ubfx \register, w19, 21, 5
.endm

/*TODO remove me after adding all branch shit*/
.macro BO register /*"rD" for cond branches*/
ubfx \register, w19, 21, 5
.endm

.macro crbD register
ubfx \register, w19, 21, 5
.endm

.macro fD register
ubfx \register, w19, 21, 5
.endm

.macro fS register
ubfx \register, w19, 21, 5
.endm

.macro TO register /*For tw and twi*/
ubfx \register, w19, 21, 5
.endm

/*Macro for crf's*/
.macro crfD register
ubfx \register, w19, 23, 3
.endm

.macro crfS register
ubfx \register, w19, 18, 3
.endm

/*Macros for rA/fA/etc slot*/
.macro rA register
ubfx \register, w19, 16, 5
.endm

.macro BI register /*"rA"*/
ubfx \register, w19, 16, 5
.endm

.macro crbA register
ubfx \register, w19, 16, 5
.endm

.macro fA register
ubfx \register, w19, 16, 5
.endm

/*Macros for rB/NB/etc slot*/
.macro rB register
ubfx \register, w19, 11, 5
.endm

.macro fB register
ubfx \register, w19, 11, 5
.endm

.macro NB register /*For lswi and stswi*/
ubfx \register, w19, 11, 5
.endm

.macro crbB register
ubfx \register, w19, 11, 5
.endm

.macro SH register
ubfx \register, w19, 11, 5
.endm

/*Macros for rC and MB*/
.macro fC register
ubfx \register, w19, 6, 5
.endm

.macro MB register
ubfx \register, w19, 6, 5
.endm

/*Macro for ME*/
.macro ME register
ubfx \register, w19, 1, 5
.endm

/*Macros for IMM's*/
.macro SIMM register
sbfx \register, w19, 0, 16
.endm

.macro d register /*NOTE if weird bugs happen this macro name may not be accepted!*/
sbfx \register, w19, 0, 16
.endm

.macro UIMM register
ubfx \register, w19, 0, 16
.endm

.macro LI_SIMM register /*for unconditional branches*/
sbfx \register, w19, 0, 26
and \register, \register, 0xFFFFFFFC
.endm

.macro BD register /*SIMM for cond branches*/
sbfx \register, w19, 0, 16
and \register, \register, 0xFFFFFFFC
.endm

.macro ps_SIMM register /*SIMM for psq's*/
sbfx \register, w19, 0, 12
.endm

.macro IMM register /*For mtfsfiX*/
ubfx \register, w19, 12, 4
.endm

/*Macro for misc registers*/
.macro SPR register1 register2
ubfx \register1, w19, 16, 5
ubfx \register2, w19, 11, 5
bfi \register1, \register2, 5, 5
.endm

.macro TBR register1, register2
ubfx \register1, w19, 16, 5
ubfx \register2, w19, 11, 5
bfi \register1, \register2, 5, 5
.endm

.macro SR register
ubfx \register, w19, 16, 4
.endm

.macro CRM register
ubfx \register, w19, 12, 8
.endm

.macro FM register
ubfx \register, w19, 17, 8
.endm

.macro W_nonx register /*W in non-indexed psq load and stores*/
ubfx \register, w19, 15, 1
.endm

.macro I_nonx register /*I in non-indexed psq load and stores*/
ubfx \register, w19, 12, 3
.endm

.macro W_x register /*W in indexed psq load and stores*/
ubfx \register, w19, 10, 1
.endm

.macro I_x register /*I in indexed psq load and stores*/
ubfx \register, w19, 7, 3
.endm

.macro BO_nohint register 
ubfx \register, w19, 22, 4
.endm

.macro BO_onlyhint register
ubfx \register, w19, 21, 1
.endm

.macro BO_onlyhint_bcX register1, register2
/*When BD is negative for bcX instruction, the hint bit has to be flipped*/
ubfx \register1, w19, 15, 1 /*Extract BD's sign bit*/
ubfx \register2, w19, 21, 1 /*Extract gross hint bit*/
eor \register1, \register1, \register2 /*XOR it*/
.endm

.macro findcrbtype register
/*Shift BI normally by 16 to right, but only look at last 2 bits, this will give us lt vs gt vs eq vs so crB type*/
ubfx \register, w19, 16, 2
.endm

.macro crfD_manual register
/*BI divided by 4, then round down. We can do this in a single "instruction". This will give us the crf Number for BI*/
ubfx \register, w19, 18, 3
/*TODO NOTE DOUBLE CHECK ABOVE during debug rlwinm \register, r31, 14, 0x7*/
.endm

/*Macros for the w0 arg of first_check */
.macro b21_30
mov w0, w21
.endm

.macro b22_30
mov w0, w22
.endm

.macro b25_30
mov w0, w23
.endm

.macro b26_30
mov w0, w24
.endm

.macro chkOpcode
mov w0, 0xFC000000
.endm

/*.macro b30sc
and w0, w24, 0xFC000000
.endm*/

.globl disassemble
disassemble:
/*Prologue*/
cmp w3, 0
stp fp, lr, [sp, -0x60]!
stp x19, x20, [sp, 0x10]
stp x21, x22, [sp, 0x20]
stp x23, x24, [sp, 0x30]
stp x25, x26, [sp, 0x40]
str x27, [sp, 0x50]
mov fp, sp
mov w19, w1 /*Need this now because macros use hard constant of w19*/
beq set_non_vol_stuff

/*Extract every item and temp store in stack space, YUCK!*/
rD w4
crfD w5
crfS w6
rA w7
rB w8
fC w9
ME w10
SIMM w11
UIMM w12
LI_SIMM w13
BD w14
ps_SIMM w15
IMM w16
SPR w17, w18
SR w18
CRM w3
FM w20
W_nonx w21
I_nonx w22
W_x w23
I_x w24
BO_nohint w25
BO_onlyhint w26
BO_onlyhint_bcX w27, w28
str w4, [x2]
str w5, [x2, 4]
str w6, [x2, 8]
str w7, [x2, 0xC]
str w8, [x2, 0x10]
str w9, [x2, 0x14]
str w10, [x2, 0x18]
str w11, [x2, 0x1C]
str w12, [x2, 0x20]
str w13, [x2, 0x24]
str w14, [x2, 0x28]
str w15, [x2, 0x2C]
str w16, [x2, 0x30]
str w17, [x2, 0x34]
str w18, [x2, 0x38]
str w3, [x2, 0x3C]
str w20, [x2, 0x40]
str w21, [x2, 0x44]
str w22, [x2, 0x48]
str w23, [x2, 0x4C]
str w24, [x2, 0x50]
str w25, [x2, 0x54]
str w26, [x2, 0x58]
str w27, [x2, 0x5C]

/*Set Non-Volatile Regs & Save Args*/
set_non_vol_stuff:
mov w25, 0xFC000000
mov x20, x0
mov x26, x2 /*TODO Put in proper GVR and adjust other GVRs eventually*/
orr w24, w25, 0x003E
orr w23, w25, 0x007E
orr w22, w25, 0x03FE
orr w21, w25, 0x07FE

/*Start checks*/
/*addX*/
b22_30
movz w1, :abs_g1: addX
movk w1, :abs_g0_nc: addX
bl first_check
cbnz w0, addXfound

/*addcX*/
b22_30
movz w1, :abs_g1: addcX
movk w1, :abs_g0_nc: addcX
bl first_check
cbnz w0, addcXfound

/*addeX*/
b22_30
movz w1, :abs_g1: addeX
movk w1, :abs_g0_nc: addeX
bl first_check
cbnz w0, addeXfound

/*addi*/
chkOpcode
mov w1, addi
bl first_check
cbnz w0, addifound

/*addic*/
chkOpcode
mov w1, addic
bl first_check
cbnz w0, addicfound

/*addicRC*/
chkOpcode
mov w1, addicRC
bl first_check
cbnz w0, addicRCfound

/*addis*/
chkOpcode
mov w1, addis
bl first_check
cbnz w0, addisfound

/*addmeX*/
b22_30
movz w1, :abs_g1:addmeX
movk w1, :abs_g0_nc:addmeX
bl first_check
cbz w0, 0xC
check_nullrB
cbz w0, addmeXfound

/*addzeX*/
b22_30
movz w1, :abs_g1:addzeX
movk w1, :abs_g0_nc:addzeX
bl first_check
cbz w0, 0xC
check_nullrB
cbz w0, addzeXfound

/*andX*/
b21_30
movz w1, :abs_g1:andX
movk w1, :abs_g0_nc:andX
bl first_check
cbnz w0, andXfound

/*andcX*/
b21_30
movz w1, :abs_g1:andcX
movk w1, :abs_g0_nc:andcX
bl first_check
cbnz w0, andcXfound

/*andi.*/
chkOpcode
mov w1, andiRC
bl first_check
cbnz w0, andiRCfound

/*andis.*/
chkOpcode
mov w1, andisRC
bl first_check
cbnz w0, andisRCfound

/*bX*/
chkOpcode
mov w1, bX
bl first_check
cbnz w0, bXfound

/*bcX*/
chkOpcode
mov w1, bcX
bl first_check
cbnz w0, bcXfound

/*bcctrX*/
b21_30
movz w1, :abs_g1:bcctrX
movk w1, :abs_g0_nc:bcctrX
bl first_check
cbz w0, 0xC
check_nullrB
cbz w0, bcctrXfound

/*bclr*/
b21_30
movz w1, :abs_g1:bclrX
movk w1, :abs_g0_nc:bclrX
bl first_check
cbz w0, 0xC
check_nullrB
cbz w0, bclrXfound

/*cmpw*/
chkOpcode
mov w1, cmpw
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_cmps1
movk w0, :abs_g0_nc:check_cmps1
bl second_check
cbnz w0, cmpwfound

/*cmpwi*/
chkOpcode
mov w1, cmpwi
bl first_check
cbz w0, 0xC
check_cmpXwi
cbz w0, cmpwifound

/*cmplw*/
b21_30
movz w1, :abs_g1:cmplw
movk w1, :abs_g0_nc:cmplw
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_cmps2
movk w0, :abs_g0_nc:check_cmps2
bl second_check
cbnz w0, cmplwfound

/*cmplwi*/
chkOpcode
mov w1, cmplwi
bl first_check
cbz w0, 0xC
check_cmpXwi
cbz w0, cmplwifound

/*cntlzwX*/
b21_30
movz w1, :abs_g1:cntlzwX
movk w1, :abs_g0_nc:cntlzwX
bl first_check
cbz w0, 0xC
check_nullrB
cbz w0, cntlzwXfound

/*crand*/
b21_30
movz w1, :abs_g1:crand
movk w1, :abs_g0_nc:crand
bl first_check
cbz w0, 0xC
check_b31
cbz w0, crandfound

/*crandc*/
b21_30
movz w1, :abs_g1:crandc
movk w1, :abs_g0_nc:crandc
bl first_check
cbz w0, 0xC
check_b31
cbz w0, crandcfound

/*creqv*/
b21_30
movz w1, :abs_g1:creqv
movk w1, :abs_g0_nc:creqv
bl first_check
cbz w0, 0xC
check_b31
cbz w0, creqvfound

/*crnand*/
b21_30
movz w1, :abs_g1:crnand
movk w1, :abs_g0_nc:crnand
bl first_check
cbz w0, 0xC
check_b31
cbz w0, crnandfound

/*crnor*/
b21_30
movz w1, :abs_g1:crnor
movk w1, :abs_g0_nc:crnor
bl first_check
cbz w0, 0xC
check_b31
cbz w0, crnorfound

/*cror*/
b21_30
movz w1, :abs_g1:cror
movk w1, :abs_g0_nc:cror
bl first_check
cbz w0, 0xC
check_b31
cbz w0, crorfound

/*crorc*/
b21_30
movz w1, :abs_g1:crorc
movk w1, :abs_g0_nc:crorc
bl first_check
cbz w0, 0xC
check_b31
cbz w0, crorcfound

/*crxor*/
b21_30
movz w1, :abs_g1:crxor
movk w1, :abs_g0_nc:crxor
bl first_check
cbz w0, 0xC
check_b31
cbz w0, crxorfound

/*dcbf*/
b21_30
movz w1, :abs_g1:dcbf
movk w1, :abs_g0_nc:dcbf
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_cache
movk w0, :abs_g0_nc:check_cache
bl second_check
cbnz w0, dcbffound

/*dcbi*/
b21_30
movz w1, :abs_g1:dcbi
movk w1, :abs_g0_nc:dcbi
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_cache
movk w0, :abs_g0_nc:check_cache
bl second_check
cbnz w0, dcbifound

/*dcbst*/
b21_30
movz w1, :abs_g1:dcbst
movk w1, :abs_g0_nc:dcbst
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_cache
movk w0, :abs_g0_nc:check_cache
bl second_check
cbnz w0, dcbstfound

/*dcbt*/
b21_30
movz w1, :abs_g1:dcbt
movk w1, :abs_g0_nc:dcbt
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_cache
movk w0, :abs_g0_nc:check_cache
bl second_check
cbnz w0, dcbtfound

/*dcbtst*/
b21_30
movz w1, :abs_g1:dcbtst
movk w1, :abs_g0_nc:dcbtst
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_cache
movk w0, :abs_g0_nc:check_cache
bl second_check
cbnz w0, dcbtstfound

/*dcbz*/
b21_30
movz w1, :abs_g1:dcbz
movk w1, :abs_g0_nc:dcbz
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_cache
movk w0, :abs_g0_nc:check_cache
bl second_check
cbnz w0, dcbzfound

/*dcbz_l*/
b21_30
movz w1, :abs_g1:dcbz_l
movk w1, :abs_g0_nc:dcbz_l
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_cache
movk w0, :abs_g0_nc:check_cache
bl second_check
cbnz w0, dcbz_lfound

/*divwX*/
b22_30
movz w1, :abs_g1:divwX
movk w1, :abs_g0_nc:divwX
bl first_check
cbnz w0, divwXfound

/*divwuX*/
b22_30
movz w1, :abs_g1:divwuX
movk w1, :abs_g0_nc:divwuX
bl first_check
cbnz w0, divwuXfound

/*eciwx*/
b21_30
movz w1, :abs_g1:eciwx
movk w1, :abs_g0_nc:eciwx
bl first_check
cbz w0, 0xC
check_b31
cbz w0, eciwxfound

/*ecowx*/
b21_30
movz w1, :abs_g1:ecowx
movk w1, :abs_g0_nc:ecowx
bl first_check
cbz w0, 0xC
check_b31
cbz w0, ecowxfound

/*eieio*/
b21_30
movz w1, :abs_g1:eieio
movk w1, :abs_g0_nc:eieio
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_syncs
movk w0, :abs_g0_nc:check_syncs
bl second_check
cbnz w0, eieiofound

/*eqvX*/
b21_30
movz w1, :abs_g1:eqvX
movk w1, :abs_g0_nc:eqvX
bl first_check
cbnz w0, eqvXfound

/*extsbX*/
b21_30
movz w1, :abs_g1:extsbX
movk w1, :abs_g0_nc:extsbX
bl first_check
cbz w0, 0xC
check_nullrB
cbz w0, extsbXfound

/*extshX*/
b21_30
movz w1, :abs_g1:extshX
movk w1, :abs_g0_nc:extshX
bl first_check
cbz w0, 0xC
check_nullrB
cbz w0, extshXfound

/*fabsX*/
b21_30
movz w1, :abs_g1:fabsX
movk w1, :abs_g0_nc:fabsX
bl first_check
cbz w0, 0xC
check_nullrA
cbz w0, fabsXfound

/*faddX*/
b26_30
movz w1, :abs_g1:faddX
movk w1, :abs_g0_nc:faddX
bl first_check
cbz w0, 0xC
check_nullfC
cbz w0, faddXfound

/*faddsX*/
b26_30
movz w1, :abs_g1:faddsX
movk w1, :abs_g0_nc:faddsX
bl first_check
cbz w0, 0xC
check_nullfC
cbz w0, faddsXfound

/*fcmpo*/
b21_30
movz w1, :abs_g1:fcmpo
movk w1, :abs_g0_nc:fcmpo
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_cmps2
movk w0, :abs_g0_nc:check_cmps2
bl second_check
cbnz w0, fcmpofound

/*fcmpu*/
b21_30
movz w1, :abs_g1:fcmpu
movk w1, :abs_g0_nc:fcmpu
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_cmps1
movk w0, :abs_g0_nc:check_cmps1
bl second_check
cbnz w0, fcmpufound

/*fctiwX*/
b21_30
movz w1, :abs_g1:fctiwX
movk w1, :abs_g0_nc:fctiwX
bl first_check
cbz w0, 0xC
check_nullrA
cbz w0, fctiwXfound

/*fctiwzX*/
b21_30
movz w1, :abs_g1:fctiwzX
movk w1, :abs_g0_nc:fctiwzX
bl first_check
cbz w0, 0xC
check_nullrA
cbz w0, fctiwzXfound

/*fdivX*/
b26_30
movz w1, :abs_g1:fdivX
movk w1, :abs_g0_nc:fdivX
bl first_check
cbz w0, 0xC
check_nullfC
cbz w0, fdivXfound

/*fdivsX*/
b26_30
movz w1, :abs_g1:fdivsX
movk w1, :abs_g0_nc:fdivsX
bl first_check
cbz w0, 0xC
check_nullfC
cbz w0, fdivsXfound

/*fmaddX*/
b26_30
movz w1, :abs_g1:fmaddX
movk w1, :abs_g0_nc:fmaddX
bl first_check
cbnz w0, fmaddXfound

/*fmaddsX*/
b26_30
movz w1, :abs_g1:fmaddsX
movk w1, :abs_g0_nc:fmaddsX
bl first_check
cbnz w0, fmaddsXfound

/*fmrX*/
b21_30
movz w1, :abs_g1:fmrX
movk w1, :abs_g0_nc:fmrX
bl first_check
cbz w0, 0xC
check_nullrA
cbz w0, fmrXfound

/*fmsubX*/
b26_30
movz w1, :abs_g1:fmsubX
movk w1, :abs_g0_nc:fmsubX
bl first_check
cbnz w0, fmsubXfound

/*fmsubsX*/
b26_30
movz w1, :abs_g1:fmsubsX
movk w1, :abs_g0_nc:fmsubsX
bl first_check
cbnz w0, fmsubsXfound

/*fmulX*/
b26_30
movz w1, :abs_g1:fmulX
movk w1, :abs_g0_nc:fmulX
bl first_check
cbz w0, 0xC
check_nullrB
cbz w0, fmulXfound

/*fmuls*/
b26_30
movz w1, :abs_g1:fmulsX
movk w1, :abs_g0_nc:fmulsX
bl first_check
cbz w0, 0xC
check_nullrB
cbz w0, fmulsXfound

/*fnabsX*/
b21_30
movz w1, :abs_g1:fnabsX
movk w1, :abs_g0_nc:fnabsX
bl first_check
cbz w0, 0xC
check_nullrA
cbz w0, fnabsXfound

/*fnegX*/
b21_30
movz w1, :abs_g1:fnegX
movk w1, :abs_g0_nc:fnegX
bl first_check
cbz w0, 0xC
check_nullrA
cbz w0, fnegXfound

/*fnmaddX*/
b26_30
movz w1, :abs_g1:fnmaddX
movk w1, :abs_g0_nc:fnmaddX
bl first_check
cbnz w0, fnmaddXfound

/*fnmaddsX*/
b26_30
movz w1, :abs_g1:fnmaddsX
movk w1, :abs_g0_nc:fnmaddsX
bl first_check
cbnz w0, fnmaddsXfound

/*fnmsubX*/
b26_30
movz w1, :abs_g1:fnmsubX
movk w1, :abs_g0_nc:fnmsubX
bl first_check
cbnz w0, fnmsubXfound

/*fnmsubsX*/
b26_30
movz w1, :abs_g1:fnmsubsX
movk w1, :abs_g0_nc:fnmsubsX
bl first_check
cbnz w0, fnmsubsXfound

/*fresX*/
b26_30
movz w1, :abs_g1:fresX
movk w1, :abs_g0_nc:fresX
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_res_sqrt
movk w0, :abs_g0_nc:check_res_sqrt
bl second_check
cbnz w0, fresXfound

/*frspX*/
b21_30
movz w1, :abs_g1:frspX
movk w1, :abs_g0_nc:frspX
bl first_check
cbz w0, 0xC
check_nullrA
cbz w0, frspXfound

/*frsqrteX*/
b26_30
movz w1, :abs_g1:frsqrteX
movk w1, :abs_g0_nc:frsqrteX
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_res_sqrt
movk w0, :abs_g0_nc:check_res_sqrt
bl second_check
cbnz w0, frsqrteXfound

/*fselX*/
b26_30
movz w1, :abs_g1:fselX
movk w1, :abs_g0_nc:fselX
bl first_check
cbnz w0, fselXfound

/*fsubX*/
b26_30
movz w1, :abs_g1:fsubX
movk w1, :abs_g0_nc:fsubX
bl first_check
cbz w0, 0xC
check_nullfC
cbz w0, fsubXfound

/*fsubsX*/
b26_30
movz w1, :abs_g1:fsubsX
movk w1, :abs_g0_nc:fsubsX
bl first_check
cbz w0, 0xC
check_nullfC
cbz w0, fsubsXfound

/*icbi*/
b21_30
movz w1, :abs_g1:icbi
movk w1, :abs_g0_nc:icbi
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_cache
movk w0, :abs_g0_nc:check_cache
bl second_check
cbnz w0, icbifound

/*isync*/
b21_30
movz w1, :abs_g1:isync
movk w1, :abs_g0_nc:isync
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_syncs
movk w0, :abs_g0_nc:check_syncs
bl second_check
cbnz w0, icbifound

/*lbz*/
chkOpcode
mov w1, lbz
bl first_check
cbnz w0, lbzfound

/*lbzu*/
chkOpcode
mov w1, lbzu
bl first_check
cbz w0, 0xC
bl lXzu_lXzux_special_check
cbnz w0, lbzufound

/*lbzux*/
b21_30
movz w1, :abs_g1:lbzux
movk w1, :abs_g0_nc:lbzux
bl first_check
cbz w0, 0x14
check_b31
cbnz w0, 0XC
bl lXzu_lXzux_special_check
cbnz w0, lbzuxfound

/*lbzx*/
b21_30
movz w1, :abs_g1:lbzx
movk w1, :abs_g0_nc:lbzx
bl first_check
cbz w0, 0xC
check_b31
cbz w0, lbzxfound

/*lfd*/
chkOpcode
mov w1, lfd
bl first_check
cbnz w0, lfdfound

/*lfdu*/
chkOpcode
mov w1, lfdu
bl first_check
cbz w0, 0xC
float_ps_update_and_store_update_special_check
cbnz w0, lfdufound

/*lfdux*/
b21_30
movz w1, :abs_g1:lfdux
movk w1, :abs_g0_nc:lfdux
bl first_check
cbz w0, 0x14
check_b31
cbnz w0, 0XC
float_ps_update_and_store_update_special_check
cbnz w0, lfduxfound

/*lfdx*/
b21_30
movz w1, :abs_g1:lfdx
movk w1, :abs_g0_nc:lfdx
bl first_check
cbz w0, 0xC
check_b31
cbz w0, lfdxfound

/*lfs*/
chkOpcode
mov w1, lfs
bl first_check
cbnz w0, lfsfound

/*lfsu*/
chkOpcode
mov w1, lfsu
bl first_check
cbz w0, 0xC
float_ps_update_and_store_update_special_check
cbnz w0, lfsufound

/*lfsux*/
b21_30
movz w1, :abs_g1:lfsux
movk w1, :abs_g0_nc:lfsux
bl first_check
cbz w0, 0x14
check_b31
cbnz w0, 0XC
float_ps_update_and_store_update_special_check
cbnz w0, lfsuxfound

/*lfsx*/
b21_30
movz w1, :abs_g1:lfsx
movk w1, :abs_g0_nc:lfsx
bl first_check
cbz w0, 0xC
check_b31
cbz w0, lfsxfound

/*lha*/
chkOpcode
mov w1, lha
bl first_check
cbnz w0, lhafound

/*lhau*/
chkOpcode
mov w1, lhau
bl first_check
cbz w0, 0xC
bl lXzu_lXzux_special_check
cbnz w0, lhaufound

/*lhaux*/
b21_30
movz w1, :abs_g1:lhaux
movk w1, :abs_g0_nc:lhaux
bl first_check
cbz w0, 0x14
check_b31
cbnz w0, 0XC
bl lXzu_lXzux_special_check
cbnz w0, lhauxfound

/*lhax*/
b21_30
movz w1, :abs_g1:lhax
movk w1, :abs_g0_nc:lhax
bl first_check
cbz w0, 0xC
check_b31
cbz w0, lhaxfound

/*lhbrx*/
b21_30
movz w1, :abs_g1:lhbrx
movk w1, :abs_g0_nc:lhbrx
bl first_check
cbz w0, 0x14
check_b31
cbnz w0, 0XC
bl lXzu_lXzux_special_check
cbnz w0, lhbrxfound

/*lhz*/
chkOpcode
mov w1, lhz
bl first_check
cbnz w0, lhzfound

/*lhzu*/
chkOpcode
mov w1, lhzu
bl first_check
cbz w0, 0xC
bl lXzu_lXzux_special_check
cbnz w0, lhzufound

/*lhzux*/
b21_30
movz w1, :abs_g1:lhzux
movk w1, :abs_g0_nc:lhzux
bl first_check
cbz w0, 0x14
check_b31
cbnz w0, 0XC
bl lXzu_lXzux_special_check
cbnz w0, lhzuxfound

/*lhzx*/
b21_30
movz w1, :abs_g1:lhzx
movk w1, :abs_g0_nc:lhzx
bl first_check
cbz w0, 0xC
check_b31
cbz w0, lhzxfound

/*lmw*/
chkOpcode
mov w1, lmw
bl first_check
cbz w0, 0x14
rD w1
rA w0
cmp w0, w1 /*rA cannot be >= to rD*/
blo lmwfound

/*lswi*/
b21_30
movz w1, :abs_g1:lswi
movk w1, :abs_g0_nc:lswi
bl first_check
cbz w0, 0x2C
check_b31
cbnz w0, 0x24
NB w2
rD w0
rA w1
cbnz w2, 0x8 /*Zero NB value is treated as 32*/
mov w2, 32
sub w0, w1, w0 /*Calc NB spill limit [(rA - rD) x 4]*/
cmp w2, w0, lsl 2 /*NB vs (NB times 4)*/
bls lswifound

/*lswx*/
b21_30
movz w1, :abs_g1:lswx
movk w1, :abs_g0_nc:lswx
bl first_check
cbz w0, 0xC
check_b31
cbz w0, lswxfound

/*lwarx*/
b21_30
movz w1, :abs_g1:lwarx
movk w1, :abs_g0_nc:lwarx
bl first_check
cbz w0, 0xC
check_b31
cbz w0, lwarxfound

/*lwbrx*/
b21_30
movz w1, :abs_g1:lwbrx
movk w1, :abs_g0_nc:lwbrx
bl first_check
cbz w0, 0xC
check_b31
cbz w0, lwbrxfound

/*lwz*/
chkOpcode
mov w1, lwz
bl first_check
cbnz w0, lwzfound

/*lwzu*/
chkOpcode
mov w1, lwzu
bl first_check
cbz w0, 0xC
bl lXzu_lXzux_special_check
cbnz w0, lwzufound

/*lwzux*/
b21_30
movz w1, :abs_g1:lwzux
movk w1, :abs_g0_nc:lwzux
bl first_check
cbz w0, 0x14
check_b31
cbnz w0, 0XC
bl lXzu_lXzux_special_check
cbnz w0, lwzuxfound

/*lwzx*/
b21_30
movz w1, :abs_g1:lwzx
movk w1, :abs_g0_nc:lwzx
bl first_check
cbz w0, 0xC
check_b31
cbz w0, lwzxfound

/*mcrf*/
chkOpcode
mov w1, mcrf
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_mcrf
movk w0, :abs_g0_nc:check_mcrf
bl second_check
cbnz w0, mcrffound

/*mcrfs*/
b21_30
movz w1, :abs_g1:mcrfs
movk w1, :abs_g0_nc:mcrfs
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_mcrfs
movk w0, :abs_g0_nc:check_mcrfs
bl second_check
cbnz w0, mcrfsfound

/*mcrxr*/
b21_30
movz w1, :abs_g1:mcrxr
movk w1, :abs_g0_nc:mcrxr
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_mcrxr
movk w0, :abs_g0_nc:check_mcrxr
bl second_check
cbnz w0, mcrxrfound

/*mfcr*/
b21_30
movz w1, :abs_g1:mfcr
movk w1, :abs_g0_nc:mfcr
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_cr_msr
movk w0, :abs_g0_nc:check_cr_msr
bl second_check
cbnz w0, mfcrfound

/*mffsX*/
b21_30
movz w1, :abs_g1:mffsX
movk w1, :abs_g0_nc:mffsX
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_fs_fsb
movk w0, :abs_g0_nc:check_fs_fsb
bl second_check
cbnz w0, mffsXfound

/*mfmsr*/
b21_30
movz w1, :abs_g1:mfmsr
movk w1, :abs_g0_nc:mfmsr
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_cr_msr
movk w0, :abs_g0_nc:check_cr_msr
bl second_check
cbnz w0, mfmsrfound

/*mfspr*/
b21_30
movz w1, :abs_g1:mfspr
movk w1, :abs_g0_nc:mfspr
bl first_check
cbz w0, 0xC
check_b31
cbz w0, mfsprfound

/*mfsr*/
b21_30
movz w1, :abs_g1:mfsr
movk w1, :abs_g0_nc:mfsr
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_sr
movk w0, :abs_g0_nc:check_sr
bl second_check
cbnz w0, mfsrfound

/*mfsrin*/
b21_30
movz w1, :abs_g1:mfsrin
movk w1, :abs_g0_nc:mfsrin
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_srin
movk w0, :abs_g0_nc:check_srin
bl second_check
cbnz w0, mfsrinfound

/*mftb*/
b21_30
movz w1, :abs_g1:mftb
movk w1, :abs_g0_nc:mftb
bl first_check
cbz w0, 0xC
check_b31
cbz w0, mftbfound

/*mtcrf*/
b21_30
movz w1, :abs_g1:mtcrf
movk w1, :abs_g0_nc:mtcrf
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_mtcrf
movk w0, :abs_g0_nc:check_mtcrf
bl second_check
cbnz w0, mtcrffound

/*mtfsb0X*/
b21_30
movz w1, :abs_g1:mtfsb0X
movk w1, :abs_g0_nc:mtfsb0X
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_fs_fsb
movk w0, :abs_g0_nc:check_fs_fsb
bl second_check
cbnz w0, mtfsb0Xfound

/*mtfsb1X*/
b21_30
movz w1, :abs_g1:mtfsb1X
movk w1, :abs_g0_nc:mtfsb1X
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_fs_fsb
movk w0, :abs_g0_nc:check_fs_fsb
bl second_check
cbnz w0, mtfsb1Xfound

/*mtfsfX*/
b21_30
movz w1, :abs_g1:mtfsfX
movk w1, :abs_g0_nc:mtfsfX
bl first_check
cbz w0, 0xC
check_mtfsfX
cbz w0, mtfsfXfound

/*mtfsfiX*/
b21_30
movz w1, :abs_g1:mtfsfiX
movk w1, :abs_g0_nc:mtfsfiX
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_mtfsfiX
movk w0, :abs_g0_nc:check_mtfsfiX
bl second_check
cbnz w0, mtfsfiXfound

/*mtmsr*/
b21_30
movz w1, :abs_g1:mtmsr
movk w1, :abs_g0_nc:mtmsr
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_cr_msr
movk w0, :abs_g0_nc:check_cr_msr
bl second_check
cbnz w0, mtmsrfound

/*mtspr*/
b21_30
movz w1, :abs_g1:mtspr
movk w1, :abs_g0_nc:mtspr
bl first_check
cbz w0, 0xC
check_b31
cbz w0, mtsprfound

/*mtsr*/
b21_30
movz w1, :abs_g1:mtsr
movk w1, :abs_g0_nc:mtsr
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_sr
movk w0, :abs_g0_nc:check_sr
bl second_check
cbnz w0, mtsrfound

/*mtsrin*/
b21_30
movz w1, :abs_g1:mtsrin
movk w1, :abs_g0_nc:mtsrin
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_srin
movk w0, :abs_g0_nc:check_srin
bl second_check
cbnz w0, mtsrinfound

/*mulhwX*/
b22_30
movz w1, :abs_g1:mulhwX
movk w1, :abs_g0_nc:mulhwX
bl first_check
cbz w0, 0xC
check_b21
cbz w0, mulhwXfound

/*mulhwuX*/
b22_30
movz w1, :abs_g1:mulhwuX
movk w1, :abs_g0_nc:mulhwuX
bl first_check
cbz w0, 0xC
check_b21
cbz w0, mulhwuXfound

/*mulli*/
chkOpcode
mov w1, mulli
bl first_check
cbnz w0, mullifound

/*mullwX*/
b22_30
movz w1, :abs_g1:mullwX
movk w1, :abs_g0_nc:mullwX
bl first_check
cbnz w0, mullwXfound

/*nandX*/
b21_30
movz w1, :abs_g1:nandX
movk w1, :abs_g0_nc:nandX
bl first_check
cbnz w0, nandXfound

/*negX*/
b22_30
movz w1, :abs_g1:negX
movk w1, :abs_g0_nc:negX
bl first_check
cbz w0, 0xC
check_nullrB
cbz w0, negXfound

/*norX*/
b21_30
movz w1, :abs_g1:norX
movk w1, :abs_g0_nc:norX
bl first_check
cbnz w0, norXfound

/*orX*/
b21_30
movz w1, :abs_g1:orX
movk w1, :abs_g0_nc:orX
bl first_check
cbnz w0, orXfound

/*orcX*/
b21_30
movz w1, :abs_g1:orcX
movk w1, :abs_g0_nc:orcX
bl first_check
cbnz w0, orcXfound

/*ori*/
chkOpcode
mov w1, ori
bl first_check
cbnz w0, orifound

/*oris*/
chkOpcode
mov w1, oris
bl first_check
cbnz w0, orisfound

/*psq_l*/
chkOpcode
mov w1, psq_l
bl first_check
cbnz w0, psq_lfound

/*psq_lu*/
chkOpcode
mov w1, psq_lu
bl first_check
cbz w0, 0xC
float_ps_update_and_store_update_special_check
cbnz w0, psq_lufound

/*psq_lux*/
b25_30
movz w1, :abs_g1:psq_lux
movk w1, :abs_g0_nc:psq_lux
bl first_check
cbz w0, 0x14
check_b31
cbnz w0, 0XC
float_ps_update_and_store_update_special_check
cbnz w0, psq_luxfound

/*psq_lx*/
b25_30
movz w1, :abs_g1:psq_lx
movk w1, :abs_g0_nc:psq_lx
bl first_check
cbz w0, 0xC
check_b31
cbz w0, psq_lxfound

/*psq_st*/
chkOpcode
mov w1, psq_st
bl first_check
cbnz w0, psq_stfound

/*psq_stu*/
chkOpcode
mov w1, psq_stu
bl first_check
cbz w0, 0xC
float_ps_update_and_store_update_special_check
cbnz w0, psq_stufound

/*psq_stux*/
b25_30
movz w1, :abs_g1:psq_stux
movk w1, :abs_g0_nc:psq_stux
bl first_check
cbz w0, 0x14
check_b31
cbnz w0, 0XC
float_ps_update_and_store_update_special_check
cbnz w0, psq_stuxfound

/*psq_stx*/
b25_30
movz w1, :abs_g1:psq_stx
movk w1, :abs_g0_nc:psq_stx
bl first_check
cbz w0, 0xC
check_b31
cbz w0, psq_stxfound

/*ps_absX*/
b21_30
movz w1, :abs_g1:ps_absX
movk w1, :abs_g0_nc:ps_absX
bl first_check
cbz w0, 0xC
check_nullrA
cbz w0, ps_absXfound

/*ps_addX*/
b26_30
movz w1, :abs_g1:ps_addX
movk w1, :abs_g0_nc:ps_addX
bl first_check
cbz w0, 0xC
check_nullfC
cbz w0, ps_addXfound

/*ps_cmpo0*/
b21_30
movz w1, :abs_g1:ps_cmpo0
movk w1, :abs_g0_nc:ps_cmpo0
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_cmps2
movk w0, :abs_g0_nc:check_cmps2
bl second_check
cbnz w0, ps_cmpo0found

/*ps_cmpo1*/
b21_30
movz w1, :abs_g1:ps_cmpo1
movk w1, :abs_g0_nc:ps_cmpo1
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_cmps2
movk w0, :abs_g0_nc:check_cmps2
bl second_check
cbnz w0, ps_cmpo1found

/*ps_cmpu0*/
b21_30
movz w1, :abs_g1:ps_cmpu0
movk w1, :abs_g0_nc:ps_cmpu0
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_cmps1
movk w0, :abs_g0_nc:check_cmps1
bl second_check
cbnz w0, ps_cmpu0found

/*ps_cmpu1*/
b21_30
movz w1, :abs_g1:ps_cmpu1
movk w1, :abs_g0_nc:ps_cmpu1
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_cmps1
movk w0, :abs_g0_nc:check_cmps1
bl second_check
cbnz w0, ps_cmpu1found

/*ps_divX*/
b26_30
movz w1, :abs_g1:ps_divX
movk w1, :abs_g0_nc:ps_divX
bl first_check
cbz w0, 0xC
check_nullfC
cbz w0, ps_divXfound

/*ps_maddX*/
b26_30
movz w1, :abs_g1:ps_maddX
movk w1, :abs_g0_nc:ps_maddX
bl first_check
cbnz w0, ps_maddXfound

/*ps_madds0X*/
b26_30
movz w1, :abs_g1:ps_madds0X
movk w1, :abs_g0_nc:ps_madds0X
bl first_check
cbnz w0, ps_madds0Xfound

/*ps_madds1X*/
b26_30
movz w1, :abs_g1:ps_madds1X
movk w1, :abs_g0_nc:ps_madds1X
bl first_check
cbnz w0, ps_madds1Xfound

/*ps_merge00X*/
b21_30
movz w1, :abs_g1:ps_merge00X
movk w1, :abs_g0_nc:ps_merge00X
bl first_check
cbnz w0, ps_merge00Xfound

/*ps_merge01X*/
b21_30
movz w1, :abs_g1:ps_merge01X
movk w1, :abs_g0_nc:ps_merge01X
bl first_check
cbnz w0, ps_merge01Xfound

/*ps_merge10X*/
b21_30
movz w1, :abs_g1:ps_merge10X
movk w1, :abs_g0_nc:ps_merge10X
bl first_check
cbnz w0, ps_merge10Xfound

/*ps_merge11X*/
b21_30
movz w1, :abs_g1:ps_merge11X
movk w1, :abs_g0_nc:ps_merge11X
bl first_check
cbnz w0, ps_merge11Xfound

/*ps_mrX*/
b21_30
movz w1, :abs_g1:ps_mrX
movk w1, :abs_g0_nc:ps_mrX
bl first_check
cbz w0, 0xC
check_nullrA
cbz w0, ps_mrXfound

/*ps_msubX*/
b26_30
movz w1, :abs_g1:ps_msubX
movk w1, :abs_g0_nc:ps_msubX
bl first_check
cbnz w0, ps_msubXfound

/*ps_mulX*/
b26_30
movz w1, :abs_g1:ps_mulX
movk w1, :abs_g0_nc:ps_mulX
bl first_check
cbz w0, 0xC
check_nullrB
cbz w0, ps_mulXfound

/*ps_muls0X*/
b26_30
movz w1, :abs_g1:ps_muls0X
movk w1, :abs_g0_nc:ps_muls0X
bl first_check
cbz w0, 0xC
check_nullrB
cbz w0, ps_muls0Xfound

/*ps_muls1X*/
b26_30
movz w1, :abs_g1:ps_muls1X
movk w1, :abs_g0_nc:ps_muls1X
bl first_check
cbz w0, 0xC
check_nullrB
cbz w0, ps_muls1Xfound

/*ps_nabsX*/
b21_30
movz w1, :abs_g1:ps_nabsX
movk w1, :abs_g0_nc:ps_nabsX
bl first_check
cbz w0, 0xC
check_nullrA
cbz w0, ps_nabsXfound

/*ps_negX*/
b21_30
movz w1, :abs_g1:ps_negX
movk w1, :abs_g0_nc:ps_negX
bl first_check
cbz w0, 0xC
check_nullrA
cbz w0, ps_negXfound

/*ps_nmaddX*/
b26_30
movz w1, :abs_g1:ps_nmaddX
movk w1, :abs_g0_nc:ps_nmaddX
bl first_check
cbnz w0, ps_nmaddXfound

/*ps_nmsubX*/
b26_30
movz w1, :abs_g1:ps_nmsubX
movk w1, :abs_g0_nc:ps_nmsubX
bl first_check
cbnz w0, ps_nmsubXfound

/*ps_resX*/
b26_30
movz w1, :abs_g1:ps_resX
movk w1, :abs_g0_nc:ps_resX
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_res_sqrt
movk w0, :abs_g0_nc:check_res_sqrt
bl second_check
cbnz w0, ps_resXfound

/*ps_rsqrteX*/
b26_30
movz w1, :abs_g1:ps_rsqrteX
movk w1, :abs_g0_nc:ps_rsqrteX
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_res_sqrt
movk w0, :abs_g0_nc:check_res_sqrt
bl second_check
cbnz w0, ps_rsqrteXfound

/*ps_selX*/
b26_30
movz w1, :abs_g1:ps_selX
movk w1, :abs_g0_nc:ps_selX
bl first_check
cbnz w0, ps_selXfound

/*ps_subX*/
b26_30
movz w1, :abs_g1:ps_subX
movk w1, :abs_g0_nc:ps_subX
bl first_check
cbz w0, 0xC
check_nullfC
cbz w0, ps_subXfound

/*ps_sum0X*/
b26_30
movz w1, :abs_g1:ps_sum0X
movk w1, :abs_g0_nc:ps_sum0X
bl first_check
cbnz w0, ps_sum0Xfound

/*ps_sum1X*/
b26_30
movz w1, :abs_g1:ps_sum1X
movk w1, :abs_g0_nc:ps_sum1X
bl first_check
cbnz w0, ps_sum1Xfound

/*rfi*/
b21_30
movz w1, :abs_g1:rfi
movk w1, :abs_g0_nc:rfi
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_syncs
movk w0, :abs_g0_nc:check_syncs
bl second_check
cbnz w0, rfifound

/*rlwimiX*/
chkOpcode
mov w1, rlwimiX
bl first_check
cbnz w0, rlwimiXfound

/*rlwinmX*/
chkOpcode
mov w1, rlwinmX
bl first_check
cbnz w0, rlwinmXfound

/*rlwnmX*/
chkOpcode
mov w1, rlwnmX
bl first_check
cbnz w0, rlwnmXfound

/*sc*/
movz w0, 0xFC00, lsl 16
movk w0, 0x0002
movz w1, :abs_g1:sc
movk w1, :abs_g0_nc:sc
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_sc
movk w0, :abs_g0_nc:check_sc
bl second_check
cbnz w0, scfound

/*slwX*/
b21_30
movz w1, :abs_g1:slwX
movk w1, :abs_g0_nc:slwX
bl first_check
cbnz w0, slwXfound

/*srawX*/
b21_30
movz w1, :abs_g1:srawX
movk w1, :abs_g0_nc:srawX
bl first_check
cbnz w0, srawXfound

/*srawiX*/
b21_30
movz w1, :abs_g1:srawiX
movk w1, :abs_g0_nc:srawiX
bl first_check
cbnz w0, srawiXfound

/*srw*/
b21_30
movz w1, :abs_g1:srwX
movk w1, :abs_g0_nc:srwX
bl first_check
cbnz w0, srwXfound

/*stb*/
chkOpcode
mov w1, stb
bl first_check
cbnz w0, stbfound

/*stbu*/
chkOpcode
mov w1, stbu
bl first_check
cbz w0, 0xC
float_ps_update_and_store_update_special_check
cbnz w0, stbufound

/*stbux*/
b21_30
movz w1, :abs_g1:stbux
movk w1, :abs_g0_nc:stbux
bl first_check
cbz w0, 0x14
check_b31
cbnz w0, 0XC
float_ps_update_and_store_update_special_check
cbnz w0, stbuxfound

/*stbx*/
b21_30
movz w1, :abs_g1:stbx
movk w1, :abs_g0_nc:stbx
bl first_check
cbz w0, 0xC
check_b31
cbz w0, stbxfound

/*stfd*/
chkOpcode
mov w1, stfd
bl first_check
cbnz w0, stfdfound

/*stfdu*/
chkOpcode
mov w1, stfdu
bl first_check
cbz w0, 0xC
float_ps_update_and_store_update_special_check
cbnz w0, stfdufound

/*stfdux*/
b21_30
movz w1, :abs_g1:stfdux
movk w1, :abs_g0_nc:stfdux
bl first_check
cbz w0, 0x14
check_b31
cbnz w0, 0XC
float_ps_update_and_store_update_special_check
cbnz w0, stfduxfound

/*stfdx*/
b21_30
movz w1, :abs_g1:stfdx
movk w1, :abs_g0_nc:stfdx
bl first_check
cbz w0, 0xC
check_b31
cbz w0, stfdxfound

/*stfiwx*/
b21_30
movz w1, :abs_g1:stfiwx
movk w1, :abs_g0_nc:stfiwx
bl first_check
cbz w0, 0xC
check_b31
cbz w0, stfiwxfound

/*stfs*/
chkOpcode
mov w1, stfs
bl first_check
cbnz w0, stfsfound

/*stfsu*/
chkOpcode
mov w1, stfsu
bl first_check
cbz w0, 0xC
float_ps_update_and_store_update_special_check
cbnz w0, stfsufound

/*stfsux*/
b21_30
movz w1, :abs_g1:stfsux
movk w1, :abs_g0_nc:stfsux
bl first_check
cbz w0, 0x14
check_b31
cbnz w0, 0XC
float_ps_update_and_store_update_special_check
cbnz w0, stfsuxfound

/*stfsx*/
b21_30
movz w1, :abs_g1:stfsx
movk w1, :abs_g0_nc:stfsx
bl first_check
cbz w0, 0xC
check_b31
cbz w0, stfsxfound

/*sth*/
chkOpcode
mov w1, sth
bl first_check
cbnz w0, sthfound

/*sthbrx*/
b21_30
movz w1, :abs_g1:sthbrx
movk w1, :abs_g0_nc:sthbrx
bl first_check
cbz w0, 0xC
check_b31
cbz w0, sthbrxfound

/*sthu*/
chkOpcode
mov w1, sthu
bl first_check
cbz w0, 0xC
float_ps_update_and_store_update_special_check
cbnz w0, sthufound

/*sthux*/
b21_30
movz w1, :abs_g1:sthux
movk w1, :abs_g0_nc:sthux
bl first_check
cbz w0, 0x14
check_b31
cbnz w0, 0XC
float_ps_update_and_store_update_special_check
cbnz w0, sthuxfound

/*sthx*/
b21_30
movz w1, :abs_g1:sthx
movk w1, :abs_g0_nc:sthx
bl first_check
cbz w0, 0xC
check_b31
cbz w0, sthxfound

/*stmw*/
chkOpcode
mov w1, stmw
bl first_check
cbnz w0, stmwfound

/*stswi*/
b21_30
movz w1, :abs_g1:stswi
movk w1, :abs_g0_nc:stswi
bl first_check
cbz w0, 0xC
check_b31
cbz w0, stswifound

/*stswx*/
b21_30
movz w1, :abs_g1:stswx
movk w1, :abs_g0_nc:stswx
bl first_check
cbz w0, 0xC
check_b31
cbz w0, stswxfound

/*stw*/
chkOpcode
mov w1, stw
bl first_check
cbnz w0, stwfound

/*stwbrx*/
b21_30
movz w1, :abs_g1:stwbrx
movk w1, :abs_g0_nc:stwbrx
bl first_check
cbz w0, 0xC
check_b31
cbz w0, stwbrxfound

/*stwcxRC*/
b21_30
movz w1, :abs_g1:stwcxRC
movk w1, :abs_g0_nc:stwcxRC
bl first_check
cbnz w0, stwcxRCfound

/*stwu*/
chkOpcode
mov w1, stwu
bl first_check
cbz w0, 0xC
float_ps_update_and_store_update_special_check
cbnz w0, stwufound

/*stwux*/
b21_30
movz w1, :abs_g1:stwux
movk w1, :abs_g0_nc:stwux
bl first_check
cbz w0, 0x14
check_b31
cbnz w0, 0XC
float_ps_update_and_store_update_special_check
cbnz w0, stwuxfound

/*stwx*/
b21_30
movz w1, :abs_g1:stwx
movk w1, :abs_g0_nc:stwx
bl first_check
cbz w0, 0xC
check_b31
cbz w0, stwxfound

/*subX*/
b22_30
movz w1, :abs_g1:subX
movk w1, :abs_g0_nc:subX
bl first_check
cbnz w0, subXfound

/*subcX*/
b22_30
movz w1, :abs_g1:subcX
movk w1, :abs_g0_nc:subcX
bl first_check
cbnz w0, subcXfound

/*subfeX*/
b22_30
movz w1, :abs_g1:subfeX
movk w1, :abs_g0_nc:subfeX
bl first_check
cbnz w0, subfeXfound

/*subfic*/
chkOpcode
mov w1, subfic
bl first_check
cbnz w0, subficfound

/*subfmeX*/
b22_30
movz w1, :abs_g1:subfmeX
movk w1, :abs_g0_nc:subfmeX
bl first_check
cbz w0, 0xC
check_nullrB
cbz w0, subfmeXfound

/*subfzeX*/
b22_30
movz w1, :abs_g1:subfzeX
movk w1, :abs_g0_nc:subfzeX
bl first_check
cbz w0, 0xC
check_nullrB
cbz w0, subfzeXfound

/*sync*/
b21_30
movz w1, :abs_g1:sync
movk w1, :abs_g0_nc:sync
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_syncs
movk w0, :abs_g0_nc:check_syncs
bl second_check
cbnz w0, syncfound

/*tlbie*/
b21_30
movz w1, :abs_g1:tlbie
movk w1, :abs_g0_nc:tlbie
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_tlbie
movk w0, :abs_g0_nc:check_tlbie
bl second_check
cbnz w0, tlbiefound

/*tlbsync*/
b21_30
movz w1, :abs_g1:tlbsync
movk w1, :abs_g0_nc:tlbsync
bl first_check
cbz w0, 0x14
movz w0, :abs_g1:check_syncs
movk w0, :abs_g0_nc:check_syncs
bl second_check
cbnz w0, tlbsyncfound

/*tw*/
b21_30
movz w1, :abs_g1:tw
movk w1, :abs_g0_nc:tw
bl first_check
cbz w0, 0xC
check_b31
cbz w0, twfound

/*twi*/
chkOpcode
mov w1, twi
bl first_check
cbnz w0, twifound

/*xorX*/
b21_30
movz w1, :abs_g1:xorX
movk w1, :abs_g0_nc:xorX
bl first_check
cbnz w0, xorXfound

/*xori*/
chkOpcode
mov w1, xori
bl first_check
cbnz w0, xorifound

/*xoris*/
chkOpcode
mov w1, xoris
bl first_check
cbnz w0, xorisfound

/*Found ill instruction*/
invalidfound:
adrp x1, invalid_instruction
add x1, x1, :lo12: invalid_instruction
mov w2, w19
b do_sprintf

addXfound:
rD w2
rA w3
rB w4
mov w27, add_ident
adrp x1, ins_add
add x1, x1, :lo12: ins_add
b do_sprintf

addcXfound:
rD w2
rA w3
rB w4
mov w27, addc_ident
adrp x1, ins_add
add x1, x1, :lo12: ins_addc
b do_sprintf

addeXfound:
rD w2
rA w3
rB w4
mov w27, adde_ident
adrp x1, ins_add
add x1, x1, :lo12: ins_adde
b do_sprintf

addifound:
rD w2
rA w3
SIMM w4
cmp w3, 0
mov w27, addi_ident
bne not_li
mov w3, w4
adrp x1, ins_li
add x1, x1, :lo12: ins_li
b do_sprintf
not_li:
adrp x1, ins_addi
add x1, x1, :lo12: ins_addi
b do_sprintf

addicfound:
rD w2
rA w3
SIMM w4
cmp w4, 0
mov w27, addic_ident
blt 0x10
adrp x1, ins_addic
add x1, x1, :lo12: ins_addic
b do_sprintf
neg w4, w4
adrp x1, ins_subic
add x1, x1, :lo12: ins_subic
b do_sprintf

addicRCfound:
rD w2
rA w3
SIMM w4
cmp w4, 0
mov w27, addicRC_ident
blt 0x10
adrp x1, ins_addic_
add x1, x1, :lo12: ins_addic_
b do_sprintf
neg w4, w4
adrp x1, ins_subic_
add x1, x1, :lo12: ins_subic_
b do_sprintf

addisfound:
rD w2
rA w3
UIMM w4
cmp w3, 0
mov w27, addis_ident
bne not_lis
mov w3, w4
adrp x1, ins_lis
add x1, x1, :lo12: ins_lis
b do_sprintf
not_lis:
adrp x1, ins_addis
add x1, x1, :lo12: ins_addis
b do_sprintf

addmeXfound:
rD w2
rA w3
adrp x1, ins_addme
add x1, x1, :lo12: ins_addme
mov w27, addme_ident
b do_sprintf

addzeXfound:
rD w2
rA w3
adrp x1, ins_addze
add x1, x1, :lo12: ins_addze
mov w27, addze_ident
b do_sprintf

andXfound:
rA w2
rS w3
rB w4
adrp x1, ins_and
add x1, x1, :lo12: ins_and
mov w27, and_ident
b do_sprintf

andcXfound:
rA w2
rS w3
rB w4
adrp x1, ins_andc
add x1, x1, :lo12: ins_andc
mov w27, andc_ident
b do_sprintf

andiRCfound:
rA w2
rS w3
UIMM w4
adrp x1, ins_andi_
add x1, x1, :lo12: ins_andi_
mov w27, andiRC_ident
b do_sprintf

andisRCfound:
rA w2
rS w3
UIMM w4
adrp x1, ins_andis_
add x1, x1, :lo12: ins_andis_
mov w27, andisRC_ident
b do_sprintf

bXfound:
LI_SIMM w2
adrp x1, ins_b
add x1, x1, :lo12: ins_b
mov w27, b_ident
b do_sprintf

bcXfound:
//TODO!
adrp x1, ins_bc
add x1, x1, :lo12: ins_bc
mov w27, bc_ident
b do_sprintf

bcctrXfound:
//TODO!
adrp x1, ins_bcctr
add x1, x1, :lo12: ins_bcctr
mov w27, bcctr_ident
b do_sprintf

bclrXfound:
//TODO!
adrp x1, ins_bclr
add x1, x1, :lo12: ins_bclr
mov w27, bclr_ident
b do_sprintf

cmpwfound:
//TODO!
adrp x1, ins_cmpw
add x1, x1, :lo12: ins_cmpw
mov w27, cmp_ident
b do_sprintf

cmpwifound:
//TODO!
adrp x1, ins_cmpwi
add x1, x1, :lo12: ins_cmpwi
mov w27, cmpi_ident
b do_sprintf

cmplwfound:
//TODO!
adrp x1, ins_cmplw
add x1, x1, :lo12: ins_cmplw
mov w27, cmpl_ident
b do_sprintf

cmplwifound:
//TODO!
adrp x1, ins_cmplwi
add x1, x1, :lo12: ins_cmplwi
mov w27, cmpli_ident
b do_sprintf

cntlzwXfound:
rA w2
rS w3
adrp x1, ins_cntlzw
add x1, x1, :lo12: ins_cntlzw
mov w27, cntlzw_ident
b do_sprintf

crandfound:
crbD w2
crbA w3
crbB w4
adrp x1, ins_crand
add x1, x1, :lo12: ins_crand
mov w27, crand_ident
b do_sprintf

crandcfound:
crbD w2
crbA w3
crbB w4
adrp x1, ins_crandc
add x1, x1, :lo12: ins_crandc
mov w27, crandc_ident
b do_sprintf

creqvfound:
crbD w2
crbA w3
crbB w4
cmp w2, w3
mov w27, creqv_ident
bne not_crset
cmp w2, w4
bne not_crset
adrp x1, ins_crset
add x1, x1, :lo12: ins_crset
b do_sprintf
not_crset:
adrp x1, ins_creqv
add x1, x1, :lo12: ins_creqv
b do_sprintf

crnandfound:
crbD w2
crbA w3
crbB w4
adrp x1, ins_crnand
add x1, x1, :lo12: ins_crnand
mov w27, crnand_ident
b do_sprintf

crnorfound:
crbD w2
crbA w3
crbB w4
cmp w3, w4
mov w27, crnor_ident
bne not_crnot
adrp x1, ins_crnot
add x1, x1, :lo12: ins_crnot
b do_sprintf
not_crnot:
adrp x1, ins_crnor
add x1, x1, :lo12: ins_crnor
b do_sprintf

crorfound:
crbD w2
crbA w3
crbB w4
cmp w3, w4
mov w27, cror_ident
bne not_crmove
adrp x1, ins_crmove
add x1, x1, :lo12: ins_crmove
b do_sprintf
not_crmove:
adrp x1, ins_crmove
add x1, x1, :lo12: ins_crmove
b do_sprintf

crorcfound:
crbD w2
crbA w3
crbB w4
adrp x1, ins_crorc
add x1, x1, :lo12: ins_crorc
mov w27, crorc_ident
b do_sprintf

crxorfound:
crbD w2
crbA w3
crbB w4
cmp w2, w3
mov w27, crxor_ident
bne not_crclr
cmp w2, w4
bne not_crclr
adrp x1, ins_crclr
add x1, x1, :lo12: ins_crclr
b do_sprintf
not_crclr:
adrp x1, ins_crxor
add x1, x1, :lo12: ins_crxor
b do_sprintf

dcbffound:
rA w2
rB w3
adrp x1, ins_dcbf
add x1, x1, :lo12: ins_dcbf
mov w27, dcbf_ident
b do_sprintf

dcbifound:
rA w2
rB w3
adrp x1, ins_dcbi
add x1, x1, :lo12: ins_dcbi
mov w27, dcbi_ident
b do_sprintf

dcbstfound:
rA w2
rB w3
adrp x1, ins_dcbst
add x1, x1, :lo12: ins_dcbst
mov w27, dcbst_ident
b do_sprintf

dcbtfound:
rA w2
rB w3
adrp x1, ins_dcbt
add x1, x1, :lo12: ins_dcbt
mov w27, dcbt_ident
b do_sprintf

dcbtstfound:
rA w2
rB w3
adrp x1, ins_dcbtst
add x1, x1, :lo12: ins_dcbtst
mov w27, dcbtst_ident
b do_sprintf

dcbzfound:
rA w2
rB w3
adrp x1, ins_dcbz
add x1, x1, :lo12: ins_dcbz
mov w27, dcbz_ident
b do_sprintf

dcbz_lfound:
rA w2
rB w3
adrp x1, ins_dcbz_l
add x1, x1, :lo12: ins_dcbz_l
mov w27, dcbz_l_ident
b do_sprintf

divwXfound:
rD w2
rA w3
rB w4
adrp x1, ins_divw
add x1, x1, :lo12: ins_divw
mov w27, divw_ident
b do_sprintf

divwuXfound:
rD w2
rA w3
rB w4
adrp x1, ins_divwu
add x1, x1, :lo12: ins_divwu
mov w27, divwu_ident
b do_sprintf

eciwxfound:
rD w2
rA w3
rB w4
adrp x1, ins_eciwx
add x1, x1, :lo12: ins_eciwx
mov w27, eciwx_ident
b do_sprintf

ecowxfound:
rS w2
rA w3
rB w4
adrp x1, ins_ecowx
add x1, x1, :lo12: ins_ecowx
mov w27, ecowx_ident
b do_sprintf

eieiofound:
adrp x1, ins_eieio
add x1, x1, :lo12: ins_eieio
mov w27, eieio_ident
b do_sprintf

eqvXfound:
rA w2
rS w3
rB w4
adrp x1, ins_eqv
add x1, x1, :lo12: ins_eqv
mov w27, eqv_ident
b do_sprintf

extsbXfound:
rA w2
rS w3
adrp x1, ins_extsb
add x1, x1, :lo12: ins_extsb
mov w27, extsb_ident
b do_sprintf

extshXfound:
rA w2
rS w3
adrp x1, ins_extsh
add x1, x1, :lo12: ins_extsh
mov w27, extsh_ident
b do_sprintf

fabsXfound:
fD w2
fB w3
adrp x1, ins_fabs
add x1, x1, :lo12: ins_fabs
mov w27, fabs_ident
b do_sprintf

faddXfound:
fD w2
fA w3
fB w4
adrp x1, ins_fadd
add x1, x1, :lo12: ins_fadd
mov w27, fadd_ident
b do_sprintf

faddsXfound:
fD w2
fA w3
fB w4
adrp x1, ins_fadds
add x1, x1, :lo12: ins_fadds
mov w27, fadds_ident
b do_sprintf

fcmpofound:
crfD w2
fA w3
fB w4
adrp x1, ins_fcmpo
add x1, x1, :lo12: ins_fcmpo
mov w27, fcmpo_ident
b do_sprintf

fcmpufound:
crfD w2
fA w3
fB w4
adrp x1, ins_fcmpu
add x1, x1, :lo12: ins_fcmpu
mov w27, fcmpu_ident
b do_sprintf

fctiwXfound:
fD w2
fB w3
adrp x1, ins_fctiw
add x1, x1, :lo12: ins_fctiw
mov w27, fctiw_ident
b do_sprintf

fctiwzXfound:
fD w2
fB w3
adrp x1, ins_fctiwz
add x1, x1, :lo12: ins_fctiwz
mov w27, fctiwz_ident
b do_sprintf

fdivXfound:
fD w2
fA w3
fB w4
adrp x1, ins_fdiv
add x1, x1, :lo12: ins_fdiv
mov w27, fdiv_ident
b do_sprintf

fdivsXfound:
fD w2
fA w3
fB w4
adrp x1, ins_fdivs
add x1, x1, :lo12: ins_fdivs
mov w27, fdivs_ident
b do_sprintf

fmaddXfound:
fD w2
fA w3
fC w4
fB w5
adrp x1, ins_fmadd
add x1, x1, :lo12: ins_fmadd
mov w27, fmadd_ident
b do_sprintf

fmaddsXfound:
fD w2
fA w3
fC w4
fB w5
adrp x1, ins_fmadds
add x1, x1, :lo12: ins_fmadds
mov w27, fmadds_ident
b do_sprintf

fmrXfound:
fD w2
fB w3
adrp x1, ins_fmr
add x1, x1, :lo12: ins_fmr
mov w27, fmr_ident
b do_sprintf

fmsubXfound:
fD w2
fA w3
fC w4
fB w5
adrp x1, ins_fmsub
add x1, x1, :lo12: ins_fmsub
mov w27, fmsub_ident
b do_sprintf

fmsubsXfound:
fD w2
fA w3
fC w4
fB w5
adrp x1, ins_fmsubs
add x1, x1, :lo12: ins_fmsubs
mov w27, fmsubs_ident
b do_sprintf

fmulXfound:
fD w2
fA w3
fC w4
adrp x1, ins_fmul
add x1, x1, :lo12: ins_fmul
mov w27, fmul_ident
b do_sprintf

fmulsXfound:
fD w2
fA w3
fC w4
adrp x1, ins_fmuls
add x1, x1, :lo12: ins_fmuls
mov w27, fmuls_ident
b do_sprintf

fnabsXfound:
fD w2
fB w3
adrp x1, ins_fnabs
add x1, x1, :lo12: ins_fnabs
mov w27, fnabs_ident
b do_sprintf

fnegXfound:
fD w2
fB w3
adrp x1, ins_fneg
add x1, x1, :lo12: ins_fneg
mov w27, fneg_ident
b do_sprintf

fnmaddXfound:
fD w2
fA w3
fC w4
fB w5
adrp x1, ins_fnmadd
add x1, x1, :lo12: ins_fnmadd
mov w27, fnmadd_ident
b do_sprintf

fnmaddsXfound:
fD w2
fA w3
fC w4
fB w5
adrp x1, ins_fnmadds
add x1, x1, :lo12: ins_fnmadds
mov w27, fnmadds_ident
b do_sprintf

fnmsubXfound:
fD w2
fA w3
fC w4
fB w5
adrp x1, ins_fnmsub
add x1, x1, :lo12: ins_fnmsub
mov w27, fnmsub_ident
b do_sprintf

fnmsubsXfound:
fD w2
fA w3
fC w4
fB w5
adrp x1, ins_fnmsubs
add x1, x1, :lo12: ins_fnmsubs
mov w27, fnmsubs_ident
b do_sprintf

fresXfound:
fD w2
fB w3
adrp x1, ins_fres
add x1, x1, :lo12: ins_fres
mov w27, fres_ident
b do_sprintf

frspXfound:
fD w2
fB w3
adrp x1, ins_frsp
add x1, x1, :lo12: ins_frsp
mov w27, frsp_ident
b do_sprintf

frsqrteXfound:
fD w2
fB w3
adrp x1, ins_frsqrte
add x1, x1, :lo12: ins_frsqrte
mov w27, frsqrte_ident
b do_sprintf

fselXfound:
fD w2
fA w3
fC w4
fB w5
adrp x1, ins_fsel
add x1, x1, :lo12: ins_fsel
mov w27, fsel_ident
b do_sprintf

fsubXfound:
fD w2
fA w3
fB w4
adrp x1, ins_fsub
add x1, x1, :lo12: ins_fsub
mov w27, fsub_ident
b do_sprintf

fsubsXfound:
fD w2
fA w3
fB w4
adrp x1, ins_fsubs
add x1, x1, :lo12: ins_fsubs
mov w27, fsubs_ident
b do_sprintf

icbifound:
rA w2
rB w3
adrp x1, ins_icbi
add x1, x1, :lo12: ins_icbi
mov w27, icbi_ident
b do_sprintf

isyncfound:
adrp x1, ins_isync
add x1, x1, :lo12: ins_isync
mov w27, isync_ident
b do_sprintf

lbzfound:
rD w2
d w3
rA w4
adrp x1, ins_lbz
add x1, x1, :lo12: ins_lbz
mov w27, lbz_ident
b do_sprintf

lbzufound:
rD w2
d w3
rA w4
adrp x1, ins_lbzu
add x1, x1, :lo12: ins_lbzu
mov w27, lbzu_ident
b do_sprintf

lbzuxfound:
rD w2
rA w3
rB w4
adrp x1, ins_lbzux
add x1, x1, :lo12: ins_lbzux
mov w27, lbzux_ident
b do_sprintf

lbzxfound:
rD w2
rA w3
rB w4
adrp x1, ins_lbzx
add x1, x1, :lo12: ins_lbzx
mov w27, lbzx_ident
b do_sprintf

lfdfound:
fD w2
d w3
rA w4
adrp x1, ins_lfd
add x1, x1, :lo12: ins_lfd
mov w27, lfd_ident
b do_sprintf

lfdufound:
fD w2
d w3
rA w4
adrp x1, ins_lfdu
add x1, x1, :lo12: ins_lfdu
mov w27, lfdu_ident
b do_sprintf

lfduxfound:
fD w2
rA w3
rB w4
adrp x1, ins_lfdux
add x1, x1, :lo12: ins_lfdux
mov w27, lfdux_ident
b do_sprintf

lfdxfound:
fD w2
rA w3
rB w4
adrp x1, ins_lfdx
add x1, x1, :lo12: ins_lfdx
mov w27, lfdx_ident
b do_sprintf

lfsfound:
fD w2
d w3
rA w4
adrp x1, ins_lfs
add x1, x1, :lo12: ins_lfs
mov w27, lfs_ident
b do_sprintf

lfsufound:
fD w2
d w3
rA w4
adrp x1, ins_lfsu
add x1, x1, :lo12: ins_lfsu
mov w27, lfsu_ident
b do_sprintf

lfsuxfound:
fD w2
rA w3
rB w4
adrp x1, ins_lfsux
add x1, x1, :lo12: ins_lfsux
mov w27, lfsux_ident
b do_sprintf

lfsxfound:
fD w2
rA w3
rB w4
adrp x1, ins_lfsx
add x1, x1, :lo12: ins_lfsx
mov w27, lfsx_ident
b do_sprintf

lhafound:
rD w2
d w3
rA w4
adrp x1, ins_lha
add x1, x1, :lo12: ins_lha
mov w27, lha_ident
b do_sprintf

lhaufound:
rD w2
d w3
rA w4
adrp x1, ins_lhau
add x1, x1, :lo12: ins_lhau
mov w27, lhau_ident
b do_sprintf

lhauxfound:
rD w2
rA w3
rB w4
adrp x1, ins_lhaux
add x1, x1, :lo12: ins_lhaux
mov w27, lhaux_ident
b do_sprintf

lhaxfound:
rD w2
rA w3
rB w4
adrp x1, ins_lhax
add x1, x1, :lo12: ins_lhax
mov w27, lhax_ident
b do_sprintf

lhbrxfound:
rD w2
rA w3
rB w4
adrp x1, ins_lhbrx
add x1, x1, :lo12: ins_lhbrx
mov w27, lhbrx_ident
b do_sprintf

lhzfound:
rD w2
d w3
rA w4
adrp x1, ins_lhz
add x1, x1, :lo12: ins_lhz
mov w27, lhz_ident
b do_sprintf

lhzufound:
rD w2
d w3
rA w4
adrp x1, ins_lhzu
add x1, x1, :lo12: ins_lhzu
mov w27, lhzu_ident
b do_sprintf

lhzuxfound:
rD w2
rA w3
rB w4
adrp x1, ins_lhzux
add x1, x1, :lo12: ins_lhzux
mov w27, lhzux_ident
b do_sprintf

lhzxfound:
rD w2
rA w3
rB w4
adrp x1, ins_lhzx
add x1, x1, :lo12: ins_lhzx
mov w27, lhzx_ident
b do_sprintf

lmwfound:
rD w2
d w3
rA w4
adrp x1, ins_lmw
add x1, x1, :lo12: ins_lmw
mov w27, lmw_ident
b do_sprintf

lswifound:
rD w2
rA w3
NB w4
adrp x1, ins_lswi
add x1, x1, :lo12: ins_lswi
mov w27, lswi_ident
b do_sprintf

lswxfound:
rD w2
rA w3
rB w4
adrp x1, ins_lswx
add x1, x1, :lo12: ins_lswx
mov w27, lswx_ident
b do_sprintf

lwarxfound:
rD w2
rA w3
rB w4
adrp x1, ins_lwarx
add x1, x1, :lo12: ins_lwarx
mov w27, lwarx_ident
b do_sprintf

lwbrxfound:
rD w2
rA w3
rB w4
adrp x1, ins_lwbrx
add x1, x1, :lo12: ins_lwbrx
mov w27, lwbrx_ident
b do_sprintf

lwzfound:
rD w2
d w3
rA w4
adrp x1, ins_lwz
add x1, x1, :lo12: ins_lwz
mov w27, lwz_ident
b do_sprintf

lwzufound:
rD w2
d w3
rA w4
adrp x1, ins_lwzu
add x1, x1, :lo12: ins_lwzu
mov w27, lwzu_ident
b do_sprintf

lwzuxfound:
rD w2
rA w3
rB w4
adrp x1, ins_lwzux
add x1, x1, :lo12: ins_lwzux
mov w27, lwzux_ident
b do_sprintf

lwzxfound:
rD w2
rA w3
rB w4
adrp x1, ins_lwzx
add x1, x1, :lo12: ins_lwzx
mov w27, lwzx_ident
b do_sprintf

mcrffound:
crfD w2
crfS w3
adrp x1, ins_mcrf
add x1, x1, :lo12: ins_mcrf
mov w27, mcrf_ident
b do_sprintf

mcrfsfound:
crfD w2
crfS w3
adrp x1, ins_mcrfs
add x1, x1, :lo12: ins_mcrfs
mov w27, mcrfs_ident
b do_sprintf

mcrxrfound:
crfD w2
adrp x1, ins_mcrxr
add x1, x1, :lo12: ins_mcrxr
mov w27, mcrxr_ident
b do_sprintf

mfcrfound:
rD w2
adrp x1, ins_mfcr
add x1, x1, :lo12: ins_mfcr
mov w27, mfcr_ident
b do_sprintf

mffsXfound:
fD w2
adrp x1, ins_mffs
add x1, x1, :lo12: ins_mffs
mov w27, mffs_ident
b do_sprintf

mfmsrfound:
rD w2
adrp x1, ins_mfmsr
add x1, x1, :lo12: ins_mfmsr
mov w27, mfmsr_ident
b do_sprintf

mfsprfound: /*TODO put in all SPR variations*/
rD w2
SPR w3 w18
adrp x1, ins_mfspr
add x1, x1, :lo12: ins_mfspr
mov w27, mfspr_ident
b do_sprintf

mfsrfound:
rD w2
SR w3
adrp x1, ins_mfsr
add x1, x1, :lo12: ins_mfsr
mov w27, mfsr_ident
b do_sprintf

mfsrinfound:
rD w2
rB w3
adrp x1, ins_mfsrin
add x1, x1, :lo12: ins_mfsrin
mov w27, mfsrin_ident
b do_sprintf

mftbfound:
rD w2
TBR w3 w18
mov w27, mftb_ident
cmp w3, 269
beq 0x18
cmp w3, 268
bne invalidfound
adrp x1, ins_mftbl
add x1, x1, :lo12: ins_mftbl
b do_sprintf
adrp x1, ins_mftbu
add x1, x1, :lo12: ins_mftbu
b do_sprintf

mtcrffound:
CRM w2
rS w3
mov w27, mtcrf_ident
cmp w2, 0xFF
beq 0x10
adrp x1, ins_mtcrf
add x1, x1, :lo12: ins_mtcrf
b do_sprintf
mov w2, w3
adrp x1, ins_mtcr
add x1, x1, :lo12: ins_mtcr
b do_sprintf

mtfsb0Xfound:
crbD w2
adrp x1, ins_mtfsb0
add x1, x1, :lo12: ins_mtfsb0
mov w27, mtfsb0_ident
b do_sprintf

mtfsb1Xfound:
crbD w2
adrp x1, ins_mtfsb1
add x1, x1, :lo12: ins_mtfsb1
mov w27, mtfsb1_ident
b do_sprintf

mtfsfXfound:
FM w2
fB w3
adrp x1, ins_mtfsf
add x1, x1, :lo12: ins_mtfsf
mov w27, mtfsf_ident
b do_sprintf

mtfsfiXfound:
crfD w2
IMM w3
adrp x1, ins_mtfsfi
add x1, x1, :lo12: ins_mtfsfi
mov w27, mtfsfi_ident
b do_sprintf

mtmsrfound:
rS w2
adrp x1, ins_mtmsr
add x1, x1, :lo12: ins_mtmsr
mov w27, mtmsr_ident
b do_sprintf

mtsprfound: /*TODO put in all SPR variations later*/
SPR w2 w18
rS w3
adrp x1, ins_mtspr
add x1, x1, :lo12: ins_mtspr
mov w27, mtspr_ident
b do_sprintf

mtsrfound:
SR w2
rS w3
adrp x1, ins_mtsr
add x1, x1, :lo12: ins_mtsr
mov w27, mtsr_ident
b do_sprintf

mtsrinfound:
rS w2
rB w3
adrp x1, ins_mtsrin
add x1, x1, :lo12: ins_mtsrin
mov w27, mtsrin_ident
b do_sprintf

mulhwXfound:
rD w2
rA w3
rB w4
adrp x1, ins_mulhw
add x1, x1, :lo12: ins_mulhw
mov w27, mulhw_ident
b do_sprintf

mulhwuXfound:
rD w2
rA w3
rB w4
adrp x1, ins_mulhwu
add x1, x1, :lo12: ins_mulhwu
mov w27, mulhwu_ident
b do_sprintf

mullifound:
rD w2
rA w3
SIMM w4
adrp x1, ins_mulli
add x1, x1, :lo12: ins_mulli
mov w27, mulli_ident
b do_sprintf

mullwXfound:
rD w2
rA w3
rB w4
adrp x1, ins_mullw
add x1, x1, :lo12: ins_mullw
mov w27, mullw_ident
b do_sprintf

nandXfound:
rA w2
rS w3
rB w4
adrp x1, ins_nand
add x1, x1, :lo12: ins_nand
mov w27, nand_ident
b do_sprintf

negXfound:
rD w2
rA w3
adrp x1, ins_neg
add x1, x1, :lo12: ins_neg
mov w27, neg_ident
b do_sprintf

norXfound:
rA w2
rS w3
rB w4
mov w27, nor_ident
cmp w3, w4
bne 0x10
adrp x1, ins_not
add x1, x1, :lo12: ins_not
b do_sprintf
adrp x1, ins_nor
add x1, x1, :lo12: ins_nor
b do_sprintf

orXfound:
rA w2
rS w3
rB w4
mov w27, or_ident
cmp w3, w4
bne 0x10
adrp x1, ins_mr
add x1, x1, :lo12: ins_mr
b do_sprintf
adrp x1, ins_or
add x1, x1, :lo12: ins_or
b do_sprintf

orcXfound:
rA w2
rS w3
rB w4
adrp x1, ins_orc
add x1, x1, :lo12: ins_orc
mov w27, orc_ident
b do_sprintf

orifound:
mov w27, ori_ident
mov w18, 0x60000000
cmp w19, w18
bne 0x10
adrp x1, ins_nop
add x1, x1, :lo12: ins_nop
b do_sprintf
rA w2
rS w3
UIMM w4
adrp x1, ins_ori
add x1, x1, :lo12: ins_ori
b do_sprintf

orisfound:
rA w2
rS w3
UIMM w4
adrp x1, ins_oris
add x1, x1, :lo12: ins_oris
mov w27, oris_ident
b do_sprintf

psq_lfound:
fD w2
ps_SIMM w3
rA w4
W_nonx w5
I_nonx w6
adrp x1, ins_psq_l
add x1, x1, :lo12: ins_psq_l
mov w27, psq_l_ident
b do_sprintf

psq_lufound:
fD w2
ps_SIMM w3
rA w4
W_nonx w5
I_nonx w6
adrp x1, ins_psq_lu
add x1, x1, :lo12: ins_psq_lu
mov w27, psq_lu_ident
b do_sprintf

psq_luxfound:
fD w2
rA w3
rB w4
W_x w5
I_x w6
adrp x1, ins_psq_lux
add x1, x1, :lo12: ins_psq_lux
mov w27, psq_lux_ident
b do_sprintf

psq_lxfound:
fD w2
rA w3
rB w4
W_x w5
I_x w6
adrp x1, ins_psq_lx
add x1, x1, :lo12: ins_psq_lx
mov w27, psq_lx_ident
b do_sprintf

psq_stfound:
fD w2
ps_SIMM w3
rA w4
W_nonx w5
I_nonx w6
adrp x1, ins_psq_st
add x1, x1, :lo12: ins_psq_st
mov w27, psq_st_ident
b do_sprintf

psq_stufound:
fD w2
ps_SIMM w3
rA w4
W_nonx w5
I_nonx w6
adrp x1, ins_psq_stu
add x1, x1, :lo12: ins_psq_stu
mov w27, psq_stu_ident
b do_sprintf

psq_stuxfound:
fD w2
rA w3
rB w4
W_x w5
I_x w6
adrp x1, ins_psq_stux
add x1, x1, :lo12: ins_psq_stux
mov w27, psq_stux_ident
b do_sprintf

psq_stxfound:
fD w2
rA w3
rB w4
W_x w5
I_x w6
adrp x1, ins_psq_stx
add x1, x1, :lo12: ins_psq_stx
mov w27, psq_stx_ident
b do_sprintf

ps_absXfound:
fD w2
fB w3
adrp x1, ins_ps_abs
add x1, x1, :lo12: ins_ps_abs
mov w27, ps_abs_ident
b do_sprintf

ps_addXfound:
fD w2
fA w3
fB w4
adrp x1, ins_ps_add
add x1, x1, :lo12: ins_ps_add
mov w27, ps_add_ident
b do_sprintf

ps_cmpo0found:
crfD w2
fA w3
fB w4
adrp x1, ins_ps_cmpo0
add x1, x1, :lo12: ins_ps_cmpo0
mov w27, ps_cmpo0_ident
b do_sprintf

ps_cmpo1found:
crfD w2
fA w3
fB w4
adrp x1, ins_ps_cmpo1
add x1, x1, :lo12: ins_ps_cmpo1
mov w27, ps_cmpo1_ident
b do_sprintf

ps_cmpu0found:
crfD w2
fA w3
fB w4
adrp x1, ins_ps_cmpu0
add x1, x1, :lo12: ins_ps_cmpu0
mov w27, ps_cmpu0_ident
b do_sprintf

ps_cmpu1found:
crfD w2
fA w3
fB w4
adrp x1, ins_ps_cmpu1
add x1, x1, :lo12: ins_ps_cmpu1
mov w27, ps_cmpu1_ident
b do_sprintf

ps_divXfound:
fD w2
fA w3
fB w4
adrp x1, ins_ps_div
add x1, x1, :lo12: ins_ps_div
mov w27, ps_div_ident
b do_sprintf

ps_maddXfound:
fD w2
fA w3
fC w4
fB w4
adrp x1, ins_ps_madd
add x1, x1, :lo12: ins_ps_madd
mov w27, ps_madd_ident
b do_sprintf

ps_madds0Xfound:
fD w2
fA w3
fC w4
fB w4
adrp x1, ins_ps_madds0
add x1, x1, :lo12: ins_ps_madds0
mov w27, ps_madds0_ident
b do_sprintf

ps_madds1Xfound:
fD w2
fA w3
fC w4
fB w4
adrp x1, ins_ps_madds1
add x1, x1, :lo12: ins_ps_madds1
mov w27, ps_madds1_ident
b do_sprintf

ps_merge00Xfound:
fD w2
fA w3
fB w4
adrp x1, ins_ps_merge00
add x1, x1, :lo12: ins_ps_merge00
mov w27, ps_merge00_ident
b do_sprintf

ps_merge01Xfound:
fD w2
fA w3
fB w4
adrp x1, ins_ps_merge01
add x1, x1, :lo12: ins_ps_merge01
mov w27, ps_merge01_ident
b do_sprintf

ps_merge10Xfound:
fD w2
fA w3
fB w4
adrp x1, ins_ps_merge10
add x1, x1, :lo12: ins_ps_merge10
mov w27, ps_merge10_ident
b do_sprintf

ps_merge11Xfound:
fD w2
fA w3
fB w4
adrp x1, ins_ps_merge11
add x1, x1, :lo12: ins_ps_merge11
mov w27, ps_merge11_ident
b do_sprintf

ps_mrXfound:
fD w2
fB w3
adrp x1, ins_ps_mr
add x1, x1, :lo12: ins_ps_mr
mov w27, ps_mr_ident
b do_sprintf

ps_msubXfound:
fD w2
fA w3
fC w4
fB w4
adrp x1, ins_ps_msub
add x1, x1, :lo12: ins_ps_msub
mov w27, ps_msub_ident
b do_sprintf

ps_mulXfound:
fD w2
fA w3
fC w4
adrp x1, ins_ps_mul
add x1, x1, :lo12: ins_ps_mul
mov w27, ps_mul_ident
b do_sprintf

ps_muls0Xfound:
fD w2
fA w3
fC w4
adrp x1, ins_ps_muls0
add x1, x1, :lo12: ins_ps_muls0
mov w27, ps_muls0_ident
b do_sprintf

ps_muls1Xfound:
fD w2
fA w3
fC w4
adrp x1, ins_ps_muls1
add x1, x1, :lo12: ins_ps_muls1
mov w27, ps_muls1_ident
b do_sprintf

ps_nabsXfound:
fD w2
fB w3
adrp x1, ins_ps_nabs
add x1, x1, :lo12: ins_ps_nabs
mov w27, ps_nabs_ident
b do_sprintf

ps_negXfound:
fD w2
fB w3
adrp x1, ins_ps_neg
add x1, x1, :lo12: ins_ps_neg
mov w27, ps_neg_ident
b do_sprintf

ps_nmaddXfound:
fD w2
fA w3
fC w4
fB w4
adrp x1, ins_ps_nmadd
add x1, x1, :lo12: ins_ps_nmadd
mov w27, ps_nmadd_ident
b do_sprintf

ps_nmsubXfound:
fD w2
fA w3
fC w4
fB w4
adrp x1, ins_ps_nmsub
add x1, x1, :lo12: ins_ps_nmsub
mov w27, ps_nmsub_ident
b do_sprintf

ps_resXfound:
fD w2
fB w3
adrp x1, ins_ps_res
add x1, x1, :lo12: ins_ps_res
mov w27, ps_res_ident
b do_sprintf

ps_rsqrteXfound:
fD w2
fB w3
adrp x1, ins_ps_rsqrte
add x1, x1, :lo12: ins_ps_rsqrte
mov w27, ps_rsqrte_ident
b do_sprintf

ps_selXfound:
fD w2
fA w3
fC w4
fB w4
adrp x1, ins_ps_sel
add x1, x1, :lo12: ins_ps_sel
mov w27, ps_sel_ident
b do_sprintf

ps_subXfound:
fD w2
fA w3
fB w4
adrp x1, ins_ps_sub
add x1, x1, :lo12: ins_ps_sub
mov w27, ps_sub_ident
b do_sprintf

ps_sum0Xfound:
fD w2
fA w3
fC w4
fB w4
adrp x1, ins_ps_sum0
add x1, x1, :lo12: ins_ps_sum0
mov w27, ps_sum0_ident
b do_sprintf

ps_sum1Xfound:
fD w2
fA w3
fC w4
fB w4
adrp x1, ins_ps_sum1
add x1, x1, :lo12: ins_ps_sum1
mov w27, ps_sum1_ident
b do_sprintf

rfifound:
adrp x1, ins_rfi
add x1, x1, :lo12: ins_rfi
mov w27, rfi_ident
b do_sprintf

rlwimiXfound:
rA w2
rS w3
SH w4
MB w5
ME w6
adrp x1, ins_rlwimi
add x1, x1, :lo12: ins_rlwimi
mov w27, rlwimi_ident
b do_sprintf

rlwinmXfound:
rA w2
rS w3
SH w4
MB w5
ME w6
adrp x1, ins_rlwinm
add x1, x1, :lo12: ins_rlwinm
mov w27, rlwinm_ident
b do_sprintf

rlwnmXfound:
rA w2
rS w3
rB w4
MB w5
ME w6
adrp x1, ins_rlwnm
add x1, x1, :lo12: ins_rlwnm
mov w27, rlwnm_ident
b do_sprintf

scfound:
adrp x1, ins_sc
add x1, x1, :lo12: ins_sc
mov w27, sc_ident
b do_sprintf

slwXfound:
rA w2
rS w3
rB w4
adrp x1, ins_slw
add x1, x1, :lo12: ins_slw
mov w27, slw_ident
b do_sprintf

srawXfound:
rA w2
rS w3
rB w4
adrp x1, ins_sraw
add x1, x1, :lo12: ins_sraw
mov w27, sraw_ident
b do_sprintf

srawiXfound:
rA w2
rS w3
SH w4
adrp x1, ins_srawi
add x1, x1, :lo12: ins_srawi
mov w27, srawi_ident
b do_sprintf

srwXfound:
rA w2
rS w3
rB w4
adrp x1, ins_srw
add x1, x1, :lo12: ins_srw
mov w27, srw_ident
b do_sprintf

stbfound:
rS w2
d w3
rA w4
adrp x1, ins_stb
add x1, x1, :lo12: ins_stb
mov w27, stb_ident
b do_sprintf

stbufound:
rS w2
d w3
rA w4
adrp x1, ins_stbu
add x1, x1, :lo12: ins_stbu
mov w27, stbu_ident
b do_sprintf

stbuxfound:
rS w2
rA w3
rB w4
adrp x1, ins_stbux
add x1, x1, :lo12: ins_stbux
mov w27, stbux_ident
b do_sprintf

stbxfound:
rS w2
rA w3
rB w4
adrp x1, ins_stbx
add x1, x1, :lo12: ins_stbx
mov w27, stbx_ident
b do_sprintf

stfdfound:
fS w2
d w3
rA w4
adrp x1, ins_stfd
add x1, x1, :lo12: ins_stfd
mov w27, stfd_ident
b do_sprintf

stfdufound:
fS w2
d w3
rA w4
adrp x1, ins_stfdu
add x1, x1, :lo12: ins_stfdu
mov w27, stfdu_ident
b do_sprintf

stfduxfound:
fS w2
rA w3
rB w4
adrp x1, ins_stfdux
add x1, x1, :lo12: ins_stfdux
mov w27, stfdux_ident
b do_sprintf

stfdxfound:
fS w2
rA w3
rB w4
adrp x1, ins_stfdx
add x1, x1, :lo12: ins_stfdx
mov w27, stfdx_ident
b do_sprintf

stfiwxfound:
fS w2
rA w3
rB w4
adrp x1, ins_stfiwx
add x1, x1, :lo12: ins_stfiwx
mov w27, stfiwx_ident
b do_sprintf

stfsfound:
fS w2
d w3
rA w4
adrp x1, ins_stfs
add x1, x1, :lo12: ins_stfs
mov w27, stfs_ident
b do_sprintf

stfsufound:
fS w2
d w3
rA w4
adrp x1, ins_stfsu
add x1, x1, :lo12: ins_stfsu
mov w27, stfsu_ident
b do_sprintf

stfsuxfound:
fS w2
rA w3
rB w4
adrp x1, ins_stfsux
add x1, x1, :lo12: ins_stfsux
mov w27, stfsux_ident
b do_sprintf

stfsxfound:
fS w2
rA w3
rB w4
adrp x1, ins_stfsx
add x1, x1, :lo12: ins_stfsx
mov w27, stfsx_ident
b do_sprintf

sthfound:
rS w2
d w3
rA w4
adrp x1, ins_sth
add x1, x1, :lo12: ins_sth
mov w27, sth_ident
b do_sprintf

sthbrxfound:
rS w2
rA w3
rB w4
adrp x1, ins_sthbrx
add x1, x1, :lo12: ins_sthbrx
mov w27, sthbrx_ident
b do_sprintf

sthufound:
rS w2
d w3
rA w4
adrp x1, ins_sthu
add x1, x1, :lo12: ins_sthu
mov w27, sthu_ident
b do_sprintf

sthuxfound:
rS w2
rA w3
rB w4
adrp x1, ins_sthux
add x1, x1, :lo12: ins_sthux
mov w27, sthux_ident
b do_sprintf

sthxfound:
rS w2
rA w3
rB w4
adrp x1, ins_sthx
add x1, x1, :lo12: ins_sthx
mov w27, sthx_ident
b do_sprintf

stmwfound:
rS w2
d w3
rA w4
adrp x1, ins_stmw
add x1, x1, :lo12: ins_stmw
mov w27, stmw_ident
b do_sprintf

stswifound:
rS w2
rA w3
NB w4
adrp x1, ins_stswi
add x1, x1, :lo12: ins_stswi
mov w27, stswi_ident
b do_sprintf

stswxfound:
rS w2
rA w3
rB w4
adrp x1, ins_stswx
add x1, x1, :lo12: ins_stswx
mov w27, stswx_ident
b do_sprintf

stwfound:
rS w2
d w3
rA w4
adrp x1, ins_stw
add x1, x1, :lo12: ins_stw
mov w27, stw_ident
b do_sprintf

stwbrxfound:
rS w2
rA w3
rB w4
adrp x1, ins_stwbrx
add x1, x1, :lo12: ins_stwbrx
mov w27, stwbrx_ident
b do_sprintf

stwcxRCfound:
rS w2
rA w3
rB w4
adrp x1, ins_stwcx_
add x1, x1, :lo12: ins_stwcx_
mov w27, stwcxRC_ident
b do_sprintf

stwufound:
rS w2
d w3
rA w4
adrp x1, ins_stwu
add x1, x1, :lo12: ins_stwu
mov w27, stwu_ident
b do_sprintf

stwuxfound:
rS w2
rA w3
rB w4
adrp x1, ins_stwux
add x1, x1, :lo12: ins_stwux
mov w27, stwux_ident
b do_sprintf

stwxfound:
rS w2
rA w3
rB w4
adrp x1, ins_stwx
add x1, x1, :lo12: ins_stwx
mov w27, stwx_ident
b do_sprintf

subXfound:
rD w3
rB w4
rA w5
adrp x1, ins_sub
add x1, x1, :lo12: ins_sub
mov w27, subf_ident
b do_sprintf

subcXfound:
rD w3
rB w4
rA w5
adrp x1, ins_subc
add x1, x1, :lo12: ins_subc
mov w27, subfc_ident
b do_sprintf

subfeXfound:
rD w3
rA w4
rB w5
adrp x1, ins_subfe
add x1, x1, :lo12: ins_subfe
mov w27, subfe_ident
b do_sprintf

subficfound:
rD w2
rA w3
SIMM w4
adrp x1, ins_subfic
add x1, x1, :lo12: ins_subfic
mov w27, subfic_ident
b do_sprintf

subfmeXfound:
rD w2
rA w3
adrp x1, ins_subfme
add x1, x1, :lo12: ins_subfme
mov w27, subfme_ident
b do_sprintf

subfzeXfound:
rD w2
rA w3
adrp x1, ins_subfze
add x1, x1, :lo12: ins_subfze
mov w27, subfze_ident
b do_sprintf

syncfound:
adrp x1, ins_sync
add x1, x1, :lo12: ins_sync
mov w27, sync_ident
b do_sprintf

tlbiefound:
rB w2
adrp x1, ins_tlbie
add x1, x1, :lo12: ins_tlbie
mov w27, tlbie_ident
b do_sprintf

tlbsyncfound:
adrp x1, ins_tlbsync
add x1, x1, :lo12: ins_tlbsync
mov w27, tlbsync_ident
b do_sprintf

twfound:
TO w2
rA w3
rB w4
mov w27, tw_ident
cmp w2, 31
bne 0x10
adrp x1, ins_trap
add x1, x1, :lo12: ins_trap
b do_sprintf
adrp x1, ins_tw
add x1, x1, :lo12: ins_tw
b do_sprintf

twifound:
TO w2
rA w3
SIMM w4
adrp x1, ins_twi
add x1, x1, :lo12: ins_twi
mov w27, twi_ident
b do_sprintf

xorXfound:
rA w2
rS w3
rB w4
adrp x1, ins_xor
add x1, x1, :lo12: ins_xor
mov w27, xor_ident
b do_sprintf

xorifound:
rA w2
rS w3
UIMM w4
adrp x1, ins_xori
add x1, x1, :lo12: ins_xori
mov w27, xori_ident
b do_sprintf

xorisfound:
rA w2
rS w3
UIMM w4
adrp x1, ins_xoris
add x1, x1, :lo12: ins_xoris
mov w27, xoris_ident

do_sprintf:
mov x0, x20
bl sprintf
cmp w0, 0
blt disa_sprint_error

/*Now extract certain bits*/
and w12, w19, rc /*also lk*/
and w13, w19, oe
and w14, w19, aa

/*NOTE you must check oe+rc and ll+ak before checking just rc or just ak for example, and base instruction MUST be checked last*/

/*Check to see if we will append mnemonic with branch hint*/
cmp w27, bc_ident
beq condi_branch
cmp w27, bcctr_ident
beq condi_branch
cmp w27, bclr_ident
bne check_for_oe_type_instruction

/*TODO put in stuff here to handle bit hint crap*/
condi_branch:
/*TODO
mov w0, 0x2B //+
b 0x8
mov w0, 0x2D //-
bl insert_char
*/
b check_for_aa_type_instruction

/*Now add 1 to w27 if oe
add, addc, adde, addme, addze, mullw, divw, divwu, neg, subf, subfc, subfe, subfme, subfze
First check if instruction even allows an oe bit*/
check_for_oe_type_instruction:
cmp w27, adde_ident
bls oe_bit_allowed /*Covers add and addc*/
cmp w27, addme_ident
beq oe_bit_allowed
cmp w27, addze_ident
beq oe_bit_allowed
cmp w27, mullw_ident
beq oe_bit_allowed
cmp w27, divw_ident
beq oe_bit_allowed
cmp w27, divwu_ident
beq oe_bit_allowed
cmp w27, neg_ident
beq oe_bit_allowed
cmp w27, subf_ident
beq oe_bit_allowed
cmp w27, subfc_ident
beq oe_bit_allowed
cmp w27, subfe_ident
beq oe_bit_allowed
cmp w27, subfme_ident
beq oe_bit_allowed
cmp w27, subfze_ident
beq oe_bit_allowed

/*Check if aa bit is allowed, simply see if instruction starts
b, and bc*/
check_for_aa_type_instruction:
cmp w27, b_ident
beq check_for_aa
cmp w27, bc_ident
bne check_for_rc

/*aa_bit_allowed, HOWEVER check for lk first!!!*/
cmp w12, rc /*rc works! same bit as lk*/
bne check_for_aa

/*LK bit is being used*/
add w27, w27, 1
/*Insert "l" after menomnic*/
mov w0, 0x6C  /*lowercase l*/
bl insert_char

/*NOW check for aa bit*/
check_for_aa:
cmp w14, aa
bne are_we_done_yet_lol

/*AA bit found*/
add w27, w27, 2
/*Insert "a' after menomic*/
mov w0, 0x61 /*lowercase a*/
bl insert_char
b are_we_done_yet_lol

/*Add 1 if oe bit present*/
oe_bit_allowed:
cmp w13, oe
bne check_for_rc

/*OE bit found*/
add w27, w27, 2
/*Insert "o" after mnemonic*/
mov w0, 0x6F /*lowercase o*/
bl insert_char

/*Now add 1 to w27 if rc*/
check_for_rc:
cmp w12, rc
bne are_we_done_yet_lol

/*rc bit found*/
add w27, w27, 1
/*insert rc bit to string*/
mov w0, 0x2E /*period*/
bl insert_char

/*Return w27 (PPC ident) and w0 as zero for success*/
are_we_done_yet_lol:
mov w1, w27
mov w0, 0
b disa_epilogue
disa_sprint_error:
adr x0, disaEC

/*Epilogue*/
disa_epilogue:
ldr x27, [sp, 0x50]
ldp x25, x26, [sp, 0x40]
ldp x23, x24, [sp, 0x30]
ldp x21, x22, [sp, 0x20]
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x60
ret

/*Args
w0 = BitField
w1 = Primary Mask
Return Value (w0)
1 = True (Found)
0 = False*/
first_check:
and w2, w0, w19 /*BitField & PPCInstruction*/
cmp w2, w1 /*Compare result to Primary Mask, Set NZCV flags*/
cset w0, eq /*Copy paste EQ result to w0*/
ret

/*Args
w0 = Secondary Mask
Return Value (w0)
1 = True (Found)
0 = False*/
second_check:
tst w0, w19 /*2nd Mask & PPCInstruction*/
cset w0, eq
ret

/*Special check for lbzu, lbzux, lhau, lhaux, lhzu, lhzux, lwzu, and lwzux*/
/*1 = True (good), 0 = False (bad)*/
lXzu_lXzux_special_check:
ubfx w1, w19, 16, 5 /*Extract rD, right justified*/
ubfx w0, w19, 21, 5 /*Extract rA, right justified*/
cmp w1, 0
ccmp w0, w1, 4, ne
cset w0, eq
ret

/*NOTE not used instead we use check_nullrA and check the bool in the opposite fashion*/
/*Special check for..
// lfdu, lfsu, psq_lu, psq_stu, stbu, stfdu, stfsu, sthu, stwu
// lfdux, lfsux, psq_lux, psq_stux, stbux, stfdux, stfsux, sthux, stwux*/
/*1 = True *good), 0 = False (bad)*/
/*float_ps_update_and_store_update_special_check:
tst w19, 0x1F0000
cset w0, ne
ret*/

/*NOTE following is not used as these are one-offs, they are done "inline*/
/*
lmw_special_check:
ubfx w1, w19, 21, 5
ubfx w0, w19, 16, 5
cmp w1, w0
cset w0, hi
ret

lswi_special_check:
ubfx w2, w19, 11, 5
ubfx w1, w19, 16, 5
ubfx w0, w19, 21, 5
sub w0, w1, w0
cmp w2, w0, lsl 2
cset w0, cs
ret
*/

/*x0 = string
w1 = char to insert*/
insert_char:
mov x1, x26
/*Move cursor forward til we hit +, -, or space. Check in that order*/
ldrb w2, [x1], 1
cmp w2, 0x2B /*+*/
beq cursor_ready
cmp w2, 0x2D /*-*/
beq cursor_ready
cmp w2, 0x20 /*space*/
bne -0x18
/*Cursor ready, move remainder of string PLUS null byte forward 1 byte*/
cursor_ready:
mov x2, x1
ldrb w3, [x2], 1
cmp w3, 0
bne -0x8
sub x2, x2, x0
add w2, w2, w1 /*account for null byte*/
/*Crude memcpy*/
mov x3, x1
ldrb w4, [x3], 1
strb w4, [x3], 1
subs w2, w2, 1
bne -0xC
/*Insert the char*/
strb w0, [x1]
ret

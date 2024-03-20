#include "global/ins/extractedPPCstuffOffsets.S"
#include "global/ins/instruction_strings.S"
#include "global/ppc_idents.S"

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
/*.set check_sc, 0x03FFFFFD */ /*Not needed*/
.set check_tlbie, 0x03FF0001 /*tlbie*/

.macro check_nullrA /*Also used for fA. Not in second_check since we can AND it in one go. When using this for float_ps_update_and_store_update_special_check, make sure to flip the bool check*/
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
tst w19, 0x0201
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

.macro d register
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
//CHECK ABOVE rlwinm \register, r31, 14, 0x7
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

/*NOT NEEDED
.macro b30sc FC000002
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

/*Now extract rc bit*/
and w12, w19, rc //also lk
and w13, w19, oe
and w14, w19, aa

/*NOTE you must check oe+rc and ll+ak before checking just rc or just ak for example, and base instruction MUST be checked last*/

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


/*Found ill instruction*/
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
mov w27, addic_ident

addicRCfound:
mov w27, addicRC_ident

addisfound:
rD w2
rD w3
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
mov w27, addme_ident


addzeXfound:
mov w27, addze_ident


andXfound:
mov w27, and_ident

andcXfound:
mov w27, andc_ident

andiRCfound:
mov w27, andiRC_ident

andisRCfound:
mov w27, andisRC_ident

bXfound:
mov w27, b_ident


bcXfound:
mov w27, bc_ident


bcctrXfound:
mov w27, bcctr_ident

bclrXfound:
mov w27, bclr_ident


cmpwfound:

cmpwifound:

cmplwfound:

cmplwifound:

cntlzwXfound:

crandfound:

crandcfound:

creqvfound:

crnandfound:

crnorfound:

crorfound:

crorcfound:

crxorfound:

dcbffound:

dcbifound:

dcbstfound:

dcbtfound:

dcbtstfound:

dcbzfound:

dcbz_lfound:

divwXfound:

divwuXfound:

eciwxfound:

ecowxfound:

eieiofound:

eqvXfound:

extsbXfound:

extshXfound:

fabsXfound:

faddXfound:

faddsXfound:

fcmpofound:

fcmpufound:

fctiwXfound:

fctiwzXfound:

fdivXfound:

fdivsXfound:

fmaddXfound:

fmadsXfound:

fmrXfound:

fmsubXfound:

fmsubsXfound:

fmulXfound:

fmulsXfound:

fnabsXfound:

fnegXfound:

fnmaddXfound:

fnmaddsXfound:

fnmsubXfound:

fnmsubsXfound:

fresXfound:

frspXfound:

frsqrteXfound:

fselXfound:

fsubXfound:

fsubsXfound:

icbifound:

lbzfound:

lbzufound:

lbzuxfound:

lbzxfound:

lfdfound:

lfdufound:

lfduxfound:

lfdxfound:

lfsfound:

lfsufound:

lfsuxfound:

lfsxfound:

lhafound:

lhaufound:

lhauxfound:

lhaxfound:

lhbrxfound:

lhzfound:

lhzufound:

lhzuxfound:

lhzxfound:

lmwfound:

lswifound:

do_sprintf:
mov x0, x20
bl sprintf
cmp w0, 0
blt disa_sprint_error

/*Check to see if we will append mnemonic with branch hint*/
cmp w27, bc_ident
beq condi_branch
cmp w27, bcctr_ident
beq condi_branch
cmp w27, bclr_ident
bne check_for_oe_type_instruction

/*TODO put in stuff here to handle bit hint crap*/
condi_branch:
//TODO
mov w0, 0x2B //+
b 0x8
mov w0, 0x2D //-
bl insert_char
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

lXzu_lXzux_special_check:
ubfx w1, w19, 16, 5 /*Extract rD, right justified*/
ubfx w0, w19, 21, 5 /*Extract rA, right justified*/
cmp w1, 0
ccmp w0, w1, 4, ne
cset w0, eq
ret

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
/*Cursor ready, move remainder of string PLUS null byte forwoard 1 byte*/
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



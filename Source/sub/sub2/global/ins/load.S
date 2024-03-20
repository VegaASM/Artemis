

// multiply rX by 4 (lsl 2)
// multiply fX by 8 (lsl 3)
/*
.globl lbz_ppc
lbz_ppc:
//r3 = rD number
//r4 = SIMM
//r5 = rA number
//r6 = array ptr (0x20 register bank ptr, 0x28 mem80 ptr, 0x30 mem90 ptr)
//Calc fake EA & check mem80 vs mem90
add EA, rD, SIMM
tst EA, 0x10000000
cbnz 0xC
ldr tmp1, [ptr, 0x28] //mem1 real base ptr
b 0xC
ldr tmp1, [ptr, 0x30] //mem2 real base ptr
ldr x8, [x6, 0x30]
ldrb w0, [x8, x7] //Load byte from real memory using EA as offset
//"Load" byte into fake register
ldr x9, [x6, 0x20] //Grab register bank ptr from array
str w0, [x3, x9] //Yes this is str and NOT strb cuz its load byte and zero
ret

.globl lhz_ppc
lhz_ppc:
//r3 = rD number
//r4 = SIMM
//r5 = rA number
//r6 = array ptr (0x20 register bank ptr, 0x28 mem80 ptr, 0x30 mem90 ptr)
//Calc fake EA & check mem80 vs mem90
add w7, w4, w5
and w0, w7, 0x10000000
cbnz 0xC
ldr x8, [x6, 0x28] //mem80 real base ptr
b 0xC
sub w7, w7, 0x10000000 //mem90 real base ptr, adjust offset
ldr x8, [x6, 0x30]
ldrh w0, [x8, x7] //Load halfword from real memory using EA as offset
//"Load" halfword into fake register
ldr x9, [x6, 0x20] //Grab register bank ptr from array
str w0, [x3, x9] //Yes this is str and NOT strh cuz its load halfword and ZERO
ret

.globl lha_ppc
lha_ppc:
//r3 = rD number
//r4 = SIMM
//r5 = rA number
//r6 = array ptr (0x20 register bank ptr, 0x28 mem80 ptr, 0x30 mem90 ptr)
//Calc fake EA & check mem80 vs mem90
add w7, w4, w5
and w0, w7, 0x10000000
cbnz 0xC
ldr x8, [x6, 0x28] //mem80 real base ptr
b 0xC
sub w7, w7, 0x10000000 //mem90 real base ptr, adjust offset
ldr x8, [x6, 0x30]
ldrhs w0, [x8, x7] //Load signed halfword from real memory using EA as offset
//"Load" signed halfword into fake register
ldr x9, [x6, 0x20] //Grab register bank ptr from array
str w0, [x3, x9] //Yes this is str , we need to put in the extended bits as well
ret

.globl lwz_ppc
lwz_ppc:
//r3 = rD number
//r4 = SIMM
//r5 = rA number
//r6 = array ptr (0x20 register bank ptr, 0x28 mem80 ptr, 0x30 mem90 ptr)
//Calc fake EA & check mem80 vs mem90
add w7, w4, w5
and w0, w7, 0x10000000
cbnz 0xC
ldr x8, [x6, 0x28] //mem80 real base ptr
b 0xC
sub w7, w7, 0x10000000 //mem90 real base ptr, adjust offset
ldr x8, [x6, 0x30]
ldr w0, [x8, x7] //Load word from real memory using EA as offset
//"Load" word into fake register
ldr x9, [x6, 0x20] //Grab register bank ptr from array
str w0, [x3, x9] //Yes this is str and NOT strb cuz its load word and ZERO
ret

.globl lfs_ppc
lfs_ppc:
//r3 = fD number
//r4 = SIMM
//r5 = rA number
//r6 = array ptr (0x20 register bank ptr, 0x28 mem80 ptr, 0x30 mem90 ptr)
//Calc fake EA & check mem80 vs mem90
add w7, w4, w5
and w0, w7, 0x10000000
cbnz 0xC
ldr x8, [x6, 0x28] //mem80 real base ptr
b 0xC
sub w7, w7, 0x10000000 //mem90 real base ptr, adjust offset
ldr x8, [x6, 0x30]
ldr w0, [x8, x7] //Load word from real memory using EA as offset
//"Load" word into fake register, we *DON*T need to use float int for this
ldr x9, [x6, 0x20] //Grab register bank ptr from array
add x9, x9, fpr_offset //Adjust bank pointer to start of FPRs
str w0, [x3, x9] //update register bank
ret

.globl lfd_ppc
lfd_ppc:
//r3 = fD number
//r4 = SIMM
//r5 = rA number
//r6 = array ptr (0x20 register bank ptr, 0x28 mem80 ptr, 0x30 mem90 ptr)
//Calc fake EA & check mem80 vs mem90
add w7, w4, w5
and w0, w7, 0x10000000
cbnz 0xC
ldr x8, [x6, 0x28] //mem80 real base ptr
b 0xC
sub w7, w7, 0x10000000 //mem90 real base ptr, adjust offset
ldr x8, [x6, 0x30]
ldr x0, [x8, x7] //Load doubleword from real memory using EA as offset
//"Load" doubleword into fake register, we *DON*T need to use float int for this
ldr x9, [x6, 0x20] //Grab register bank ptr from array
add x9, x9, fpr_offset //Adjust bank pointer to start of FPRs
str x0, [x3, x9] //update register bank
ret

.globl stb_ppc
stb_ppc:
//r3 = rD number
//r4 = SIMM
//r5 = rA number
//r6 = array ptr (0x20 register bank ptr, 0x28 mem80 ptr, 0x30 mem90 ptr)
//Calc fake EA, Check mem80 vs mem90 for EA
add w7, w4, w5
and w0, w7, 0x10000000
cbnz 0xC
ldr x8, [x6, 0x28] //mem80 real base ptr
b 0xC
sub w7, w7, 0x10000000 //mem90 real base ptr, adjust offset
ldr x8, [x6, 0x30]
ldr x9, [x6, 0x20] //Grab register bank pointer from array
ldrb w0, [x9, x3] //Load byte from register area
//Store byte  to real memory using EA as offset
strb w0, [x3, x7]
ret

.globl sth_ppc
sth_ppc:
//r3 = rD number
//r4 = SIMM
//r5 = rA number
//r6 = array ptr (0x20 register bank ptr, 0x28 mem80 ptr, 0x30 mem90 ptr)
//Calc fake EA, Check mem80 vs mem90 for EA
add w7, w4, w5
and w0, w7, 0x10000000
cbnz 0xC
ldr x8, [x6, 0x28] //mem80 real base ptr
b 0xC
sub w7, w7, 0x10000000 //mem90 real base ptr, adjust offset
ldr x8, [x6, 0x30]
ldr x9, [x6, 0x20] //Grab register bank pointer from array
ldrh w0, [x9, x3] //Load halfword from register area
//Store halfword to real memory using EA as offset
strh w0, [x3, x7]
ret

.globl stw_ppc
stw_ppc:
//r3 = rD number
//r4 = SIMM
//r5 = rA number
//r6 = array ptr (0x20 register bank ptr, 0x28 mem80 ptr, 0x30 mem90 ptr)
//Calc fake EA, Check mem80 vs mem90 for EA
add w7, w4, w5
and w0, w7, 0x10000000
cbnz 0xC
ldr x8, [x6, 0x28] //mem80 real base ptr
b 0xC
sub w7, w7, 0x10000000 //mem90 real base ptr, adjust offset
ldr x8, [x6, 0x30]
ldr x9, [x6, 0x20] //Grab register bank pointer from array
ldr w0, [x9, x3] //Load word from register area
//Store word to real memory using EA as offset
str w0, [x3, x7]
ret

.globl stfs_ppc
stfs_ppc:
//r3 = fD number
//r4 = SIMM
//r5 = rA number
//r6 = array ptr (0x20 register bank ptr, 0x28 mem80 ptr, 0x30 mem90 ptr)
//Calc fake EA, Check mem80 vs mem90 for EA
add w7, w4, w5
and w0, w7, 0x10000000
cbnz 0xC
ldr x8, [x6, 0x28] //mem80 real base ptr
b 0xC
sub w7, w7, 0x10000000 //mem90 real base ptr, adjust offset
ldr x8, [x6, 0x30]
ldr x9, [x6, 0x20] //Grab register bank pointer from 
add x9, x9, fpr_offset //Adjust bank pointer to start of FPRs
ldr w0, [x9, x3] //Load word from register area. we *DON*T need to use float ints on this fyi
//Store word to real memory using EA as offset
str w0, [x3, x7]
ret

.globl stfs_ppc
stfs_ppc:
//r3 = fD number
//r4 = SIMM
//r5 = rA number
//r6 = array ptr (0x20 register bank ptr, 0x28 mem80 ptr, 0x30 mem90 ptr)
//Calc fake EA, Check mem80 vs mem90 for EA
add w7, w4, w5
and w0, w7, 0x10000000
cbnz 0xC
ldr x8, [x6, 0x28] //mem80 real base ptr
b 0xC
sub w7, w7, 0x10000000 //mem90 real base ptr, adjust offset
ldr x8, [x6, 0x30]
ldr x9, [x6, 0x20] //Grab register bank pointer from 
add x9, x9, fpr_offset //Adjust bank pointer to start of FPRs
ldr x0, [x9, x3] //Load double word from register area. we *DON*T need to use float ints on this fyi
//Store double word to real memory using EA as offset
str x0, [x3, x7]
ret
*/








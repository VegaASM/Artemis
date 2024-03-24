.set msr_le, 0x00000001
.set msr_ri, 0x00000002
.set msr_pm, 0x00000004
.set msr_dr, 0x00000010
.set msr_ir, 0x00000020
.set msr_ip, 0x00000040
.set msr_fe1, 0x00000100
.set msr_be, 0x00000200
.set msr_se, 0x00000400
.set msr_fe0, 0x00000800
.set msr_me, 0x00001000
.set msr_fp, 0x00002000
.set msr_pr, 0x00004000
.set msr_ee, 0x00008000
.set msr_ile, 0x00010000
.set msr_pow, 0x00040000

.set allotherexceptions_msr_mask, msr_ile | msr_me | msr_ip //MSR mask for anything BUT machine check. NOTE there's no info on the mask for IABR in the broadway. best to assume its this.
.set mcheck_msr_mask, msr_ile | msr_ip

.globl reset_exception_vector
reset_exception_vector:
//Copy PC to srr0
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Set new PC
mov w1, 0x100
str w1, [x0, pc]
//Copy MSR to srr1
ldr w1, [x0, msr]
str w1, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

.globl machine_check_exception_vector
machine_check_exception_vector:
//Copy PC to srr0
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Set new PC
mov w1, 0x200
str w1, [x0, pc]
//Copy MSR to srr1
ldr w1, [x0, msr]
str w1, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: mcheck_msr_mask
movk w2, :abs_g0_nc: mcheck_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

.globl dsi_exception_vector
dsi_exception_vector:
//Copy PC to srr0
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Set new PC
mov w1, 0x300
str w1, [x0, pc]
//Copy MSR to srr1
ldr w1, [x0, msr]
str w1, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

.globl isi_exception_vector
isi_exception_vector:
//Copy PC to srr0
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Set new PC
mov w1, 0x400
str w1, [x0, pc]
//Copy MSR to srr1
ldr w1, [x0, msr]
str w1, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

.globl exinterrupt_exception_vector
exinterrupt_exception_vector:
//Copy PC to srr0
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Set new PC
mov w1, 0x500
str w1, [x0, pc]
//Copy MSR to srr1
ldr w1, [x0, msr]
str w1, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

.globl alignment_exception_vector
alignment_exception_vector:
//Copy PC to srr0
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Set new PC
mov w1, 0x600
str w1, [x0, pc]
//Copy MSR to srr1
ldr w1, [x0, msr]
str w1, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

.globl program_exception_vector
program_exception_vector:
//Copy PC to srr0
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Set new PC
mov w1, 0x700
str w1, [x0, pc]
//Copy MSR to srr1
ldr w1, [x0, msr]
str w1, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

.globl fp_exception_vector
fp_exception_vector:
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Set new PC
mov w1, 0x800
str w1, [x0, pc]
//Copy MSR to srr1
ldr w1, [x0, msr]
str w1, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

.globl decrementer_exception_vector
decrementer_exception_vector:
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Set new PC
mov w1, 0x900
str w1, [x0, pc]
//Copy MSR to srr1
ldr w1, [x0, msr]
str w1, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

.globl syscall_exception_vector
syscall_exception_vector:
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Set new PC
mov w1, 0xC00
str w1, [x0, pc]
//Copy MSR to srr1
ldr w1, [x0, msr]
str w1, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

.globl trace_exception_vector
trace_exception_vector:
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Set new PC
mov w1, 0xD00
str w1, [x0, pc]
//Copy MSR to srr1
ldr w1, [x0, msr]
str w1, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

.globl pm_exception_vector
pm_exception_vector:
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Set new PC
mov w1, 0xF00
str w1, [x0, pc]
//Copy MSR to srr1
ldr w1, [x0, msr]
str w1, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

.globl iabr_exception_vector
iabr_exception_vector:
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Set new PC
mov w1, 0x1300
str w1, [x0, pc]
//Copy MSR to srr1
ldr w1, [x0, msr]
str w1, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret


.set reset_srr1, 0x87C0FFFF
.set mce_srr1, 0x0000FFFF //TODO implement code to output cause of machine check
.set dsi_srr1, 0x87C0FF73 //Can't find on Broadway manual, PPC PEM PDF says this is it. seems incorrect...
.set isi_srr1, 0x87C0FF73 //TODO NOT CORRECT
.set ee_srr1, 0x87C0FF73 //Can't find on Broadway manual, PPC PEM PDF says this is it. seems incorrect...
.set align_srr1, 0x87C0FF73 //Can't find on Broadway manual, PPC PEM PDF says this is it. seems incorrect...
.set program_srr1, 0x87C0FF73 //TODO NOT CORRECT
.set fp_srr1, 0x87C0FF73 //Can't find on Broadway manual, PPC PEM PDF says this is it. seems incorrect...
.set dec_srr1, 0x87C0FF73 //Can't find on Broadway manual, PPC PEM PDF says this is it. seems incorrect...
.set sc_srr1, 0x87C0FF73 //Can't find on Broadway manual, PPC PEM PDF says this is it. seems incorrect...
.set trace_srr1, 0x87C0FF73 //Can't find on Broadway manual, PPC PEM PDF says this is it. seems incorrect...
.set pm_srr1, 0x87C0FFFF
.set iabr_srr1, 0x87C0FFFF

.set allotherexceptions_msr_mask, msr_ile | msr_me | msr_ip //MSR mask for anything BUT machine check. NOTE there's no info on the mask for IABR in the broadway. best to assume its this.
.set mcheck_msr_mask, msr_ile | msr_ip

/*Exception priority list
System Reset = Hard Reset
Machine Check = Any Reason
System Reset = Soft Reset
External INT = External INT
Performance Monitor = Any Condition Met
Decrementer = Decrementer passes thru 0
ISI = Any Reason
IABR = Any Condition Met
Program = Illegal or Privileged Instruction, Trapping
System Call = sc instructin successfully executed
FP Unavailable = FP bit in MSR low
Program = FP enabled exception condition
DSI = eciwx & ecowx with EAR[E] = 0
Alignment...
    1st = FP load/store not word aligned
    2nd = lmw, stmw, lwarx, stwcx., not word aligned
    3rd = eciwx, ecowx not word aligned
    4th = multi or string load/store with MSR LE high
    5th = dbcz or dcbz_l to write-thru or cache-inh'd page or cache is disabled
DSI = Page fault (priority not explained in Broadway Manual, place it here)
DSI = BAT page protection violation
DSI = Direct Store Segment done
DSI = TLB page protection violation
DSI = DABR condition met
DSI = Paired Single instruction executed when HID4 LPE is high (unsure on priority, not explained in Broadway manual, place it here, or does this go under ISI????)
Trace = MSR SE high or MSR BE high for branches, fyi traces are impossible on isync, fyi instruction completes FIRST before trace exception is taken
*/

//void func
.globl reset_exception_vector
reset_exception_vector:
stp fp, lr, [sp, -0x10]!
mov fp, sp
//Copy PC to srr0
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Check IP bit of msr
ldr w1, [x0, msr]
tst w1, msr_ip
bne 0xC
mov w2, 0
b 0x8
//Set High Exception Bits
movz w2, 0xFFF0, lsl 16
//OR in new PC
orr w2, w2, 0x100
str w2, [x0, pc]
//Copy certain MSR bits to srr1, rest is cleared
movz w2, :abs_g1: reset_srr1
movk w2, :abs_g0_nc: reset_srr1
and w3, w1, w2 //keep certain bits, rest are cleared
//For now (TODO), lets hard clear the RI bit for srr1 (not recoverable; aka hard reset)
bfc w3, 1, 1 //Clear big endian bit 30 (le bit 1)
str w3, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
//Do a hard reset
bl hardreset
ldp fp, lr, [sp], 0x10
ret

//void func
.globl machine_check_exception_vector
machine_check_exception_vector:
//Is ME high on MSR?
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, msr]
tst w1, msr_me
beq do_checkstop
//Check EMCP bit of HID0 (bit0), TODO put in code to check other hID0 relative bits
ldr w1, [x0, hid0]
tst w1, hid0_emcp
beq 0xC
//Do a Checkstop, write hacky checkstop flag
do_checkstop:
mov w0, -1
strb w0, [x27, 0x8]
ret
//Copy PC to srr0
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Check IP bit of msr
ldr w1, [x0, msr]
tst w1, msr_ip
bne 0xC
mov w2, 0
b 0x8
//Set High Exception Bits
movz w2, 0xFFF0, lsl 16
//OR in new PC
orr w2, w2, 0x100
str w2, [x0, pc]
//Copy certain MSR bits to srr1, rest is cleared
movz w2, mce_srr1
and w3, w1, w2 //keep certain bits, rest are cleared
//TODO, put in code to place in cause of the Machine Check
str w3, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: mcheck_msr_mask
movk w2, :abs_g0_nc: mcheck_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

//w0 = EA
.globl dsi_exception_vector
dsi_exception_vector:
stp fp, lr, [sp, -0x10]!
mov fp, sp
//Copy EA (w0) to DAR
ldr x1, [x27, 0x20] //get reg bank ptr
str w0, [x1, dar]
//Copy PC to srr0
ldr w0, [x1, pc]
str w0, [x1, srr0]
//Check IP bit of msr
ldr w0, [x1, msr]
tst w0, msr_ip
bne 0xC
mov w2, 0
b 0x8
//Set High Exception Bits
movz w2, 0xFFF0, lsl 16
//OR in new PC
orr w2, w2, 0x100
str w2, [x1, pc]
//Copy certain MSR bits to srr1, rest is cleared
movz w2, :abs_g1: dsi_srr1
movk w2, :abs_g0_nc: dsi_srr1
and w3, w0, w2 //keep certain bits, rest are cleared
str w3, [x1, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w0, w0, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w0, 16, 1
bfi w0, w2, 0, 1
str w0, [x1, msr]
ldp fp, lr, [sp], 0x10
ret

//w0 = EA
.globl isi_exception_vector
isi_exception_vector:
//Copy PC to srr0
ldr x1, [x27, 0x20] //get reg bank ptr
ldr w0, [x1, pc]
str w0, [x1, srr0]
//Check IP bit of msr
ldr w0, [x1, msr]
tst w0, msr_ip
bne 0xC
mov w2, 0
b 0x8
//Set High Exception Bits
movz w2, 0xFFF0, lsl 16
//OR in new PC
orr w2, w2, 0x100
str w2, [x1, pc]
//Copy certain MSR bits to srr1, rest is cleared
movz w2, :abs_g1: isi_srr1
movk w2, :abs_g0_nc: isi_srr1
and w3, w0, w2 //keep certain bits, rest are cleared
str w3, [x1, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w0, w0, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w0, 16, 1
bfi w0, w2, 0, 1
str w0, [x1, msr]
ret

//void func
.globl exinterrupt_exception_vector
exinterrupt_exception_vector:
//Copy PC to srr0
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Check IP bit of msr
ldr w1, [x0, msr]
tst w1, msr_ip
bne 0xC
mov w2, 0
b 0x8
//Set High Exception Bits
movz w2, 0xFFF0, lsl 16
//OR in new PC
orr w2, w2, 0x100
str w2, [x0, pc]
//Copy certain MSR bits to srr1, rest is cleared
movz w2, :abs_g1: ee_srr1
movk w2, :abs_g0_nc: ee_srr1
and w3, w1, w2 //keep certain bits, rest are cleared
str w3, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

//w0 = EA
.globl alignment_exception_vector
alignment_exception_vector:
//Copy PC to srr0
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Check IP bit of msr
ldr w1, [x0, msr]
tst w1, msr_ip
bne 0xC
mov w2, 0
b 0x8
//Set High Exception Bits
movz w2, 0xFFF0, lsl 16
//OR in new PC
orr w2, w2, 0x100
str w2, [x0, pc]
//Copy certain MSR bits to srr1, rest is cleared
movz w2, :abs_g1: align_srr1
movk w2, :abs_g0_nc: align_srr1
and w3, w1, w2 //keep certain bits, rest are cleared
str w3, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

//void func
.globl program_exception_vector
program_exception_vector:
//Copy PC to srr0
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Check IP bit of msr
ldr w1, [x0, msr]
tst w1, msr_ip
bne 0xC
mov w2, 0
b 0x8
//Set High Exception Bits
movz w2, 0xFFF0, lsl 16
//OR in new PC
orr w2, w2, 0x100
str w2, [x0, pc]
//Copy certain MSR bits to srr1, rest is cleared
movz w2, :abs_g1: program_srr1
movk w2, :abs_g0_nc: program_srr1
and w3, w1, w2 //keep certain bits, rest are cleared
str w3, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

//void func
.globl fp_exception_vector
fp_exception_vector:
//Copy PC to srr0
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Check IP bit of msr
ldr w1, [x0, msr]
tst w1, msr_ip
bne 0xC
mov w2, 0
b 0x8
//Set High Exception Bits
movz w2, 0xFFF0, lsl 16
//OR in new PC
orr w2, w2, 0x100
str w2, [x0, pc]
//Copy certain MSR bits to srr1, rest is cleared
movz w2, :abs_g1: fp_srr1
movk w2, :abs_g0_nc: fp_srr1
and w3, w1, w2 //keep certain bits, rest are cleared
str w3, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

//void func
.globl decrementer_exception_vector
decrementer_exception_vector:
//Copy PC to srr0
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Check IP bit of msr
ldr w1, [x0, msr]
tst w1, msr_ip
bne 0xC
mov w2, 0
b 0x8
//Set High Exception Bits
movz w2, 0xFFF0, lsl 16
//OR in new PC
orr w2, w2, 0x100
str w2, [x0, pc]
//Copy certain MSR bits to srr1, rest is cleared
movz w2, :abs_g1: dec_srr1
movk w2, :abs_g0_nc: dec_srr1
and w3, w1, w2 //keep certain bits, rest are cleared
str w3, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

//void func
.globl syscall_exception_vector
syscall_exception_vector:
//Copy PC to srr0
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Check IP bit of msr
ldr w1, [x0, msr]
tst w1, msr_ip
bne 0xC
mov w2, 0
b 0x8
//Set High Exception Bits
movz w2, 0xFFF0, lsl 16
//OR in new PC
orr w2, w2, 0x100
str w2, [x0, pc]
//Copy certain MSR bits to srr1, rest is cleared
movz w2, :abs_g1: sc_srr1
movk w2, :abs_g0_nc: sc_srr1
and w3, w1, w2 //keep certain bits, rest are cleared
str w3, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

//void func
.globl trace_exception_vector
trace_exception_vector:
//Copy PC to srr0
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Check IP bit of msr
ldr w1, [x0, msr]
tst w1, msr_ip
bne 0xC
mov w2, 0
b 0x8
//Set High Exception Bits
movz w2, 0xFFF0, lsl 16
//OR in new PC
orr w2, w2, 0x100
str w2, [x0, pc]
//Copy certain MSR bits to srr1, rest is cleared
movz w2, :abs_g1: trace_srr1
movk w2, :abs_g0_nc: trace_srr1
and w3, w1, w2 //keep certain bits, rest are cleared
str w3, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

//void func
.globl pm_exception_vector
pm_exception_vector:
//Copy PC to srr0
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Check IP bit of msr
ldr w1, [x0, msr]
tst w1, msr_ip
bne 0xC
mov w2, 0
b 0x8
//Set High Exception Bits
movz w2, 0xFFF0, lsl 16
//OR in new PC
orr w2, w2, 0x100
str w2, [x0, pc]
//Copy certain MSR bits to srr1, rest is cleared
movz w2, :abs_g1: pm_srr1
movk w2, :abs_g0_nc: pm_srr1
and w3, w1, w2 //keep certain bits, rest are cleared
str w3, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

//void func
.globl iabr_exception_vector
iabr_exception_vector:
//Copy PC to srr0
ldr x0, [x27, 0x20] //get reg bank ptr
ldr w1, [x0, pc]
str w1, [x0, srr0]
//Check IP bit of msr
ldr w1, [x0, msr]
tst w1, msr_ip
bne 0xC
mov w2, 0
b 0x8
//Set High Exception Bits
movz w2, 0xFFF0, lsl 16
//OR in new PC
orr w2, w2, 0x100
str w2, [x0, pc]
//Copy certain MSR bits to srr1, rest is cleared
movz w2, :abs_g1: iabr_srr1
movk w2, :abs_g0_nc: iabr_srr1
and w3, w1, w2 //keep certain bits, rest are cleared
str w3, [x0, srr1]
//Set new MSR
movz w2, :abs_g1: allotherexceptions_msr_mask
movk w2, :abs_g0_nc: allotherexceptions_msr_mask
and w1, w1, w2
//ILE bit is copied to LE slot in any exception
ubfx w2, w1, 16, 1
bfi w1, w2, 0, 1
str w1, [x0, msr]
ret

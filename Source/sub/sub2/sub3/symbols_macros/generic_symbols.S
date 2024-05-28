/*Sizes for every thing*/
.set regbanksize, 0x344
.set mem1bytesize, 0x01800000
.set mem2bytesize, 0x04000000
.set arttxtsize, 0x3000
.set memtxtrowsize, 0x39
.set memtxtrows, (mem1bytesize + mem2bytesize) / 16 /*Exclude title row*/
.set memtxtbytesize, (memtxtrows * memtxtrowsize) + memtxtrowsize /*Calc size and add in title row*/
.set ip_memsize, 0x40 /*Max size for boot.bin*/
.set bat_size, 8
.set PLRU_masks_size, 16
.set grand_total_malloc, regbanksize + mem1bytesize + mem2bytesize + arttxtsize + memtxtbytesize + Total_Cache_everything + ip_memsize + bat_size + PLRU_masks_size

/*Offsets relative to Array Pointer*/
.set bootbin_ptr, 0x0
.set checkstop_flag, 0x8
.set load_flag, 0x9
.set store_flag, 0xA
.set touch_flag, 0xB
.set bootbin_size, 0xC //Because size can only 32-bits in width
.set bootdol_ptr, 0x10
.set bootdol_size, 0x1C //Because size can only 32-bits in width
.set regbank_ptr, 0x20
.set mem1_ptr, 0x28
.set mem2_ptr, 0x30
.set artemistxt_ptr, 0x38
.set memtxt_ptr, 0x40
.set L1_DCache_ptr, 0x48
.set L1_ICache_ptr, 0x50
.set L2_DCache_ptr, 0x58
.set L2_ICache_ptr, 0x60
.set batsave_ptr, 0x68
.set PLRU_masks_ptr, 0x70

/*PPC Physical Addresses*/
.set mem1_base, 0
.set mem1_top, 0x017FFFFF
.set mem2_base, 0x10000000
.set mem2_top, 0x13FFFFFF
.set ip_base, 0xFFF00100
.set ip_top, 0xFFF0013F


/*Calc size for entire stack push*/
.set array_ptrs_size, PLRU_masks_ptr + 8
.set main_stack_buffer_size, array_ptrs_size + 24 /*Another 24 bytes for fp, lr, and x27 storage*/

/*Useful macros for prologues and epilogues*/
/*NOTE currently unused*/
/*The 2 Macros always starts the buffer space ptr at (sp + 0x10)*/
/*regs is for GPRs only*/
.macro prologue regs, buffer
        .if      (\regs < 0 || \regs > 10)
                .error "Error! Too many non-volatile registers used or a negative amount was used!"
        .endif

        .if      (\buffer < 0)
                .error "Error! Buffer size is negative!"
        .endif

        .set stacksize, (\regs << 3) + \buffer + 16
        .set alignsize, stacksize & 0xF

        .if (alignsize != 0)
                .error "Error! Buffer size is not 16-byte aligned!"
        .endif

        stp fp, lr, [sp, -stacksize]!
        .if     (\regs == 0)
                mov fp, sp
                .exitm
        .elseif     (\regs == 1)
                str x19, [sp, stacksize - 8]
        .elseif (\regs == 2)
                stp x19, x20, [sp, stacksize - 16]
        .elseif (\regs == 3)
                stp x19, x20, [sp, stacksize - 24]
                str x21, [sp, stacksize - 8]
        .elseif (\regs == 4)
                stp x19, x20, [sp, stacksize - 32]
                stp x21, x22, [sp, stacksize - 16]
        .elseif (\regs == 5)
                stp x19, x20, [sp, stacksize - 40]
                stp x21, x22, [sp, stacksize - 24]
                str x23, [sp, stacksize - 8]
        .elseif (\regs == 6)
                stp x19, x20, [sp, stacksize - 48]
                stp x21, x22, [sp, stacksize - 32]
                stp x23, x24, [sp, stacksize - 16]
        .elseif (\regs == 7)
                stp x19, x20, [sp, stacksize - 56]
                stp x21, x22, [sp, stacksize - 40]
                stp x23, x24, [sp, stacksize - 24]
                str x25, [sp, stacksize - 8]
        .elseif (\regs == 8)
                stp x19, x20, [sp, stacksize - 64]
                stp x21, x22, [sp, stacksize - 48]
                stp x23, x24, [sp, stacksize - 32]
                stp x25, x26, [sp, stacksize - 16]
        .elseif (\regs == 9)
                stp x19, x20, [sp, stacksize - 72]
                stp x21, x22, [sp, stacksize - 56]
                stp x23, x24, [sp, stacksize - 40]
                stp x25, x26, [sp, stacksize - 24]
                str x27, [sp, stacksize - 8]
        .else
                stp x19, x20, [sp, stacksize - 80]
                stp x21, x22, [sp, stacksize - 64]
                stp x23, x24, [sp, stacksize - 48]
                stp x25, x26, [sp, stacksize - 32]
                stp x27, x28, [sp, stacksize - 16]
        .endif
        mov fp, sp
.endm

.macro epilogue regs, buffer
        .if      (\regs < 0 || \regs > 10)
                .error "Error! Too many non-volatile registers used or a negative amount was used!"
        .endif

        .if      (\buffer < 0)
                .error "Error! Buffer size is negative!"
        .endif

        .set stacksize, (\regs << 3) + \buffer + 16
        .set alignsize, stacksize & 0xF

        .if (alignsize != 0)
                .error "Error! Buffer size is not 16-byte aligned!"
        .endif

        .if     (\regs == 0)
                ldp fp, lr, [sp], stacksize
                ret
                .exitm
        .elseif     (\regs == 1)
                ldr x19, [sp, stacksize - 8]
        .elseif (regs == 2)
                ldp x19, x20, [sp stacksize - 16]
        .elseif (\regs == 3)
                ldr x21, [sp, stacksize - 8]
                ldp x19, x20, [sp stacksize - 24]
        .elseif (\regs == 4)
                ldp x21, x22, [sp, stacksize - 16]
                ldp x19, x20, [sp, stacksize - 32]
        .elseif (\regs == 5)
                ldr x22, [sp, stacksize - 8]
                ldp x21, x22, [sp, stacksize - 24]
                ldp x19, x20, [sp, stacksize - 40]
        .elseif (\regs == 6)
                ldp x22, x23, [sp, stacksize - 16]
                ldp x21, x22, [sp, stacksize - 32]
                ldp x19, x20, [sp, stacksize - 48]
        .elseif (\regs == 7)
                ldr x24, [sp, stacksize - 8]
                ldp x22, x23, [sp, stacksize - 24]
                ldp x21, x22, [sp, stacksize - 40]
                ldp x19, x20, [sp, stacksize - 56]
        .elseif (\regs == 8)
                ldp x24, x25, [sp, stacksize - 16]
                ldp x22, x23, [sp, stacksize - 32]
                ldp x21, x22, [sp, stacksize - 48]
                ldp x19, x20, [sp, stacksize - 64]
        .elseif (\regs == 9)
                ldr x26, [sp, stacksize - 8]
                ldp x24, x25, [sp, stacksize - 24]
                ldp x22, x23, [sp, stacksize - 40]
                ldp x21, x22, [sp, stacksize - 56]
                ldp x19, x20, [sp, stacksize - 72]
        .else
                ldp x26, x27, [sp, stacksize - 16]
                ldp x24, x25, [sp, stacksize - 32]
                ldp x22, x23, [sp, stacksize - 48]
                ldp x21, x22, [sp, stacksize - 64]
                ldp x19, x20, [sp, stacksize - 80]
        .endif
        ldp fp, lr, [sp], stacksize
        ret
.endm

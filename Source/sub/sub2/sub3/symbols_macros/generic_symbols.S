.set regbanksize, 0x344
.set mem1bytesize, 0x01800000
.set mem2bytesize, 0x04000000
.set arttxtsize, 0x3000
.set memtxtrowsize, 0x39
.set memtxtrows, (mem1bytesize + mem2bytesize) / 16 /*Exclude title row*/
.set memtxtbytesize, (memtxtrows * memtxtrowsize) + memtxtrowsize /*Calc size and add in title row*/
.set grand_total_malloc, regbanksize + mem1bytesize + mem2bytesize + arttxtsize + memtxtbytesize + Total_Cache_byte_size + Total_Cache_word_size

//Offsets relative to Array Pointer
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
.set L1_ins_ptr, 0x48
.set L1_data_ptr, 0x50
.set L2_ptr, 0x58
.set roundrobin_ptr, 0x60

.set mem1_base, 0
.set mem1_top, 0x017FFFFF
.set mem2_base, 0x10000000
.set mem2_top, 0x13FFFFFF

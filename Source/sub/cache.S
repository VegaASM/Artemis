.set DCache_byte_size, 0x8000 /*32768*/
.set ICache_byte_size, 0x8000 /*32768*/
.set L2Cache_byte_size, 0x40000 /*262144*/
.set Total_Cache_byte_size, DCache_byte_size + ICache_byte_size + L2Cache_byte_size
.set quadword_byte_size, 128
.set DCache_loop_count, 256
.set ICache_loop_count, 256
.set L2Cache_loop_count, 2048
.set Cache_loop_count, DCache_loop_count + ICache_loop_count + L2Cache_loop_count

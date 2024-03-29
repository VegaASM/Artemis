.set DCache_byte_size, 0x8000 /*32768*/
.set ICache_byte_size, 0x8000 /*32768*/
.set L2Cache_byte_size, 0x40000 /*262144*/
.set Total_Cache_byte_size, DCache_byte_size + ICache_byte_size + L2Cache_byte_size
.set Total_Cache_word_size, Total_Cache_byte_size / 4


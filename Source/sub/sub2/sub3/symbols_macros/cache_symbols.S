.set DCache_byte_size, 0x8000 /*32768*/
.set ICache_byte_size, 0x8000 /*32768*/
.set L2Cache_byte_size, 0x40000 /*262144*/
.set Total_Cache_byte_size, DCache_byte_size + ICache_byte_size + L2Cache_byte_size
.set Total_Cache_word_size, Total_Cache_byte_size >> 2
.set DCache_word_size, DCache_byte_size >> 2
.set ICache_word_size, ICache_byte_size >> 2
.set L2Cache_word_size, L2Cache_byte_size >> 2
.set TMEI_T, 0b1000
.set TMEI_M, 0b0100
.set TMEI_E, 0b0010
.set TMEI_I, 0b0001


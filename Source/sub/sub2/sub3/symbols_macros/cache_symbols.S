/*Below 4 times not needed, keep just in case for future use*/
.set L1_DCache_byte_size, 0x8000 /*32768*/
.set L1_ICache_byte_size, 0x8000 /*32768*/
.set L2_Cache_byte_size, 0x40000 /*262144*/
.set Total_Cache_byte_size, 0x8000 + 0x8000 + 0x40000

/*Custom Cache (L1 way) layout
XXXXXXXX PA (last 4 bits are LMEI)
XX PLRU byte (first bit is ignored; bytes for ways 1 thru 7 are ignored TODO fix this unused space!)
XXXXXXXX (x8) Cache Block
*/

.set L1_way_size, 37 /*Width of every Way in bytes*/
.set L1_set_size, 37 * 8 /*Byte Size of a Set*/
.set L1_ICache_size, L1_set_size << 7 /*Set size times 128*/
.set L1_DCache_size, L1_ICache_size

/*Custom L2 Cache Tag/Block/Line Layout
XXXXXXXX PA (last 3 bits are MEI)
XXXXXXXX (x16) Cache Block
*/

.set L2_block_size, 68
.set L2_DCache_size, L2_block_size << 11 /*Times 2,048 ways. Ways are way (lol) diff in L2 than L1*/
.set L2_ICache_size, L2_DCache_size
.set L2_Cache_size, L2_DCache_size + L2_ICache_size

.set Total_Cache_everything, L1_DCache_size + L2_Cache_size

/*Following is for cache loop iterations*/
.set L1_DCache_entries, 1024
.set L1_ICache_entries, 1024
.set L2_DCache_entries, 4096
.set L2_ICache_entries, 4096

/*PA final 5 bits
L = Locked (only applicable to L1 Cache)
MEI = MEI protocol (For I-Cache, low I = high V)
*/
.set LMEI_L, 0b01000
.set LMEI_M, 0b00100
.set LMEI_E, 0b00010
.set LMEI_I, 0b00001

/*Masks use to start the reset a PLRU byte*/
.set LX_masks_bit_clear, 0x6868646452525151 /*Each byte is a mask*/

/*Masks use to finish the reset of a PLRU Byte*/
.set LX_masks_bit_set, 0x6860646012100100 /*Each byte is a mask*/

/*PLRU bits*/
.set PLRU_B0, 0x40
.set PLRU_B1, 0x20
.set PLRU_B2, 0x10
.set PLRU_B3, 0x08
.set PLRU_B4, 0x04
.set PLRU_B5, 0x02
.set PLRU_B6, 0x01

.set L1_DCache_byte_size, 0x8000 /*32768*/
.set L1_ICache_byte_size, 0x8000 /*32768*/
.set L2_Cache_byte_size, 0x40000 /*262144*/
.set Total_Cache_byte_size, 0x8000 + 0x8000 + 0x40000

.set L1_data_number_entries, L1_DCache_byte_size >> 5 /*Divide by 32 aka 0x20*/
.set L1_ins_number_entries, L1_ICache_byte_size >> 5 /*Divide by 32 aka 0x20*/
.set L2_data_number_entries, [(L2_Cache_byte_size >> 1) >> 5] /*Cut L2 data entries in half, then divide by 32*/
.set L2_ins_number_entries, [(L2_Cache_byte_size >> 1) >> 5] /*Cut L2 ins entries in half, then divide by 32*/
.set Total_Cache_entries, Total_Cache_byte_size >> 5 /*Divide by 32*/

.set cache_entry_width, 16 /*Word:PPC PA-32, Double-Word:Real Mem Addr, Word:Entry No.*/

.set L1_data_number_entries_size, L1_data_number_entries * cache_entry_width
.set L1_ins_number_entries_size, L1_ins_number_entries * cache_entry_width
.set L2_data_number_entries_size, L2_data_number_entries * cache_entry_width
.set L2_ins_number_entries_size, L2_ins_number_entries * cache_entry_width

.set Total_Cache_entry_list_size, Total_Cache_entries * cache_entry_width

.set Total_Cache_everything, Total_Cache_byte_size + Total_Cache_entry_list_size

/*PA final 5 bits
L = Locked (only applicable to L1 Cache)
T = Type (High = Data, Low = Ins, need this if L2 L2DO is low)
MEI = MEI protocol (For I-Cache, low I = high V)
*/
.set LTMEI_L, 0b10000
.set LTMEI_T, 0b01000
.set LTMEI_M, 0b00100
.set LTMEI_E, 0b00010
.set LTMEI_I, 0b00001

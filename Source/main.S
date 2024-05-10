.arch armv8.2-a /*To allow the bfc instruction*/

#include "sub/sub2/sub3/symbols_macros/generic_symbols.S"
#include "sub/sub2/sub3/symbols_macros/cache_symbols.S"
#include "dump_bootbin.S"
#include "dump_bootdol.S"
#include "insert_bootdol.S"
#include "insert_bootbin.S"
#include "hardreset.S"
#include "sub/submain.S"

pleasewaittxt:
.asciz "Please wait...\n"
mainmallocmemEC:
.asciz "Error! Can't allocate memory for all the important stuff! :("
.align 2

.section .text
.globl main
main:
/*Prologue*/
stp fp, lr, [sp, -(main_stack_buffer_size)]! /*0x18 thru 0x8F = Array Table; 0x90+ = IP memory*/
str x27, [sp, 0x10]
mov fp, sp

/*First message*/
adr x0, pleasewaittxt
bl puts

/*Use allocated stack space for Array Table*/
add x27, sp, 0x18

/*Malloc for everything*/
movz w0, :abs_g1: grand_total_malloc
movk w0, :abs_g0_nc: grand_total_malloc
bl malloc
cbz x0, cant_alloc_mainmemory

/*Store all ptr's*/
str x0, [x27, regbank_ptr]
add x1, x0, regbanksize
str x1, [x27, mem1_ptr]
movz w0, :abs_g1: mem1bytesize
add x1, x1, x0
str x1, [x27, mem2_ptr]
movz w0, :abs_g1: mem2bytesize
add x1, x1, x0
str x1, [x27, artemistxt_ptr]
add x1, x1, arttxtsize
str x1, [x27, memtxt_ptr]
movz w0, :abs_g1: memtxtbytesize
movk w0, :abs_g0_nc: memtxtbytesize
add x1, x1, x0
str x1, [x27, L1_data_ptr]
add x1, x1, L1_DCache_byte_size
str x1, [x27, L1_ins_ptr]
add x1, x1, L1_ICache_byte_size
str x1, [x27, L2_data_ptr]
add x1, x1, (L2_Cache_byte_size >> 1)
str x1, [x27, L2_ins_ptr]
add x1, x1, (L2_Cache_byte_size >> 1)
str x1, [x27, L1_data_entries_ptr]
add x1, x1, L1_data_number_entries_size
str x1, [x27, L1_ins_entries_ptr]
add x1, x1, L1_ins_number_entries_size
str x1, [x27, L2_data_entries_ptr]
add x1, x1, L2_data_number_entries_size
str x1, [x27, L2_ins_entries_ptr]
add x1, x1, L1_data_number_entries_size
str x1, [x27, batsave_ptr]

add x0, sp, (main_stack_buffer_size - ip_size)
str x0, [x27, bootbin_ptr] /*IP mem pointer*/

/*Get boot.bin contents*/
bl dump_bootbin
cbnz x0, output_console

/*Get boot.dol contents*/
bl dump_bootdol
cbnz x0, output_console

/*Attempt to place the boot.dol into simulated mem1*/
bl insert_bootdol
cbnz x0, output_console

/*Place boot.bin into simulated reset vector*/
bl insert_bootbin

/*Do a hard reset*/
bl hardreset /*Does *NOT* return an error, always works*/

/*Call submain (void)*/
bl submain

/*Error/Output Hander*/
output_console:
bl puts
/*Free allocated memory*/
ldr x0, [x27, 0x20]
bl free
b epilogue_main

/*Error/Output Handler that doesn't free anything*/
cant_alloc_mainmemory:
bl puts

/*Epilogue, exit program*/
epilogue_main:
mov w0, 0
ldr x27, [sp, 0x10]
ldp fp, lr, [sp], 0xC0
ret

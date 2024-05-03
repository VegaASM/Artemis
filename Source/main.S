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
stp fp, lr, [sp, -0xC0]! /*0x10 thru 0x7F = Array Table; 0x80 thru BF = IP memory*/
mov fp, sp

/*First message*/
adr x0, pleasewaittxt
bl puts

/*Use allocated stack space for Array Table*/
add x27, sp, 0x10

/*Malloc for everything*/
movz w0, :abs_g1: grand_total_malloc
movk w0, :abs_g0_nc: grand_total_malloc
bl malloc
cbz x0, cant_alloc_mainmemory

/*Store all ptr's*/
str x0, [x27, regbank_ptr] /*reg bank ptr*/
add x1, x0, regbanksize
str x1, [x27, mem1_ptr] /*mem1 ptr*/
movz w0, :abs_g1: mem1bytesize
add x1, x1, x0
str x1, [x27, mem2_ptr] /*mem2 ptr*/
movz w0, :abs_g1: mem2bytesize
add x1, x1, x0
str x1, [x27, artemistxt_ptr] /*artemis.txt ptr*/
add x1, x1, arttxtsize
str x1, [x27, memtxt_ptr] /*memory.txt ptr*/
movz w0, :abs_g1: memtxtbytesize
movk w0, :abs_g0_nc: memtxtbytesize
add x1, x1, x0
str x1, [x27, L1_ins_ptr] /*L1 ICache table ptr*/
add x1, x1, ICache_byte_size
str x1, [x27, L1_data_ptr] /*L1 DCache table ptr*/
add x1, x1, DCache_byte_size
str x1, [x27, L2_ptr] /*L2 Cache table ptr*/
add x0, sp, 0x80
str x0, [x27, bootbin_ptr] /*IP mem pointer*/

/*Get boot.bin contents*/
bl dump_bootbin
cbnz x0, output_console

/*Get boot.dol contents*/
bl dump_bootdol
cbnz x0, output_console

/*SKIPPED FOR NOW*/
/*Memset mem1 and mem2
Write in custom inline style to save time*/
/*ldr x0, [x27, 0x20]
movi d0, 0
movi d1, 0
mov w2, mem1bytesize + mem2bytesize
stp q0, q1, [x0], 0x20
subs w2, w2, 0x20
bne -0x8*/

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
ldp fp, lr, [sp], 0xC0
ret

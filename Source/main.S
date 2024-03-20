.arch armv8.2-a /*To allow the bfc instruction*/

#include "sub/submain.S"
#include "dump_bootbin.S"
#include "dump_bootdol.S"
#include "hardreset.S"
#include "insert_bootdol.S"

pleasewaittxt:
.asciz "Please wait...\n"
mainmallocmemEC:
.asciz "Error! Can't allocate memory for all the important stuff! :("
.align 2

.section .text
.globl main
main:
/*Prologue*/
stp fp, lr, [sp, -0x70]! /*Create 0x60 space for Array Table*/
mov fp, sp

/*First message*/
adr x0, pleasewaittxt
bl puts

/*Use allocated stack space for Array Table*/
add x27, sp, 0x10

/*Malloc for everything*/
.set regbanksize, 0x344
.set mem1bytesize, 0x01800000
.set mem2bytesize, 0x04000000
.set arttxtsize, 0x3000
.set memtxtrowsize, 0x39
.set memtxtrows, (mem1bytesize + mem2bytesize) / 16 /*Exclude title row*/
.set memtxtbytesize, (memtxtrows * memtxtrowsize) + memtxtrowsize /*Calc size and add in title row*/
.set grand_total_malloc, regbanksize + mem1bytesize + mem2bytesize + arttxtsize + memtxtbytesize
movz w0, :abs_g1: grand_total_malloc
movk w0, :abs_g0_nc: grand_total_malloc
bl malloc
cbz x0, cant_alloc_mainmemory

/*Store Reg ptr, Mem1 ptr, Mem2 ptr, Artemis.txt, and memory.txt ptr*/
str x0, [x27, 0x20]
add x1, x0, regbanksize
str x1, [x27, 0x28]
movz w0, :abs_g1: mem1bytesize
add x1, x1, x0
str x1, [x27, 0x30]
movz w0, :abs_g1: mem2bytesize
add x1, x1, x0
str x1, [x27, 0x38]
add x1, x1, arttxtsize
str x1, [x27, 0x40]

/*SKIPPED FOR NOW...Dump boot.bin contents to memory*/
/*bl dump_bootbin
cbnz x0, output_console*/

/*Dump boot.dol contents to memory*/
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

/*Do a hard reset*/
bl hardreset /*Does *NOT* return an error, always works*/

/*Attempt to place the boot.dol into simulated mem1
x0 arg = ptr to boot.dol*/
ldr x0, [x27, 0x10]
bl insert_bootdol
cbnz x0, output_console

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
ldp fp, lr, [sp], 0x70
ret

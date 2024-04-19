#include "sub3/sub4/convertWordInt2ASCII.S"
#include "sub3/sub4/convertByteInt2ASCII.S"
/*TODO put in code to seek and write only responsible changes after a store instruction instead of doing fwrite on ENTIRE file*/

memtxt1stline:
.xword 0x2020202020202020
.byte 0x20
.ascii "00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F\n" /*Use asciI, not asciZ. Do NOT append Null byte!*/
memtxtfilename:
.asciz "www/memory.txt"
memtxtperms:
.asciz "wb"
memtxtfopenEC_string:
.asciz "Error! Unable to create new memory.txt."
fwritememtxtEC_string:
.asciz "Error! Can't write data for memory.txt"
.align 2

.globl write_memory_txt
write_memory_txt:
/*Prologue*/
stp fp, lr, [sp, -0x50]!
stp x19, x20, [sp, 0x10]
stp x21, x22, [sp, 0x20]
stp x23, x24, [sp, 0x30]
str x25, [sp, 0x40]
mov fp, sp

/*Open memory.txt with write permissions*/
adr x0, memtxtfilename
adr x1, memtxtperms
bl fopen
cbz x0, memtxtfopenEC
mov x19, x0

/*Grab mem.txt contents ptr from array*/
ldr x20, [x27, memtxt_ptr]
mov x0, x20

/*Very first line of memory.txt file*/
/*TODO make this more efficient, no sense for hardcoded byte transfer*/
adr x21, memtxt1stline
mov w1, memtxtfilename - memtxt1stline
ldrb w2, [x21], 1
strb w2, [x0], 1
subs w1, w1, 1
bne -0xC

/*Write every address 16-byte aligned row value for mem1*/
mov w21, 0xFFFFFFF0
mov w22, 0x180000 /*0x01800000 / 0x10*/
mov x23, x0 /*Move cursor to non-volatile*/
add w21, w21, 0x10
mov w0, w21
bl convertWordInt2ASCII /*w0 = arg, x0 = return*/
subs w22, w22, 1
rev x0, x0
str x0, [x23], 0x39
bne -0x18

/*Write every address 16-byte aligned row value for mem2*/
mov w21, 0x0FFFFFF0
mov w22, 0x400000 /*0x04000000 / 10*/
add w21, w21, 0x10
mov w0, w21
bl convertWordInt2ASCII
subs w22, w22, 1
rev x0, x0
str x0, [x23], 0x39
bne -0x18

/*Load every byte from simulated memory, convert to halfword length total ascii, write to memory.txt*/
/*mem1 and mem2 are concatenated together, so we can run loop straight thru*/
/*Every 16 halfword ascii's store, remember to increment cursor extra 0x9 to go down to next row*/
add x21, x20, 0x42 /*Move cursor to to where it needs to start at*/
mov w22, (0x1800000 + 0x4000000) /*Byte size of both mem's*/
ldr x23, [x27, 0x28] /*Get real mem1 ptr*/
mov w24, 16
ldrb w0, [x23], 1
bl convertByteInt2ASCII
rev16 w0, w0
subs w24, w24, 1
beq 0xC
strh w0, [x21], 3
b 0xC
strh w0, [x21], 0xC
mov w24, 16 /*Reset counter for next row*/
subs w22, w22, 1
bne -0x28

/*Store all spaces & enters after title row*/
add x21, x20, 0x41
mov w22, 0x580000 /*Amount of rows (excluding title row*/
mov w24, 0x20 /*space*/
mov w25, 0xA /*enter*/
mov w23, 16
strb w24, [x21], 3
subs w23, w23, 1 /*Write 16 spaces*/
bne -0x8
strb w25, [x21], 9 /*Write the enter and update cursor to next space spot in below row*/
subs w22, w22, 1
bne -0x18

/*Contents for memory.txt fully updated. WRITE memory.txt!*/
mov x0, x20
mov w1, 1
movz w21, 0x1398, lsl 16
movk w21, 0x0039
mov w2, w21
mov x3, x19
bl fwrite
cmp w0, w21
bne fwritememtxtEC

/*close it*/
mov x0, x19
bl fclose /*no point EC'ing this tbh*/

/*Sucess*/
mov w0, 0 /*Might be best to remove this cuz fclose should always work, but just in case.....*/
b memtxt_epilogue

fwritememtxtEC:
adr x0, fwritememtxtEC_string
b memtxt_epilogue

memtxtfopenEC:
adr x0, memtxtfopenEC_string

/*Epilogue*/
memtxt_epilogue:
ldr x25, [sp, 0x40]
ldp x23, x24, [sp, 0x30]
ldp x21, x22, [sp, 0x20]
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x50
ret

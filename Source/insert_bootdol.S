#include "sub/sub2/global/convert.S"
/*#include "sub/sub2/global/registerbankmap.S" Already in hardreset.S*/

/*
x0 = boot.dol pointer
x0 returns 0 = success
x0 returns insertdolEC ptr for error
*/

/*
x27 Array contents
0x0 = Boot.bin pointer
0x8 = boot.bin size; unsigned
0x10 = Boot.dol pointer
0x18 = boot.dol size; unsigned
0x20 = Register Table ptr
0x28 = Mem1 ptr
0x30 = Mem2 ptr
*/

insertdolEC:
.asciz "Error! Invalid entry point found in the boot.dol!"
.align 2

.globl insert_bootdol
insert_bootdol:
/*Prologue*/
stp fp, lr, [sp, -0x40]!
stp x19, x20, [sp, 0x10]
stp x21, x22, [sp, 0x20]
stp x23, x24, [sp, 0x30]

/*Save Arg 2 times*/
mov x19, x0
mov x20, x0

/*TODO put in code for BSS stuff*/
/*Set Outer/Main Loop Counter in non-volatile register*/
mov w21, 18 /*There are 7 Text sections and 11 Data sections*/

/*Set a register to point at boot.dol's loading addr for text0 section size*/
add x23, x19, 0x90

/*Set a register to point at boot.dol's loading addr for text0*/
add x22, x19, 0x48

textdata_loop:
/*Get section size, if 0, decrement, save in non-volatile reg*/
ldr w24, [x23], 4
rev w24, w24
cbz w24, decrement_outerloop

/*Section has a size, get its mem1/2 loading addr*/
ldr w0, [x22], 4
rev w0, w0

/*Change simulated mem1/mem2 addr to its real addr*/
bl convert /*x0 returns real addr*/

/*Get file offset of section in question
Then add that to x19 (boot.dol ptr) to get real addr*/
ldr w1, [x20]
rev w1, w1
add x1, x1, x19

/*Transfer section's contents from boot.dol to mem1/2*/
inner_loop:
ldrb w2, [x1], 1
strb w2, [x0], 1
subs w24, w24, 1
bne inner_loop

decrement_outerloop:
subs w21, w21, 1
bne textdata_loop

/*Now verify Entry point
Clear Most Sig. Digit
Must be 32-bit (word) aligned
Can't be less than 0x00000000
Can't be higher 0x017FFFFC (check word alignment beforehand ofc)
*/
ldr w0, [x19, 0xE0]
rev w0, w0
cmp w0, 0
blo invalid_entry_point //unsigned less than
tst w0, 3
bne invalid_entry_point //32-bit (word) alignment check
movz w1, 0x017F, lsl 16
movk w1, 0xFFFC
cmp w0, w1
bhs invalid_entry_point //unsigned greater than or equal to

/*Set PC to Entry point addr*/
ldr x1, [x27, 0x20]
str w0, [x1, pc]

/*Success, free boot.dol malloc'd memory and return 0*/
ldr x0, [x27, 0x10]
bl free
mov w0, 0
b insert_dol_epilogue

/*Error, free boot.dol malloc'd memory and return pointer for puts*/
invalid_entry_point:
ldr x0, [x27, 0x10]
bl free
adr x0, insertdolEC

/*Epilogue*/
insert_dol_epilogue:
ldp x23, x24, [sp, 0x30]
ldp x21, x22, [sp, 0x20]
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x40
ret

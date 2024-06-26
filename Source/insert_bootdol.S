#include "sub/convert.S"

/*
x0 returns 0 = success
x0 returns insertdolEC ptr for error
*/

insertdolBSSec:
.asciz "Error! Invalid BSS address found in the boot.dol!"
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

/*Grab boot.dol ptr from x27 array*/
ldr x0, [x27, bootdol_ptr]

/*Save Arg 2 times*/
mov x19, x0
mov x20, x0

/*Get BSS size*/
ldr w2, [x0, 0xDC]
cmp w2, 0
beq set_outermain_loopcounter

/*Get & Verify BSS ppc mem address*/
ldr w0, [x0, 0xD8]
rev w0, w0
cmp w0, 0
blo invalid_bss_addr //unsigned less than
tst w0, 3
bne invalid_bss_addr //32-bit (word) alignment check
movz w1, 0x017F, lsl 16
movk w1, 0xFFFC
cmp w0, w1
bhs invalid_bss_addr //unsigned greater than or equal to
/*Change fake ppc addr to real addr*/
/*w0 already set; x0 returns real addr*/
bl convert
/*Do the BSS!*/
mov w1, 0
strb w1, [x0], 1
subs w2, w2, 1
bne -0x8

/*Set Outer/Main Loop Counter in non-volatile register*/
set_outermain_loopcounter:
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
ldr x1, [x27, regbank_ptr]
str w0, [x1, pc]

/*Success, free boot.dol malloc'd memory and return 0*/
mov x0, x19
bl free
mov w0, 0
b insert_dol_epilogue

/*Error, free boot.dol malloc'd memory and return pointer for puts*/
invalid_bss_addr:
mov x0, x19
bl free
adr x0, insertdolBSSec
b insert_dol_epilogue

/*Error, free boot.dol malloc'd memory and return pointer for puts*/
invalid_entry_point:
mov x0, x19
bl free
adr x0, insertdolEC

/*Epilogue*/
insert_dol_epilogue:
ldp x23, x24, [sp, 0x30]
ldp x21, x22, [sp, 0x20]
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x40
ret

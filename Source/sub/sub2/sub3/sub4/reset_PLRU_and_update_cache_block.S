/*w0 = way number
x1 = way ptr
x2 = set ptr
w3 = PA-32 with MEI applied*/

.globl reset_PLRU_and_update_cache_block
reset_PLRU_and_update_cache_block:
/*Prologue*/
stp fp, lr, [sp, -0x10]!
mov fp, lr

/*Grab PLRU masks ptr, and then load the two masks*/
ldr x4, [x27, PLRU_masks_ptr]
ldrb w5, [x4, x0]
add x0, x0, 8
ldrb w6, [x4, x0]

/*Load PLRU byte*/
ldrb w7, [x2, 8]

/*Clear bits using mask1*/
bic w7, w7, w5

/*Set new bits using other mask2*/
orr w7, w7, w6

/*Replace the PLRU byte*/
strb w7, [x2, 8]

//Replace PA-32 (all bits in LMEI will be low)
str w3, [x1]

//Now copy contents form physical memory to the cache block
add x18, x1, 9
bl convert /*x18 is preserved thru this func*/
mov w3, 4 /*4 double-words per L1 block. Dont wanna use ldp due to possible misalignemnet which will cause program fault*/
ldr x1, [x0], 8
str x1, [x18], 8
subs w3, w3, 1
bne -0xC

/*Epilogue*/
ldp fp, lr, [sp], 0x10
ret

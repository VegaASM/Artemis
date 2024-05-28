/* (void; no return values)
w0 = way number
x1 = way0 ptr of set
*/

.globl reset_PLRU
reset_PLRU:
/*Prologue*/
stp fp, lr, [sp, -0x10]!
mov fp, lr

/*Grab PLRU masks ptr, and then load the two masks*/
ldr x2, [x27, PLRU_masks_ptr]
ldrb w3, [x2, x0]
add x0, x0, 8
ldrb w4, [x2, x0]

/*Load PLRU byte*/
ldrb w5, [x1, 8]

/*Clear bits using mask1*/
bic w5, w5, w3

/*Set new bits using other mask2*/
orr w5, w5, w4

/*Replace the set's PLRU byte*/
strb w5, [x1, 8]

/*Epilogue*/
ldp fp, lr, [sp], 0x10
ret

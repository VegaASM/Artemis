/* (void)
w0 = PPC PA with LMEI bits already inserted already 32-byte aligned
x1 = Dest ptr (raw way ptr)
*/
.globl push_into_cache
push_into_cache:
stp fp, lr, [sp, -0x20]!
str x19, [sp, 0x10]
mov fp, lr

/*save x0 arg*/
add x19, x1, 9

/*Place in new PA-32 with LMEI bits*/
str w0, [x1]

/*Convert PA-32 (w/o LMEI) to its real OS mem addr*/
bfc w0, 0, 5
bl convert

/*Now transfer the data, double-word at a time*/
mov w2, 4
ldr x1, [x0], 8
str x1, [x19], 8
subs w2, w2, 1
bne -0xC

/*Epilogue*/
ldr x19, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

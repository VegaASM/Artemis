.globl console_input
console_input:
/*Prologue*/
stp fp, lr, [sp, -0x80]! /*Make 0x70 size of buffer space*/
mov fp, sp

/*Call fgets and check return*/
adrp x2, stdin
ldr x2, [x2, :lo12: stdin]
mov w1, 0x70
add x0, sp, 0x10
bl fgets
cbz x0, 0x8 /*Return back 0 for Error*/
ldrb w0, [sp, 0x10]

/*Epilogue*/
ldp fp, lr, [sp], 0x80
ret

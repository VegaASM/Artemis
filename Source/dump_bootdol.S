bootdol_stringloc:
.asciz "dol/boot.dol"
bootdol_permsloc:
.asciz "rb"
fopenbootdolEC:
.asciz "Error! Can't open boot.dol. Make sure one is present."
fseekbootdolEC:
.asciz "Error! fseek failure on boot.dol"
bootdolsizeEC:
.asciz "Error! Boot.dol exceeds size of 24MB."
mallocbootdolEC:
.asciz "Error! Can't allocate memory for boot.dol."
freadbootdolEC:
.asciz "Error! Unable to dump boot.dol to memory."
fclosebootdolEC:
.asciz "Error! Can't close boot.dol."

.align 2

/*x27 = array ptr
x19 = file pointer
w20 = size
x21 = malloc pointer*/

.globl dump_bootdol
dump_bootdol:
/*Prologue*/
stp fp, lr, [sp, -0x30]!
stp x19, x20, [sp, 0x10]
str x21, [sp, 0x20]
mov fp, sp

/*Open boot.dol*/
adr x0, bootdol_stringloc
adr x1, bootdol_permsloc
bl fopen
mov x19, x0
adr x0, fopenbootdolEC
cbz x19, dumpbootdol_epilogue

/*Get size of boot.dol*/
mov w1, 0
mov w2, 2
mov x0, x19
bl fseek
mov w1, w0
adr x0, fseekbootdolEC
cbnz w1, dumpbootdol_epilogue
mov x0, x19
bl ftell
mov w20, w0

/*Size cannot exceed 24MB (0x01800000)*/
movz w1, 0x0180, lsl 16
cmp w0, w1 /*cmp w0, 0x01800000*/
adr x0, bootdolsizeEC
bhi dumpbootdol_epilogue

/*Rewind back to start of file & malloc memory for dump*/
mov x0, x19
bl rewind //No error check for this
mov w0, w20
bl malloc
mov x21, x0
adr x0, mallocbootdolEC
cbz x21, dumpbootdol_epilogue

/*Dump boot.dol*/
mov x0, x21 //Where to dump
mov w1, 1 //Size
mov w2, w20 //Count (real size)
mov x3, x19 //File pointer
bl fread
cmp w0, w20
adr x0, freadbootdolEC
bne dumpbootdol_epilogue

/*Close boot.dol*/
mov x0, x19
bl fclose
mov w1, w0
adr x0, fclosebootdolEC
cbnz w1, dumpbootdol_epilogue

/*Store boot.dol ptr and size to array*/
str x21, [x27, bootdol_ptr]
str w20, [x27, bootdol_size]

/*Return back zero (success)*/
mov w0, 0

/*Epilogue*/
dumpbootdol_epilogue:
ldr x21, [sp, 0x20]
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x30
ret

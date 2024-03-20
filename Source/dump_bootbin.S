
bootbin_stringloc:
.asciz "boot/boot.bin"
bootbin_permsloc:
.asciz "rb"
fopenbootbinEC:
.asciz "Error! Can't open boot.bin. Make sure one is present."
fseekbootbinEC:
.asciz "Error! fseek failure on boot.bin"
bootbinsizeEC:
.asciz "Error! Boot.bin exceeds size of 0x40 bytes."
mallocbootbinEC:
.asciz "Error! Can't allocate memory for boot.bin."
freadbootbinEC:
.asciz "Error! Unable to dump boot.bin to memory."
fclosebootbinEC:
.asciz "Error! Can't close boot.bin."

.align 2

/*x27 = array ptr
x19 = file pointer for stream
w20 = size
x21 = malloc pointer*/

.globl dump_bootbin
dump_bootbin:
//Prologue
stp fp, lr, [sp, -0x30]!
stp x19, x20, [sp, 0x10]
str x21, [sp, 0x20]
mov fp, sp

/*Open boot.bin*/
adr x0, bootbin_stringloc
adr x1, bootbin_permsloc
bl fopen
mov x19, x0
adr x0, fopenbootbinEC
cbz x19, dumpbootbin_epilogue

/*Get size of boot.bin*/
mov w1, 0
mov w2, 2
mov x0, x19
bl fseek
mov w1, w0
adr x0, fseekbootbinEC
cbnz w1, dumpbootbin_epilogue
mov x0, x19
bl ftell
mov w20, w0

/*Size cannot exceed 0x40
Boot.bin replicates the EXI boot base*/
cmp w0, 0x40
adr x0, bootbinsizeEC
bhi dumpbootbin_epilogue

/*Rewind back to start of file & malloc memory for dump*/
mov x0, x19
bl rewind //No error check for this
mov w0, w20
bl malloc
mov x21, x0
adr x0, mallocbootbinEC
cbz x21, dumpbootbin_epilogue

/*Dump boot.bin*/
mov x0, x21 //Where to dump
mov w1, 1 //Size
mov w2, w20 //Count (real size)
mov x3, x19 //File pointer
bl fread
cmp w0, w20
adr x0, freadbootbinEC
bne dumpbootbin_epilogue

/*Close boot.bin*/
mov x0, x19
bl fclose
mov w1, w0
adr x0, fclosebootbinEC
cbnz w1, dumpbootbin_epilogue

/*Store boot.bin ptr and size to array*/
str x21, [x27]
str w20, [x27, 0x8]

/*Return back zero (success)*/
mov w0, 0

/*Epilogue*/
dumpbootbin_epilogue:
ldr x21, [sp, 0x20]
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x30
ret

/*This func simply does the file handling for writing to artemis.txt
Open with write perms
Write to file
Close file
*/

arttxt:
.asciz "www/artemis.txt"
artperms:
.asciz "wb"
artfopenEC_string:
.asciz "Error! Unable to open artemis.txt. Check the folder permissions."
artfwriteEC_string:
.asciz "Error! Unable to write to artemis.txt. Check the folder permissions."
.align 2

/*x0 = artemis.txt pointer*/
/*w1 = size*/
.globl write_artemis_txt
write_artemis_txt:
/*Prologue*/
stp fp, lr, [sp, -0x30]!
stp x19, x20, [sp, 0x10]
str x21, [sp, 0x20]
mov fp, sp

/*Save args*/
mov x19, x0
mov w21, w1

/*Open artemis.txt with write perms*/
adr x0, arttxt
adr x1, artperms
bl fopen
cbz x0, artfopenEC
mov x20, x0

/*Write to artemis.txt*/
mov x0, x19
mov w1, 1
mov w2, w21
mov x3, x20
bl fwrite
cmp w0, w21
bne artfwriteEC

/*Close artemis.txt*/
mov x0, x20
bl fclose /*Don't bother EC checking this*/
mov w0, 0 /*Not needed but just in case*/
b write_art_epilogue

artfopenEC:
adr x0, artfopenEC_string
b write_art_epilogue

artfwriteEC:
adr x0, artfwriteEC_string

/*Epilogue*/
write_art_epilogue:
ldr x21, [sp, 0x20]
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x30
ret

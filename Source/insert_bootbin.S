.globl insert_bootin
insert_bootbin:
/*Get real addr of 0xFFF00100*/
movz w0, 0xFFF0, lsl 16
movk w0, 0x0100
bl convert

/*Get boot.bin ptr & size*/
ldr x1, [x27, bootbin_ptr]
ldr w2, [x27, bootbin_size] /*Size can never exceed 32-bits in width*/

/*Transfer the contents, no need for rev (le to be conversion) since we are transferring via bytes*/
ldrb w3, [x1], 1
strb w3, [x0], 1
subs w2, w2, 1
bne -0xC

/*Done*/
ret

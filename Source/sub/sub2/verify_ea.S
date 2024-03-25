
/*
w0 = EA
w0 returns 1 = good/true
w0 returns 0 = bad/false & w1 will = bad EA
*/

/*TODO put in code for BAT translation, then SR translation*/
.globl verify_ea
verify_ea:
stp fp, lr, [sp, -0x10]!
mov fp, sp
cmp w0, 0
blo bad_ea
movz w2, 0x13FF, lsl 16
movk w2, 0xFFFF
cmp w0, w2
bhi bad_ea
mov w2, 0x10000000
cmp w0, w2
bhi good_ea
movz w2, 0x017F, lsl 16
movk w2, 0xFFFF
cmp w0, w2
bhi bad_ea
good_ea:
mov w0, 1
b verify_ea_epilogue
bad_ea:
mov w1, w0
mov w0, 0
verify_ea_epilogue:
ldp fp, lr, [sp], 0x10
ret

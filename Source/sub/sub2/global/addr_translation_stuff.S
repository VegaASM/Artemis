
.set sbe_hid4, 0x01000000

.globl check_bats
check_bats:
/*Extract BEPI & place as proper 32-bit address*/
lsr x2, x1, 32
bfc w2, 0, 17

/*Set a scratch register to 128KB (lowest BAT size possible)*/
mov w3, 0x20000

/*Extract BL bits*/
ubfx x4, x1, 40, 11

/*Figure out amount to adjust to w3 based on BL's high/flipped MSB (first high bit found)*/
clz w5, w4
sub w5, w5, 32
/*Get adder amount by shifting w3 via w5 result*/
lsl w3, w3, w5
/*Add it to get virtual addr range end*/
add w4, w2, w3

/*Is EA within w2 and w3 (start addr & end addr range)?*/
cmp w0, w2
blo throw_neg_one
cmp w0, w4
bhi throw_neg_one

mov w0, 0
ret

throw_neg_one:
mov w0, -1
ret

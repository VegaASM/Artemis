/*Func converts a Byte Integer to a Half-Word Length ASCII value*/
/*w0 input = Hex Byte
x0 output = Ascii HalfWord Equivalent*/

.globl convertByteInt2ASCII
convertByteInt2ASCII:

/*Place arg in w1*/
mov w1, w0

/*Set Initial 'Shiftor' Amount*/
mov w2, 8

/*Clear out a register to 'build' the Ascii word with*/
mov w0, 0

/*Set Loop Counter*/
mov w3, 2

hexbyte_to_ascii_loop:
/*Decrement Shiftor*/
sub w2, w2, 4

/*Shift w1 Right using Shiftor*/
lsr w4, w1, w2

/*Extract Far Right Digit*/
ubfx w4, w4, 0, 4

/*Convert it*/
cmp w4, 0x9
bgt 0xC
orr w4, w4, 0x30
b 0x8
add w4, w4, 0x37

/*Shift w4 Left using Shiftor (times 2)*/
add w5, w2, w2
lsl w4, w4, w5

/*'Compile' Ascii word*/
orr w0, w0, w4

/*Decrement Loop, once done, return back to Parent*/
subs w3, w3, 1
bne hexbyte_to_ascii_loop
ret


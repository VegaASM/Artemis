/*Func converts a Word Integer to a Double-Word ASCII value*/
/*w0 input = Hex Word
x0 output = Ascii Word Equivalent*/

.globl convertWordInt2ASCII
convertWordInt2ASCII:

/*Place arg in w1*/
mov w1, w0

/*Set Initial 'Shiftor' Amount*/
mov w2, 32

/*Clear out a register to 'build' the Ascii word with*/
mov w0, 0

/*Set Loop Counter*/
mov w3, 8

hexword_to_ascii_loop:
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
/*NOTE next 3 instructions MUST be extended*/
add x5, x2, x2
lsl x4, x4, x5

/*'Compile' Ascii word*/
orr x0, x0, x4

/*Decrement Loop, once done, return back to Parent*/
subs w3, w3, 1
bne hexword_to_ascii_loop
ret


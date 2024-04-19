
/*x0 = 1st disassembled ins str pointer*/
/*x1 = 2nd disassembled ins str pointer*/

.globl writeartemisstrings
writeartemisstrings:
stp fp, lr, [sp, -0x10]!
mov fp, sp

/*The disassembler engine will have null byte enders for any string it produces, fyi*/
/*Place 1st string at very start of artemis.txt*/
ldr x2, [x27, artemistxt_ptr]
first_string_transfer:
ldrb w3, [x0], 1
strb w3, [x2], 1
cmp w3, 0 /*cmp after strb so we on purposely store the null byte*/
bne first_string_transfer

/*write ASCII enter 0x0A over null byte*/
mov w4, 0xA
strb w4, [x2, -1]

/*Place 2nd string now*/
second_string_transfer:
ldrb w0, [x1], 1
strb w0, [x2], 1
cmp w0, 0 /*cmp after strb so we on purposely store the null byte*/
bne second_string_transfer

/*DO *****NOT***** write over null byte on this one, we need it present for when convertregisters func gets called*/
/*End func*/
ldp fp, lr, [sp], 0x10
ret

//and rA, rS, rB
.globl and_ppc
and_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
and w3, w3, w4 //and::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//and. rA, rS, rB
.globl andRC_ppc
andRC_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
and w3, w3, w4 //and::ppc
str w3, [x1, x2] //write rA
record_feature w3
pc_adjust 0x4
ret

//andc rA, rS, rB
.globl andc_ppc
andc_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
bic w3, w3, w4 //andc::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//andc. rA, rS, rB
.globl andcRC_ppc
andcRC_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
bic w3, w3, w4 //andc::ppc
str w3, [x1, x2] //write rA
record_feature w3
pc_adjust 0x4
ret

//andi. rA, rS, UIMM
.globl andiRC_ppc
andiRC_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, UIMMoff] //get UIMM
ldr w3, [x1, x3] //grab rS's value
and w3, w3, w4 //andRC::ppc
str w3, [x1, x2] //write rA
record_feature w3
pc_adjust 0x4
ret

//andis. rA, rS, UIMM
.globl andisRC_ppc
andisRC_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, UIMMoff] //get UIMM
ldr w3, [x1, x3] //grab rS's value
lsl w4, w4, 16 //andisRC::ppc
and w3, w3, w4 //andisRC::ppc
str w3, [x1, x2] //write rA
record_feature w3
pc_adjust 0x4
ret

//crand
.globl crand_ppc
crand_ppc:
ldr w2, [x0, crbDoff] //get crBd number
ldr w3, [x0, crbAoff] //get crBa number
ldr w4, [x0, crbBoff] //get crBb number
ldr w5, [x1, cr] //grab ppc CR value
//We need to flip all big endian crB values to little endian
sub w8, w2, 31 //need w2 og value for later
sub w3, w3, 31
sub w4, w4, 31
neg w8, w8
neg w3, w3
neg w4, w4
//Extract crBa and crBb and execute the operation
and w6, w5, w3 
and w7, w5, w4
and w6, w6, w7 //crand::ppc
//Insert new crBd result
ror w5, w5, w8 //Put crBd slot into LSB slot
and w5, w5, 0xFFFFFFFE //Remove current crBd value
orr w5, w5, w6 //Insert new result
//Rotate back to where we were
add w2, w2, 1
cmp w2, 32
beq 0x8 //ror can't do a rotation > 31 ofc
ror w5, w5, w2
//Write new ppc CR value
str w5, [x1, cr]
pc_adjust 0x4
ret

//crandc
.globl crandc_ppc
crandc_ppc:
ldr w2, [x0, crbDoff] //get crBd number
ldr w3, [x0, crbAoff] //get crBa number
ldr w4, [x0, crbBoff] //get crBb number
ldr w5, [x1, cr] //grab ppc CR value
//We need to flip all big endian crB values to little endian
sub w8, w2, 31 //need w2 og value for later
sub w3, w3, 31
sub w4, w4, 31
neg w8, w8
neg w3, w3
neg w4, w4
//Extract crBa and crBb and execute the operation
and w6, w5, w3 
and w7, w5, w4
bic w6, w6, w7 //crandc::ppc
//Insert new crBd result
ror w5, w5, w8 //Put crBd slot into LSB slot
and w5, w5, 0xFFFFFFFE //Remove current crBd value
orr w5, w5, w6 //Insert new result
//Rotate back to where we were
add w2, w2, 1
cmp w2, 32
beq 0x8 //ror can't do a rotation > 31 ofc
ror w5, w5, w2
//Write new ppc CR value
str w5, [x1, cr]
pc_adjust 0x4
ret

//creqv
.globl creqv_ppc
creqv_ppc:
ldr w2, [x0, crbDoff] //get crBd number
ldr w3, [x0, crbAoff] //get crBa number
ldr w4, [x0, crbBoff] //get crBb number
ldr w5, [x1, cr] //grab ppc CR value
//We need to flip all big endian crB values to little endian
sub w8, w2, 31 //need w2 og value for later
sub w3, w3, 31
sub w4, w4, 31
neg w8, w8
neg w3, w3
neg w4, w4
//Extract crBa and crBb and execute the operation
and w6, w5, w3 
and w7, w5, w4
eon w6, w6, w7 //creqv::ppc
//Insert new crBd result
ror w5, w5, w8 //Put crBd slot into LSB slot
and w5, w5, 0xFFFFFFFE //Remove current crBd value
orr w5, w5, w6 //Insert new result
//Rotate back to where we were
add w2, w2, 1
cmp w2, 32
beq 0x8 //ror can't do a rotation > 31 ofc
ror w5, w5, w2
//Write new ppc CR value
str w5, [x1, cr]
pc_adjust 0x4
ret

//crnand
.globl crnand_ppc
crnand_ppc:
ldr w2, [x0, crbDoff] //get crBd number
ldr w3, [x0, crbAoff] //get crBa number
ldr w4, [x0, crbBoff] //get crBb number
ldr w5, [x1, cr] //grab ppc CR value
//We need to flip all big endian crB values to little endian
sub w8, w2, 31 //need w2 og value for later
sub w3, w3, 31
sub w4, w4, 31
neg w8, w8
neg w3, w3
neg w4, w4
//Extract crBa and crBb and execute the operation
and w6, w5, w3 
and w7, w5, w4
and w6, w6, w7 //crnand::ppc
mvn w6, w6
//Insert new crBd result
ror w5, w5, w8 //Put crBd slot into LSB slot
and w5, w5, 0xFFFFFFFE //Remove current crBd value
orr w5, w5, w6 //Insert new result
//Rotate back to where we were
add w2, w2, 1
cmp w2, 32
beq 0x8 //ror can't do a rotation > 31 ofc
ror w5, w5, w2
//Write new ppc CR value
str w5, [x1, cr]
pc_adjust 0x4
ret

//crnor
.globl crnor_ppc
crnor_ppc:
ldr w2, [x0, crbDoff] //get crBd number
ldr w3, [x0, crbAoff] //get crBa number
ldr w4, [x0, crbBoff] //get crBb number
ldr w5, [x1, cr] //grab ppc CR value
//We need to flip all big endian crB values to little endian
sub w8, w2, 31 //need w2 og value for later
sub w3, w3, 31
sub w4, w4, 31
neg w8, w8
neg w3, w3
neg w4, w4
//Extract crBa and crBb and execute the operation
and w6, w5, w3 
and w7, w5, w4
orr w6, w6, w7 //crnor::ppc
mvn w6, w6
//Insert new crBd result
ror w5, w5, w8 //Put crBd slot into LSB slot
and w5, w5, 0xFFFFFFFE //Remove current crBd value
orr w5, w5, w6 //Insert new result
//Rotate back to where we were
add w2, w2, 1
cmp w2, 32
beq 0x8 //ror can't do a rotation > 31 ofc
ror w5, w5, w2
//Write new ppc CR value
str w5, [x1, cr]
pc_adjust 0x4
ret

//cror
.globl cror_ppc
cror_ppc:
ldr w2, [x0, crbDoff] //get crBd number
ldr w3, [x0, crbAoff] //get crBa number
ldr w4, [x0, crbBoff] //get crBb number
ldr w5, [x1, cr] //grab ppc CR value
//We need to flip all big endian crB values to little endian
sub w8, w2, 31 //need w2 og value for later
sub w3, w3, 31
sub w4, w4, 31
neg w8, w8
neg w3, w3
neg w4, w4
//Extract crBa and crBb and execute the operation
and w6, w5, w3 
and w7, w5, w4
orr w6, w6, w7 //cror::ppc
//Insert new crBd result
ror w5, w5, w8 //Put crBd slot into LSB slot
and w5, w5, 0xFFFFFFFE //Remove current crBd value
orr w5, w5, w6 //Insert new result
//Rotate back to where we were
add w2, w2, 1
cmp w2, 32
beq 0x8 //ror can't do a rotation > 31 ofc
ror w5, w5, w2
//Write new ppc CR value
str w5, [x1, cr]
pc_adjust 0x4
ret

//crorc
.globl crorc_ppc
crorc_ppc:
ldr w2, [x0, crbDoff] //get crBd number
ldr w3, [x0, crbAoff] //get crBa number
ldr w4, [x0, crbBoff] //get crBb number
ldr w5, [x1, cr] //grab ppc CR value
//We need to flip all big endian crB values to little endian
sub w8, w2, 31 //need w2 og value for later
sub w3, w3, 31
sub w4, w4, 31
neg w8, w8
neg w3, w3
neg w4, w4
//Extract crBa and crBb and execute the operation
and w6, w5, w3 
and w7, w5, w4
orn w6, w6, w7 //crorc::ppc
//Insert new crBd result
ror w5, w5, w8 //Put crBd slot into LSB slot
and w5, w5, 0xFFFFFFFE //Remove current crBd value
orr w5, w5, w6 //Insert new result
//Rotate back to where we were
add w2, w2, 1
cmp w2, 32
beq 0x8 //ror can't do a rotation > 31 ofc
ror w5, w5, w2
//Write new ppc CR value
str w5, [x1, cr]
pc_adjust 0x4
ret

//crxor
.globl crxor_ppc
crxor_ppc:
ldr w2, [x0, crbDoff] //get crBd number
ldr w3, [x0, crbAoff] //get crBa number
ldr w4, [x0, crbBoff] //get crBb number
ldr w5, [x1, cr] //grab ppc CR value
//We need to flip all big endian crB values to little endian
sub w8, w2, 31 //need w2 og value for later
sub w3, w3, 31
sub w4, w4, 31
neg w8, w8
neg w3, w3
neg w4, w4
//Extract crBa and crBb and execute the operation
and w6, w5, w3 
and w7, w5, w4
eor w6, w6, w7 //crxor::ppc
//Insert new crBd result
ror w5, w5, w8 //Put crBd slot into LSB slot
and w5, w5, 0xFFFFFFFE //Remove current crBd value
orr w5, w5, w6 //Insert new result
//Rotate back to where we were
add w2, w2, 1
cmp w2, 32
beq 0x8 //ror can't do a rotation > 31 ofc
ror w5, w5, w2
//Write new ppc CR value
str w5, [x1, cr]
pc_adjust 0x4
ret

//eqv/xnor
.globl eqv_ppc
eqv_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
eon w3, w3, w4 //eqv::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//eqv./xnor.
.globl eqvRC_ppc
eqvRC_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
eon w3, w3, w4 //eqvRC::ppc
str w3, [x1, x2] //write rA
record_feature w3
pc_adjust 0x4
ret

//nand
.globl nand_ppc
nand_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
and w3, w3, w4 //nand::ppc
mvn w3, w3 //nand::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//nand.
.globl nandRC_ppc
nandRC_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
and w3, w3, w4 //nandRC::ppc
mvn w3, w3 //nandRC::ppc
str w3, [x1, x2] //write rA
record_feature w3
pc_adjust 0x4
ret

//nor
.globl nor_ppc
nor_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
orr w3, w3, w4 //nor::ppc
mvn w3, w3 //nor::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//nor.
.globl norRC_ppc
norRC_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
orr w3, w3, w4 //norRC::ppc
mvn w3, w3 //norRC::ppc
str w3, [x1, x2] //write rA
record_feature w3
pc_adjust 0x4
ret

//or
.globl or_ppc
or_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
orr w3, w3, w4 //or::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//or.
.globl orRC_ppc
orRC_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
orr w3, w3, w4 //orRC::ppc
str w3, [x1, x2] //write rA
record_feature w3
pc_adjust 0x4
ret

//orc
.globl orc_ppc
orc_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
orn w3, w3, w4 //orc::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//orc.
.globl orcRC_ppc
orcRC_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
orn w3, w3, w4 //orcRC::ppc
str w3, [x1, x2] //write rA
record_feature w3
pc_adjust 0x4
ret

//ori
.globl ori_ppc
ori_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, UIMMoff] //get UIMM
ldr w3, [x1, x3] //grab rS's value
orr w3, w3, w4 //ori::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//oris
.globl oris_ppc
oris_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, UIMMoff] //get UIMM
ldr w3, [x1, x3] //grab rS's value
lsl w4, w4, 16 //oris::ppc
orr w3, w3, w4 //oris::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//xor
.globl xor_ppc
xor_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
eor w3, w3, w4 //xor::ppc
str w3, [x1, x2] //write rA
record_feature w3
pc_adjust 0x4
ret

//xor.
.globl xorRC_ppc
xorRC_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
eor w3, w3, w4 //xorRC::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//xori
.globl xori_ppc
xori_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, UIMMoff] //get UIMM
ldr w3, [x1, x3] //grab rS's value
eor w3, w3, w4 //xori::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//xoris
.globl xoris_ppc
xoris_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, UIMMoff] //get UIMM
ldr w3, [x1, x3] //grab rS's value
lsl w4, w4, 16 //xoris::ppc
eor w3, w3, w4 //xoris::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

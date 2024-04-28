/*This func converts a sim addr to the REAL addr*/

/*w0 = fake mem addr
x0 returns proper real addr*/

.globl convert
convert:
/*Check for high exception mode first*/
mov w1, 0xFFF00000
and w2, w0, w1
cmp w2, w1
beq fix_high_exp_addr

/*See if we are converting via mem1/2*/
/*Place base sim ptr into w1*/
ands w1, w0, 0x10000000 /*Do NOT remove w1 from ands instruction (don't use tst), we need its value*/
beq mem1addr

/*grab real mem2 base ptr*/
ldr x2, [x27, mem2_ptr]
b calcmargin

/*Convert high exception addr to mem1 physical addr*/
fix_high_exp_addr:
bfc w0, 20, 12 /*Clear out most significant 12 bits aka the high exception bits*/
mov w1, 0 /*Need this cuz the above 'and' instruction wasn't executed in this path. mem1 base ptr is 0x00000000 ofc*/

/*grab real mem1 base ptr*/
mem1addr:
ldr x2, [x27, mem1_ptr]

/*Margin = Real mem1/2 base ptr - mem1/2 base ptr*/
calcmargin:
sub x1, x2, x1

/*We have margin, now add margin to simulated mem1/2 addr to get its Real mem1/2 addr, then Return*/
add x0, x0, x1
ret




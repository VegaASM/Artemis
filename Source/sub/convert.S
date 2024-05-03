/*This func converts a sim addr to the REAL addr*/

/*w0 = PPC Physical Address (NOTE no VA's!)
x0 returns proper real addr*/

/*NOTE this function does not check EA validity! Always send a valid PA to this func!!*/

.globl convert
convert:
/*Check for high exception mode first*/
movz w1, :abs_g1: ip_base
movk w1, :abs_g0_nc: ip_base
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

/*Convert high exception addr to IP physical addr*/
fix_high_exp_addr:
bfc w0, 0, 6 /*Get IP "offset" amount, will be anything from 0x00 thru 0x3F*/
ldr x1, [x27, bootbin_ptr]
add x0, x1, x0
ret

/*grab real mem1 base ptr*/
mem1addr:
ldr x2, [x27, mem1_ptr]

/*Margin = Real mem1/2 base ptr - mem1/2 base ptr*/
calcmargin:
sub x1, x2, x1

/*We have margin, now add margin to simulated mem1/2 addr to get its Real mem1/2 addr, then Return*/
add x0, x0, x1
ret

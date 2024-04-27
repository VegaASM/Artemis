/*w0 = EA
x1 = Full BAT*/

/*Generate the Physical Address*/
/*Physical Address = {[BRPN0thru14] OR [(EA4thru14 & BL) || (EA15thru31)]}*/

/*Clear out BRPN lower 17 bits*/
.globl bat_va_to_pa
bat_va_to_pa:
and w2, w1, 0xFFFE0000

/*Get BL bits from x1 and place them into Word-Sized-Value big endian bits 4 thru 14*/
/*AND BL bits with EA bits 4 thru 14*/
/*Take this 11 bit result, OR with BPRN bits 0 thru 14*/
lsl x1, x1, 17
and w1, w1, 0x0FFE0000
and w3, w0, 0x0FFE0000
and w1, w1, w3

/*OR that with EA 15 thru 31*/
and w0, w0, 0x0001FFFF
orr w0, w1, w0

/*OR that with BPRN upper 15 bits*/
orr w0, w2, w0
ret

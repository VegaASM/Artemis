/*NOTE currently not included to any Source files, TODO*/

.set single_exp_size, 9
.set single_exp_lsb, 23
.set single_fraction_mask, 0x007FFFFF
.set double_exp_size, 12
.set double_exp_lsb, 52
.set double_fraction_mask, 0x000FFFFFFFFFFFFF
/*.set hid2_pse, 0x20000000 TODO put all HID stuff in own file*/

.macro Get_hid2_pse wregister
ldr \wregister, [x27, regbank_ptr] /*reg bank ptr*/
ubfx \wregister, \wregister, 29, 1
.endm

.globl is_normalized_single
is_normalized_single:
//Exponent bits cannot be min or max value
fmov w0, s0
ubfx w0, w0, single_exp_lsb, single_exp_size
cmp w0, 0xFF
beq 0x14
cmp w0, 0
beq 0xC
mov w0, 1
ret
mov w0, 0
ret

.globl is_normalized_double
is_normalized_double:
fmov x0, d0
ubfx x0, x0, double_exp_lsb, double_exp_size
cmp w0, 0x7FF
beq 0x14
cmp w0, 0
beq 0xC
mov w0, 1
ret
not_normalized_single:
mov w0, 0
ret

is_positive_zero_single:
movi d1, 0
fcmp s0, s1
bne 0xC
mov w0, 1
ret
mov w0, 0
ret

is_positive_zero_double:
movi d1, 0
fcmp d0, d1
bne 0xC
mov w0, 1
ret
mov w0, 0
ret

is_negative_zero_single:
movi d1, 0
fneg s1, s1 //flip the sign bit
fcmp s0, s1
bne 0xC
mov w0, 1
ret
mov w0, 0
ret

is_negative_zero_double:
movi d1, 0
fneg d1, d1 //flip the sign bit
fcmp d0, d1
bne 0xC
mov w0, 1
ret
mov w0, 0
ret

is_denorm_single:
fmov w1, s0
ubfx w0, w1, single_exp_lsb, single_exp_size
cmp w0, 0
mrs x0, nzcv
ubfx w0, w0, 30, 1
tst w1, single_fraction_mask
mrs x1, nzcv
ubfx w1, w1, 30, 1 //Z will be low if nonzero patten
bic w0, w0, w1 //andc; If exp = 0 && fraction != 0, then return true
ret

is_denorm_double:
fmov x1, d0
ubfx x0, x1, single_exp_lsb, single_exp_size
cmp w0, 0
mrs x0, nzcv
ubfx w0, w0, 30, 1
tst x1, double_fraction_mask
mrs x1, nzcv
ubfx w1, w1, 30, 1 //Z will be low if nonzero patten
bic w0, w0, w1 //andc; If exp = 0 && fraction != 0, then return true
ret

is_positive_infi_single:
fmov w1, s0
tst w1, 0x80000000
mrs x2, nzcv
ubfx w2, w2, 30, 1
ubfx w0, w1, single_exp_lsb, single_exp_size
cmp w0, 0xFF
mrs x3, nzcv
ubfx w3, w3, 30, 1
tst w1, single_fraction_mask
mrs x4, nzcv
ubfx w4, w4, 30, 1
and w0, w2, w3 //If sign bit = 0 && expo = max && fraction = 0, then return true
and w0, w0, w4
ret

is_positive_infi_double:
fmov x1, d0
tst x1, 0x80000000
mrs x2, nzcv
ubfx w2, w2, 30, 1
ubfx x0, x1, double_exp_lsb, double_exp_size
cmp w0, 0xFF
mrs x3, nzcv
ubfx w3, w3, 30, 1
tst x1, double_fraction_mask
mrs x4, nzcv
ubfx w4, w4, 30, 1
and w0, w2, w3 //If sign bit = 0 && expo = max && fraction = 0, then return true
and w0, w0, w4
ret

is_negative_infi_single:
fmov w1, s0
tst w1, 0x80000000
mrs x2, nzcv
ubfx w2, w2, 30, 1
mvn w2, w2 //we want bool to be true if bit is NOT zero
ubfx w0, w1, single_exp_lsb, single_exp_size
cmp w0, 0xFF
mrs x3, nzcv
ubfx w3, w3, 30, 1
tst w1, single_fraction_mask
mrs x4, nzcv
ubfx w4, w4, 30, 1
and w0, w2, w3 //If sign bit = 0 && expo = max && fraction = 0, then return true
and w0, w0, w4
ret

is_negative_infi_double:
fmov x1, d0
tst x1, 0x80000000
mrs x2, nzcv
ubfx w2, w2, 30, 1
mvn w2, w2 //we want bool to be true if bit is NOT zero
ubfx x0, x1, double_exp_lsb, double_exp_size
cmp w0, 0xFF
mrs x3, nzcv
ubfx w3, w3, 30, 1
tst x1, double_fraction_mask
mrs x4, nzcv
ubfx w4, w4, 30, 1
and w0, w2, w3 //If sign bit = 0 && expo = max && fraction = 0, then return true
and w0, w0, w4
ret

is_NaN_single:
fmov w1, s0
ubfx w0, w1, single_exp_lsb, single_exp_size
cmp w0, 0xFF
mrs x2, nzcv
ubfx w2, w2, 30, 1
tst w1, single_fraction_mask
mrs x3, nzcv
ubfx w3, w3, 30, 1
mvn w3, w3 //looking for nonzero fraction
and w0, w2, w3 //If exp = max && fraction != 0, then return true
ret

is_NaN_double:
fmov x1, d0
ubfx x0, x1, double_exp_lsb, double_exp_size
cmp w0, 0xFF
mrs x2, nzcv
ubfx w2, w2, 30, 1
tst x1, double_fraction_mask
mrs x3, nzcv
ubfx w3, w3, 30, 1
mvn w3, w3 //looking for nonzero fraction
and w0, w2, w3 //If exp = max && fraction != 0, then return true
ret

normalize_single_float:
//s0 = input, s0 = output
fmov w0, s0
ubfx w1, w0, single_exp_lsb, single_exp_size
clz w2, w0
add w1, w1, w2
lsl w0, w0, w2
eor w0, w0, 0x80000000
//TODO bfi w0, w1, xx, xx
fmov s0, w0
ret

normalize_double_float:
//s0 = input, s0 = output
fmov x0, d0
ubfx x1, x0, double_exp_lsb, double_exp_size
clz x2, x0
add x1, x1, x2
lsl x0, x0, x2
eor x0, x0, 0x8000000000000000
//TODO bfi x0, x1, xx, xx
fmov d0, x0
ret

/*how to normalize a denormed number
clz, decrement exp by 1 for every leading zero
how to denormalize a norm number
shift entire value to right, until exp equals 0*/

/*also NOTE when lfs witih HID2 PSE *LOW* , low order 29 bits of FPR are always cleared for singles*/

.set QNaN_single, 0x7FC00000
.set QNaN_double, 0x7FF8000000000000

/*QNan...
Sign bit = 0 (ignored)
Exp bits = max
Fraction = 1 then all 0's afterwards
*/

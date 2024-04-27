/*This func will verify...
If EA is within a BAT and..
if the Supervisor/User has access
*/

/*w0 = EA
x1 = BAT (full upper and lower)
w0 returns 1 = hit
w0 returns 0 = miss
x1 always returns back intact BAT (no change)
*/

.globl check_bats
check_bats:
/*Extract BEPI's first 4 bits*/
ubfx x2, x1, 60, 4

/*Extract EA's first 4 bits*/
ubfx w3, w0, 28, 4

/*Compare*/
cmp w2, w3
bne bat_array_miss

/*Extract BEPI's last 11 bits*/
ubfx x2, x1, 49, 11

/*Extract EA's Big Endian bits 4 thru 14*/
ubfx w3, w0, 17, 11

/*Extract BL bits, then invert*/
ubfx x4, x1, 34, 11
mvn w4, w4

/*Logically AND EA bits w/ inverted BL bits*/
and w5, w3, w3

/*Result must be equal to BEPI's last 11 bits, if not BAT is NOT in range*/
cmp w2, w5
bne bat_array_miss

/*Get MSR Privilege Mode Bit*/
ldr x2, [x27, regbank_ptr]
ldr w2, [x2, msr]
tst w2, msr_pr
beq 0x10

/*If Supervisor, XOR it with Vs, then return*/
ubfx x3, x1, 1, 1
eor w0, w2, w3
ret

/*If User, eqv it with Vp, then return*/
ubfx x3, x1, 0, 1
eon w0, w2, w3
ret

bat_array_miss:
mov w0, 0
ret

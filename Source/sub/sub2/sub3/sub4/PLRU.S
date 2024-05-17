/*Do PLRU algo
w0 = PLRU byte
w0 returns Way number*/
.globl PLRU
PLRU:
mov w1, 0

/*Is B0 low?*/
tst w0, PLRU_B0
bne checkb2

/*Is B1 low?*/
tst w0, PLRU_B1
bne checkb4

/*Is B3 low? If so replace L0. If not Replace L1*/
ubfx w0, w0, 28, 1
add w0, w1, w0
ret

/*Is B2 low?*/
checkb2:
mov w0, 4
tbnz w0, PLRU_B2, checkb6

/*Is B5 low? If so replace L4. If not Replace L5*/
ubfx w0, w0, 30, 1
add w0, w1, w0
ret

/*Is B4 low? If so replace L2. If not Replace L3*/
checkb4:
mov w0, 2
ubfx w0, w0, 29, 1
add w0, w1, w0
ret

/*is B6 low? If so, replace L6. If not Replace L7*/
checkb6:
mov w0, 6
ubfx w0, w0, 31, 1
add w0, w1, w0
ret

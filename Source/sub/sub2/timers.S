.globl update_timebase
update_timebase:
ldr x1, [x27, regbank_ptr]
ldr x0, [x1, tbu]
add x0, x0, 1
str x0, [x1, tbu]
ret

.globl update_decrementer
update_decrementer:
ldr x1, [x27, regbank_ptr]
ldr w0, [x1, dec]
subs w0, w0, 1
str w0, [x1, dec]
blo 0x8
ret
bl decrementer_exception_vector
ret

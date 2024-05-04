/*x0 (ignored) = extracted ppc offset ptr
x1 = reg bank ptr*/

.globl float_legal_check
float_legal_check:
/*FP bit enabled in MSR?*/
ldr w0, [x1, msr]
tst w0, msr_fp
beq 0xC
mov w0, 0
ret
/*Execute FP Unavailable*/
bl fp_exception_vector
mov w0, -1
ret

/*.set msr_fp, 0x00002000 will eventually have to reorder include files, but we can work without symbol for now*/

/*x0 = extracted ppc offset ptr
x1 = reg bank ptr*/

.globl float_legal_check
float_legal_check:
/*FP bit enabled in MSR?*/
ldr w2, [x1, msr]
tst w2, 0x2000
bne 0x10
/*Execute ISI!*/
bl isi_exception_vector
mov w0, -1
ret
mov w0, 0
ret


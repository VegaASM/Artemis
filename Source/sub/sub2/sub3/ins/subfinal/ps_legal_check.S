/*x0 (ignored) = extracted ppc offset ptr
x1 = reg bank ptr*/

.globl ps_general_legal_check
ps_general_legal_check:
/*Is FP bit in MSR?*/
ldr w0, [x1, msr]
tst w0, msr_fp
beq ps_fp_unavail
/*Is LE bit high in MSR*/
tbnz w0, msr_le, check_hid4_lpe
/*Is HID2 PSE high?*/
ldr w0, [x1, hid2]
tst w0, hid2_pse
beq ps_raise_prog
mov w0, 0
ret
ps_fp_unavail:
bl fp_exception_vector
mov w0, -1
ret
/*Since MSR LE is high, is HID4 LPE also high?*/
check_hid4_lpe:
ldr w0, [x1, hid4]
tst w0, hid4_lpe
beq ps_raise_dsi
mov w0, 0
ret
ps_raise_prog:
mov w0, 0x00040000
bl program_exception_vector
mov w0, -1
ret
ps_raise_dsi:
mov w0, 0x02000000 /*NOTE DSISR bits 15-21 are null (special case bit value)*/
mov w1, 0 //Null for now; TODO
bl dsi_exception_vector
mov w0, -1
ret

/*x0 (ignored) = extracted ppc offset ptr
x1 = reg bank ptr*/

.globl ps_load_store_legal_nonx_check
ps_load_store_legal_nonx_check:
/*Is FP bit in MSR?*/
ldr w0, [x1, msr]
tst w0, msr_fp
beq psNONx_fp_unavail
/*Is LE bit high in MSR*/
tbnz w0, msr_le, NONxcheck_hid4_lpe
/*Is both HID2 PSE & LSQE high?*/
ldr w0, [x1, hid2]
ubfx w1, w0, 31, 1
ubfx w0, w0, 29, 1
tst w1, w0
beq psNONx_raise_prog
mov w0, 0
ret
psNONx_fp_unavail:
bl fp_exception_vector
mov w0, -1
ret
/*Since MSR LE is high, is HID4 LPE also high?*/
NONxcheck_hid4_lpe:
ldr w0, [x1, hid4]
tst w0, hid4_lpe
beq psNONx_raise_dsi
mov w0, 0
ret
psNONx_raise_prog:
mov w0, 0x00040000
bl program_exception_vector
mov w0, -1
ret
psNONx_raise_dsi:
mov w0, 0x02000000 /*NOTE DSISR bits 15-21 are null (special case bit value)*/
mov w1, 0 //Null for now; TODO
bl dsi_exception_vector
mov w0, -1
ret

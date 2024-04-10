.set hid2_lsqe, 0x80000000
.set hid2_pse, 0x20000000
/*.set msr_le, 0x00000001 cant establish again without annoying reordering, plus we really don't need a symbol for this*/
.set hid4_lpe, 0x00800000

/*x0 = extracted ppc offset ptr
x1 = reg bank ptr*/

.globl ps_general_legal_check
ps_general_legal_check:
/*is FP enabled in MSR?*/
ldr w2, [x1, msr]
tst w2, 0x2000
bne 0x10
/*Execute FP unavailable*/
bl fp_exception_vector
mov w0, -1
ret
/*LE bit enabled in MSR?*/
tbz w2, 1, 0x20
/*LE is enabled, is HID4 LPE enabled?*/
ldr w2, [x1, hid4]
tst w2, hid4_lpe
beq 0x14
/*Execute a DSI!*/
mov w1, w0
bl dsi_exception_vector
mov w0, -1
ret
/*Is HID2 PSE enabled?*/
ldr w2, [x1, hid2]
tst w2, hid2_pse
bne 0x14
/*Raise ISI!*/
mov w1, w0
bl isi_exception_vector
mov w0, -1
ret
mov w0, 0
ret

.globl ps_load_store_legal_nonx_check
ps_load_store_legal_nonx_check:
/*is FP enabled in MSR?*/
ldr w2, [x1, msr]
tst w2, 0x2000
bne 0x10
/*Execute FP unavailable*/
bl fp_exception_vector
mov w0, -1
ret
/*LE bit enabled in MSR?*/
tbz w2, 1, 0x20
/*LE is enabled, is HID4 LPE enabled?*/
ldr w2, [x1, hid4]
tst w2, hid4_lpe
beq 0x14
/*Execute a DSI!*/
mov w1, w0
bl dsi_exception_vector
mov w0, -1
ret
/*Is HID2 PSE enabled?*/
ldr w2, [x1, hid2]
tst w2, hid2_pse
bne 0x14
/*Raise ISI!*/
mov w1, w0
bl isi_exception_vector
mov w0, -1
ret
/*Is HID2 LSQE enabled?*/
tst w2, hid2_lsqe
beq -0x14
mov w0, 0
ret

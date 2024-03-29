#include "subfinal/ps_legal_check.S"

.globl psq_l_ppc
psq_l_ppc:
bl ps_load_store_legal_nonx_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl psq_lu_ppc
psq_lu_ppc:
bl ps_load_store_legal_nonx_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl psq_lux_ppc
psq_lux_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl psq_lx_ppc
psq_lx_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl psq_st_ppc
psq_st_ppc:
bl ps_load_store_legal_nonx_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl psq_stu_ppc
psq_stu_ppc:
bl ps_load_store_legal_nonx_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl psq_stux_ppc
psq_stux_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl psq_stx_ppc
psq_stx_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_abs_ppc
ps_abs_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, ps_abs_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr w3, [x1, x2] //Grab fB's value
fabs v3.2s, v3.2s //ps_abs::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ps_abs_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl ps_absRC_ppc
ps_absRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_add_ppc
ps_add_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, ps_add_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
fadd v3.2s, v3.2s, v4.2s //ps_add::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ps_add_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl ps_addRC_ppc
ps_addRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_cmpo0_ppc
ps_cmpo0_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_cmpo1_ppc
ps_cmpo1_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_cmpu0_ppc
ps_cmpu0_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_cmpu1_ppc
ps_cmpu1_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_div_ppc
ps_div_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, ps_div_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
fdiv v3.2s, v3.2s, v4.2s //ps_div::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ps_div_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl ps_divRC_ppc
ps_divRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_madd_ppc
ps_madd_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, ps_madd_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fmul v3.2s, v3.2s, v4.2s
fadd v3.2s, v3.2s, v5.2s //ps_madd::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ps_madd_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl ps_maddRC_ppc
ps_maddRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_madds0_ppc
ps_madds0_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, ps_madds0_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fmul v6.2s, v3.2s, v4.2s
fadd v6.2s, v6.2s, v5.2s //do ps0 madd
dup v3.2s, v3.s[0] //place fA ps1 into fA ps0 slot
dup v5.2s, v5.s[0] //place fB ps1 into fB ps0 slot
fmul v3.2s, v3.2s, v4.2s 
fadd v3.2s, v3.2s, v5.2s //do ps1 madd
ins v3.s[1], v6.s[1] //insert ps0 madd result with ps1 madd result
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ps_madds0_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl ps_madds0RC_ppc
ps_madds0RC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_madds1_ppc
ps_madds1_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_madds1RC_ppc
ps_madds1RC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_merge00_ppc
ps_merge00_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_merge00RC_ppc
ps_merge00RC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_merge01_ppc
ps_merge01_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_merge01RC_ppc
ps_merge01RC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_merge10_ppc
ps_merge10_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_merge10RC_ppc
ps_merge10RC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_merge11_ppc
ps_merge11_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_merge11RC_ppc
ps_merge11RC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_mr_ppc
ps_mr_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_mrRC_ppc
ps_mrRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_msub_ppc
ps_msub_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, ps_msub_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fmul v3.2s, v3.2s, v4.2s
fsub v3.2s, v3.2s, v5.2s //ps_msub::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ps_msub_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl ps_msubRC_ppc
ps_msubRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_mul_ppc
ps_mul_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, ps_mul_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
fadd v3.2s, v3.2s, v4.2s //ps_mul::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ps_mul_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl ps_mulRC_ppc
ps_mulRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_muls0_ppc
ps_muls0_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_muls0RC_ppc
ps_muls0RC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_muls1_ppc
ps_muls1_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_muls1RC_ppc
ps_muls1RC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_nabs_ppc
ps_nabs_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, ps_nabs_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr w3, [x1, x2] //Grab fB's value
fabs v3.2s, v3.2s
fneg v3.2s, v3.2s //ps_nabs::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ps_nabs_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl ps_nabsRC_ppc
ps_nabsRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_neg_ppc
ps_neg_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, ps_neg_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr w3, [x1, x2] //Grab fB's value
fneg v3.2s, v3.2s //ps_neg::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ps_neg_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl ps_negRC_ppc
ps_negRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_nmadd_ppc
ps_nmadd_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, ps_nmadd_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fmul v3.2s, v3.2s, v4.2s
fadd v3.2s, v3.2s, v5.2s
fneg v3.2s, v3.2s //ps_nmadd:ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ps_nmadd_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl ps_nmaddRC_ppc
ps_nmaddRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_nmsub_ppc
ps_nmsub_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, ps_nmsub_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fCoff] //load fC number
lsl w4, w4, 3
ldr w5, [x19, fBoff] //load fB number
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fC's value
ldr d5, [x1, x5] //Grab fB's value
fmul v3.2s, v3.2s, v4.2s
fsub v3.2s, v3.2s, v5.2s
fneg v3.2s, v3.2s //ps_nmsub:ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ps_nmsub_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl ps_nmsubRC_ppc
ps_nmsubRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_res_ppc
ps_res_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, ps_res_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr w3, [x1, x2] //Grab fB's value
frecpe v3.2s, v3.2s //ps_res::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ps_res_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl ps_resRC_ppc
ps_resRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_rsqrte_ppc
ps_rsqrte_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, ps_rsqrte_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fBoff] //load fB number
lsl w3, w3, 3
ldr w3, [x1, x2] //Grab fB's value
frsqrte v3.2s, v3.2s //ps_rsqrte::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ps_rsqrte_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl ps_rsqrteRC_ppc
ps_rsqrteRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_sel_ppc
ps_sel_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_selRC_ppc
ps_selRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_sub_ppc
ps_sub_ppc:
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp
mov x19, x0
mov x20, x1
bl ps_general_legal_check
cbnz w0, ps_sub_ppc_epilogue
add x1, x20, fpr0 //set x1 ptr to start at fpr part of reg bank
ldr w2, [x19, fDoff] //load fD number
lsl w2, w2, 3
ldr w3, [x19, fAoff] //load fA number
lsl w3, w3, 3
ldr w4, [x19, fBoff] //load fB number
lsl w4, w4, 3
ldr d3, [x1, x3] //Grab fA's value
ldr d4, [x1, x4] //Grab fB's value
fsub v3.2s, v3.2s, v4.2s //ps_sub::ppc
str d3, [x1, x2] //Write fD's value
pc_adjust 0x4
ps_sub_ppc_epilogue:
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

.globl ps_subRC_ppc
ps_subRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_sum0_ppc
ps_sum0_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_sum0RC_ppc
ps_sum0RC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_sum1_ppc
ps_sum1_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_sum1RC_ppc
ps_sum1RC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

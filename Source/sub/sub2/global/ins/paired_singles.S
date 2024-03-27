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
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_absRC_ppc
ps_absRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_add_ppc
ps_add_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
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
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_divRC_ppc
ps_divRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_madd_ppc
ps_madd_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_maddRC_ppc
ps_maddRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_madds0_ppc
ps_madds0_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
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
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_msubRC_ppc
ps_msubRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_mul_ppc
ps_mul_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
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
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_nabsRC_ppc
ps_nabsRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_neg_ppc
ps_neg_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_negRC_ppc
ps_negRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_nmadd_ppc
ps_nmadd_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_nmaddRC_ppc
ps_nmaddRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_nmsub_ppc
ps_nmsub_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_nmsubRC_ppc
ps_nmsubRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_res_ppc
ps_res_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_resRC_ppc
ps_resRC_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
ret

.globl ps_rsqrte_ppc
ps_rsqrte_ppc:
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
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
bl ps_general_legal_check
cbnz w0, 0x8
pc_adjust 0x4
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

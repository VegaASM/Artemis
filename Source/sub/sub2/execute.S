#include "sub3/symbols_macros/spr_symbols.S"
#include "sub3/ins/subfinal/pcrcoe.S" //Must be established before instruction funcs below
#include "exceptions.S" //Must be established before instruction funcs below and must be before verify_data_ea.S & verify_instruction_ea.S
#include "sub3/sub4/check_bats.S" //Must be before both verify's
#include "sub3/sub4/bat_va_to_pa.S" //Must be before both verify's
#include "sub3/sub4/verify_physical_ea.S" //Must be before both verify's
#include "verify_instruction_ea.S" //Must be established before any instruction func
#include "verify_data_ea.S" //Must be established before any load, store, or paired single file
#include "set_loadstoretouch_flags.S"
#include "sub3/ins/branch.S"
#include "sub3/ins/floats.S"
#include "sub3/ins/load_float.S"
#include "sub3/ins/load_int.S"
#include "sub3/ins/logical.S"
#include "sub3/ins/store_float.S"
#include "sub3/ins/store_int.S"
#include "sub3/ins/other.S"
#include "sub3/ins/paired_singles.S" //Must be established before ps_load.S and ps_store.S
#include "sub3/ins/ps_load.S"
#include "sub3/ins/ps_store.S"
#include "sub3/ins/arithmetic.S"
#include "sub3/ins/compare.S"
#include "sub3/ins/rotate_shift.S"
#include "sub3/ins/cache.S"

func_table:
.xword add_ppc
.xword addRC_ppc
.xword addo_ppc
.xword addoRC_ppc
.xword addc_ppc
.xword addcRC_ppc
.xword addco_ppc
.xword addcoRC_ppc
.xword adde_ppc
.xword addeRC_ppc
.xword addeo_ppc
.xword addeoRC_ppc
.xword addi_ppc
.xword addic_ppc
.xword addicRC_ppc
.xword addis_ppc
.xword addme_ppc
.xword addmeRC_ppc
.xword addmeo_ppc
.xword addmeoRC_ppc
.xword addze_ppc
.xword addzeRC_ppc
.xword addzeo_ppc
.xword addzeoRC_ppc
.xword and_ppc
.xword andRC_ppc
.xword andc_ppc
.xword andcRC_ppc
.xword andiRC_ppc
.xword andisRC_ppc
.xword b_ppc
.xword ba_ppc
.xword bl_ppc
.xword bla_ppc
.xword bc_ppc
.xword bca_ppc
.xword bcl_ppc
.xword bcla_ppc
.xword bcctr_ppc
.xword bcctrl_ppc
.xword bclr_ppc
.xword bclrl_ppc
.xword cmp_ppc
.xword cmpi_ppc
.xword cmpl_ppc
.xword cmpli_ppc
.xword cntlzw_ppc
.xword cntlzwRC_ppc
.xword crand_ppc
.xword crandc_ppc
.xword creqv_ppc
.xword crnand_ppc
.xword crnor_ppc
.xword cror_ppc
.xword crorc_ppc
.xword crxor_ppc
.xword dcbf_ppc
.xword dcbi_ppc
.xword dcbst_ppc
.xword dcbt_ppc
.xword dcbtst_ppc
.xword dcbz_ppc
.xword dcbz_l_ppc
.xword divw_ppc
.xword divwRC_ppc
.xword divwo_ppc
.xword divwoRC_ppc
.xword divwu_ppc
.xword divwuRC_ppc
.xword divwuo_ppc
.xword divwuoRC_ppc
.xword eciwx_ppc
.xword ecowx_ppc
.xword eieio_ppc
.xword eqv_ppc
.xword eqvRC_ppc
.xword extsb_ppc
.xword extsbRC_ppc
.xword extsh_ppc
.xword extshRC_ppc
.xword fabs_ppc
.xword fabsRC_ppc
.xword fadd_ppc
.xword faddRC_ppc
.xword fadds_ppc
.xword faddsRC_ppc
.xword fcmpo_ppc
.xword fcmpu_ppc
.xword fctiw_ppc
.xword fctiwRC_ppc
.xword fctiwz_ppc
.xword fctiwzRC_ppc
.xword fdiv_ppc
.xword fdivRC_ppc
.xword fdivs_ppc
.xword fdivsRC_ppc
.xword fmadd_ppc
.xword fmaddRC_ppc
.xword fmadds_ppc
.xword fmaddsRC_ppc
.xword fmr_ppc
.xword fmrRC_ppc
.xword fmsub_ppc
.xword fmsubRC_ppc
.xword fmsubs_ppc
.xword fmsubsRC_ppc
.xword fmul_ppc
.xword fmulRC_ppc
.xword fmuls_ppc
.xword fmulsRC_ppc
.xword fnabs_ppc
.xword fnabsRC_ppc
.xword fneg_ppc
.xword fnegRC_ppc
.xword fnmadd_ppc
.xword fnmaddRC_ppc
.xword fnmadds_ppc
.xword fnmaddsRC_ppc
.xword fnmsub_ppc
.xword fnmsubRC_ppc
.xword fnmsubs_ppc
.xword fnmsubsRC_ppc
.xword fres_ppc
.xword fresRC_ppc
.xword frsp_ppc
.xword frspRC_ppc
.xword frsqrte_ppc
.xword frsqrteRC_ppc
.xword fsel_ppc
.xword fselRC_ppc
.xword fsub_ppc
.xword fsubRC_ppc
.xword fsubs_ppc
.xword fsubsRC_ppc
.xword icbi_ppc
.xword isync_ppc
.xword lbz_ppc
.xword lbzu_ppc
.xword lbzux_ppc
.xword lbzx_ppc
.xword lfd_ppc
.xword lfdu_ppc
.xword lfdux_ppc
.xword lfdx_ppc
.xword lfs_ppc
.xword lfsu_ppc
.xword lfsux_ppc
.xword lfsx_ppc
.xword lha_ppc
.xword lhau_ppc
.xword lhaux_ppc
.xword lhax_ppc
.xword lhbrx_ppc
.xword lhz_ppc
.xword lhzu_ppc
.xword lhzux_ppc
.xword lhzx_ppc
.xword lmw_ppc
.xword lswi_ppc
.xword lswx_ppc
.xword lwarx_ppc
.xword lwbrx_ppc
.xword lwz_ppc
.xword lwzu_ppc
.xword lwzux_ppc
.xword lwzx_ppc
.xword mcrf_ppc
.xword mcrfs_ppc
.xword mcrxr_ppc
.xword mfcr_ppc
.xword mffs_ppc
.xword mffsRC_ppc
.xword mfmsr_ppc
.xword mfspr_ppc
.xword mfsr_ppc
.xword mfsrin_ppc
.xword mftb_ppc
.xword mtcrf_ppc
.xword mtfsb0_ppc
.xword mtfsb0RC_ppc
.xword mtfsb1_ppc
.xword mtfsb1RC_ppc
.xword mtfsf_ppc
.xword mtfsfRC_ppc
.xword mtfsfi_ppc
.xword mtfsfiRC_ppc
.xword mtmsr_ppc
.xword mtspr_ppc
.xword mtsr_ppc
.xword mtsrin_ppc
.xword mulhw_ppc
.xword mulhwRC_ppc
.xword mulhwu_ppc
.xword mulhwuRC_ppc
.xword mulli_ppc
.xword mullw_ppc
.xword mullwRC_ppc
.xword mullwo_ppc
.xword mullwoRC_ppc
.xword nand_ppc
.xword nandRC_ppc
.xword neg_ppc
.xword negRC_ppc
.xword nego_ppc
.xword negoRC_ppc
.xword nor_ppc
.xword norRC_ppc
.xword or_ppc
.xword orRC_ppc
.xword orc_ppc
.xword orcRC_ppc
.xword ori_ppc
.xword oris_ppc
.xword psq_l_ppc
.xword psq_lu_ppc
.xword psq_lux_ppc
.xword psq_lx_ppc
.xword psq_st_ppc
.xword psq_stu_ppc
.xword psq_stux_ppc
.xword psq_stx_ppc
.xword ps_abs_ppc
.xword ps_absRC_ppc
.xword ps_add_ppc
.xword ps_addRC_ppc
.xword ps_cmpo0_ppc
.xword ps_cmpo1_ppc
.xword ps_cmpu0_ppc
.xword ps_cmpu1_ppc
.xword ps_div_ppc
.xword ps_divRC_ppc
.xword ps_madd_ppc
.xword ps_maddRC_ppc
.xword ps_madds0_ppc
.xword ps_madds0RC_ppc
.xword ps_madds1_ppc
.xword ps_madds1RC_ppc
.xword ps_merge00_ppc
.xword ps_merge00RC_ppc
.xword ps_merge01_ppc
.xword ps_merge01RC_ppc
.xword ps_merge10_ppc
.xword ps_merge10RC_ppc
.xword ps_merge11_ppc
.xword ps_merge11RC_ppc
.xword ps_mr_ppc
.xword ps_mrRC_ppc
.xword ps_msub_ppc
.xword ps_msubRC_ppc
.xword ps_mul_ppc
.xword ps_mulRC_ppc
.xword ps_muls0_ppc
.xword ps_muls0RC_ppc
.xword ps_muls1_ppc
.xword ps_muls1RC_ppc
.xword ps_nabs_ppc
.xword ps_nabsRC_ppc
.xword ps_neg_ppc
.xword ps_negRC_ppc
.xword ps_nmadd_ppc
.xword ps_nmaddRC_ppc
.xword ps_nmsub_ppc
.xword ps_nmsubRC_ppc
.xword ps_res_ppc
.xword ps_resRC_ppc
.xword ps_rsqrte_ppc
.xword ps_rsqrteRC_ppc
.xword ps_sel_ppc
.xword ps_selRC_ppc
.xword ps_sub_ppc
.xword ps_subRC_ppc
.xword ps_sum0_ppc
.xword ps_sum0RC_ppc
.xword ps_sum1_ppc
.xword ps_sum1RC_ppc
.xword rfi_ppc
.xword rlwimi_ppc
.xword rlwimiRC_ppc
.xword rlwinm_ppc
.xword rlwinmRC_ppc
.xword rlwnm_ppc
.xword rlwnmRC_ppc
.xword sc_ppc
.xword slw_ppc
.xword slwRC_ppc
.xword sraw_ppc
.xword srawRC_ppc
.xword srawi_ppc
.xword srawiRC_ppc
.xword srw_ppc
.xword srwRC_ppc
.xword stb_ppc
.xword stbu_ppc
.xword stbux_ppc
.xword stbx_ppc
.xword stfd_ppc
.xword stfdu_ppc
.xword stfdux_ppc
.xword stfdx_ppc
.xword stfiwx_ppc
.xword stfs_ppc
.xword stfsu_ppc
.xword stfsux_ppc
.xword stfsx_ppc
.xword sth_ppc
.xword sthbrx_ppc
.xword sthu_ppc
.xword sthux_ppc
.xword sthx_ppc
.xword stmw_ppc
.xword stswi_ppc
.xword stswx_ppc
.xword stw_ppc
.xword stwbrx_ppc
.xword stwcxRC_ppc
.xword stwu_ppc
.xword stwux_ppc
.xword stwx_ppc
.xword subf_ppc
.xword subfRC_ppc
.xword subfo_ppc
.xword subfoRC_ppc
.xword subfc_ppc
.xword subfcRC_ppc
.xword subfco_ppc
.xword subfcoRC_ppc
.xword subfe_ppc
.xword subfeRC_ppc
.xword subfeo_ppc
.xword subfeoRC_ppc
.xword subfic_ppc
.xword subfme_ppc
.xword subfmeRC_ppc
.xword subfmeo_ppc
.xword subfmeoRC_ppc
.xword subfze_ppc
.xword subfzeRC_ppc
.xword subfzeo_ppc
.xword subfzeoRC_ppc
.xword sync_ppc
.xword tlbie_ppc
.xword tlbsync_ppc
.xword tw_ppc
.xword twi_ppc
.xword xor_ppc
.xword xorRC_ppc
.xword xori_ppc
.xword xoris_ppc
.xword invalid_ppc

ins_sim_EC:
.asciz "Notice! A checkstop has occurred. View www/artemis.txt for Register details."
.align 2

/*x0 = extracted PPC offsets ptr (holds register NUMBERS, not values, and holds IMMS)
w1 = PPC key/ident*/

.globl execute
execute:
/*Prologue*/
stp fp, lr, [sp, -0x20]!
stp x19, x20, [sp, 0x10]
mov fp, sp

/*backup Args*/
mov x19, x0
mov w20, w1

/*Preset hacky checkstop flag*/
mov w0, 0
strb w0, [x27, checkstop_flag]

/*Check if PC (instruction addr) is valid*/
bl verify_instruction_ea
cbz w0, 0x10

/*EA was bad, called the return addr that was given back*/
blr x0
b 0x1C

/*Set hacky other flags*/
bl set_loadstoretouch_flags

/*Take the w1 value and multiply by 8*/
/*Then add that result to func_table index to get exact function addr to call*/
lsl w20, w20, 3
adr x2, func_table
ldr x2, [x2, x20]
ldr x1, [x27, 0x20] /*Get Reg Bank ptr*/
mov x0, x19
blr x2 /*x0 now set. x0 = extracted PPC off ptr, x1 = register bank ptr*/

/*Grab checkstop flag to return to parent*/
ldrb w0, [x27, checkstop_flag]

/*Epilogue*/
ldp fp, lr, [sp], 0x20
ret

#include "global/ins/subfinal/pcrcoe.S" //Must be established before all other funcs below
#include "global/ins/branch.S"
#include "global/ins/floats.S"
#include "global/ins/load_float.S"
#include "global/ins/load_int.S"
#include "global/ins/logical.S"
#include "global/ins/store_float.S"
#include "global/ins/store_int.S"
#include "global/ins/other.S"
#include "global/ins/paired_singles.S"
#include "global/ins/parameter.S"

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


ins_sim_EC:
.asciz "Error! Something bad happened during the instruction execution. It's 1: A checkstop occurred on a Machine Check when Machine Checks were disabled. 2: A checkstop that bypasses Machine Checks occurred. 3: Unknown error occurred."
.align 2

/*x0 = extracted PPC offsets ptr (holds register NUMBERS, not values, and holds IMMS)
x1 = PPC key/ident*/

.globl execute
execute:
/*Prologue*/
stp fp, lr, [sp, -0x10]!
mov fp, sp

/*Take the w1 value and multiply by 8*/
/*Then add that result to func_table index to get exact function addr to call*/
lsl w1, w1, 3
adr x2, func_table
ldr x2, [x2, x1]
ldr x1, [x27, 0x20] /*Get Reg Bank ptr*/
blr x2 /*x0 already set. x0 = extracted PPC off ptr, x1 = register bank ptr*/
mov w0, 0 /*TODO in way future, edit this for machine checks and checkstops*/

/*Epilogue*/
execute_epilogue:
ldp fp, lr, [sp], 0x10
ret

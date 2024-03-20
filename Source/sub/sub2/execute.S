#include "global/ins/parameter.S"
#include "global/ins/load.S"
#include "global/ins/store.S"
#include "global/ins/other.S"

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

ins_sim_EC:
.asciz "Error! Something bad happened during the instruction execution. It's 1: A checkstop occurred on a Machine Check when Machine Checks were disabled. 2: A checkstop that bypasses Machine Checks occurred. 3: Unknown error occurred."
.align 2

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
ldr x1, [x27, 0x20] /*load register bank ptr*/
blr x2 /*x0 already set*/
mov w0, 0 /*TODO in way future, edit this for machine checks and checkstops*/

/*Epilogue*/
ldp fp, lr, [sp], 0x10
ret

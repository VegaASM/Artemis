#include "disassemble.S"
#include "execute.S"
#include "writeartemisstrings.S"
#include "convertregisters.S"
#include "write_artemis_txt.S"

/*This func is the main overview of simulating (stepping) 1 instruction
This is used at the very start of the emulation (but skipping execute.S)
and used for every step
x0 (only arg) is a bool
0 = no execute
1 = execute
*/

.globl instruction_simulate_main
instruction_simulate_main:
/*Prologue*/
/*0x40 thru 0x6F = buffer for 1st ins str
0x70 thru 9F = buffer for 2nd ins str
0xA0 thru 10F = buffer for extracted items from PPC instructions
*/
stp fp, lr, [sp, -0x120]!
stp x19, x20, [sp, 0x10]
stp x21, x22, [sp, 0x20]
stp x23, x24, [sp, 0x30]
mov fp, sp

/*Backup arg*/
mov w19, w0

/*Grab ppc-mem address from PC and convert to real address*/
ldr x0, [x27, 0x20]
ldr w0, [x0, pc]
bl convert
mov x20, x0
/*Disassemble PC's instruction*/
/*x0 = place to dump*/
/*w1 = instruction to disassemble*/
/*x2 = extracted PPC items dump spot*/
/*w3 = store extracted items?*/
ldr w1, [x0]
rev w1, w1
add x21, sp, 0x40
mov x0, x21
add x22, sp, 0xA0
mov x2, x22
mov w3, 1
bl disassemble
cbnz w0, ins_sim_main_epilogue /*r0 always returns as non-extended*/
mov w23, w1

/*Disassemble instruction directly below PC*/
/*x0 = place to dump*/
/*w1 = instruction to disassemble*/
/*x2 = extracted PPC items dump spot*/
/*w3 = store extracted items?*/
ldr w1, [x20, 0x4]
rev w1, w1
add x24, sp, 0x70
mov x0, x24
mov w3, 0
bl disassemble
cbnz w0, ins_sim_main_epilogue /*r0 always returns as non-extended*/

/*Check don't execute flag*/
cmp w19, 0
beq call_write_art_strings

/*Step/execute the instruction!*/
/*x0 = extracted ppc items ptr; w1 = instruction "key"*/
mov x0, x22
mov w1, w23
bl execute
cbnz x0, ins_sim_main_epilogue

/*Check if a store instruction of any kind was executed (this includes some cache ops fyi). If not, skip memory.txt crap*/
ldrh w0, [x21]
movz w1, 0x7374 /*st*/
cmp w0, w1 /*Check for standard store instruction*/
beq call_write_mem_txt
movz w1, 0x69
ldrb w0, [x21, 0x2]
cmp w0, w1 /*Check for dcbi*/
beq call_write_mem_txt
mov w1, 0x7A
cmp w0, w1 /*Check for dcbz and dcbz_l*/
bne call_write_art_strings

/*Func that handles creating memory.txt and writes all to it*/
call_write_mem_txt:
bl write_memory_txt
cbnz x0, ins_sim_main_epilogue

/*Write both strings to artemis.txt malloc space*/
/*x0 arg = 1st disassembled ins str pointer*/
/*x1 arg = 2nd disassembled ins str pointer*/
call_write_art_strings:
mov x0, x21
mov x1, x24
bl writeartemisstrings /*No error checks for this func*/

/*Convert all registers to ASCII and write to artemis.txt malloc space*/
/*x0 arg = artemis.txt pointer*/
/*x0 = 0 success; anything else is pointer to print*/
/*if x0 = 0 then w1 returns size*/
ldr x0, [x27, artemistxt_ptr]
bl convertregisters
cbnz x0, ins_sim_main_epilogue

/*Since w0 return code is 0, we have artemis.txt size in w1*/
/*w1 is w1 arg for write_artemis_txt*/
/*Func to file write artemis.txt since all info is now written to its malloc space*/
/*Func will get size and then call fwrite*/
ldr x0, [x27, artemistxt_ptr]
bl write_artemis_txt
/*Return this func's return code directly back to parent*/

/*Epilogue*/
ins_sim_main_epilogue:
ldp x23, x24, [sp, 0x30]
ldp x21, x22, [sp, 0x20]
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x120
ret

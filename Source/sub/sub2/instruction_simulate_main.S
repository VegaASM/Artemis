#include "sub3/symbols_macros/spr_symbols.S" //Must be established before decode_pc_or_pc4.S
#include "decode_pc_or_pc4.S"
#include "disassemble.S"
#include "exceptions.S" //Must be established before execute.S & timers.S
#include "execute.S"
#include "timers.S"
#include "writeartemisstrings.S"
#include "convertregisters.S"
#include "write_artemis_txt.S"

nothing_to_disassemble:
.asciz "No Memory Here."
.align 2

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
0xA0 thru 11F = buffer for extracted items from PPC instructions
*/
stp fp, lr, [sp, -0x120]!
stp x19, x20, [sp, 0x10]
stp x21, x22, [sp, 0x20]
stp x23, x24, [sp, 0x30]
mov fp, sp

/*Backup arg*/
mov w19, w0

/*Process PC EA and get PC Instruction's Real Mem Address*/
ldr x1, [x27, regbank_ptr]
ldr w20, [x1, pc]
mov w0, w20
bl decode_pc_or_pc4
cbnz x0, disa_pc_ins

/*EA couldn't translate to a REAL memory address*/
adr x20, nothing_to_disassemble
b decode_next

/*Disassemble PC's instruction*/
/*x0 = place to dump*/
/*w1 = instruction to disassemble*/
/*x2 = extracted PPC items dump spot*/
/*w3 = store extracted items?*/
disa_pc_ins:
ldr w1, [x0]
add x21, sp, 0x40 /*PC's instruction string buffer*/
add x22, sp, 0xA0 /*Dump buffer for PC's instruction's extracted items*/
rev w1, w1
mov x0, x21
mov x2, x22
mov w3, 1
bl disassemble
cbnz w0, ins_sim_main_epilogue /*r0 always returns as non-extended*/
mov w23, w1

/*Process the EA of PC+4 & get the Instruction*/
decode_next:
add w0, w20, 4
bl decode_pc_or_pc4 /*Must run seperately for PC+4 just incase of crossing a mem boundary*/
cbnz x0, disa_pc4_ins

/*EA couldn't translate to a REAL memory address*/
adr x24, nothing_to_disassemble
b check_execute_flag

/*Disassemble instruction directly below PC*/
/*x0 = place to dump*/
/*w1 = instruction to disassemble*/
/*x2 = extracted PPC items dump spot; ignored if w3 = 0*/
/*w3 = store extracted items?*/
disa_pc4_ins:
ldr w1, [x20, 0x4]
add x24, sp, 0x70
rev w1, w1
mov x0, x24
mov w3, 0
bl disassemble
cbnz w0, ins_sim_main_epilogue /*r0 always returns as non-extended*/

/*Check don't execute flag*/
check_execute_flag:
cmp w19, 0
beq call_write_art_strings

/*Step/execute the instruction!*/
/*x0 = extracted ppc items ptr; w1 = instruction "key"*/
/*w0 returns checkstop flag. 0 = no; 1 = yes, do checkstop*/
mov x0, x22
mov w1, w23
bl execute
cbnz x0, ins_sim_main_epilogue

/*Decrement Instruction Counter*/
subs w26, w26, 1
bne 0x10

/*Update Timers and call Decrementer if required*/
bl update_timebase
bl update_decrementer
mov w26, 4

/*Check if a store instruction of any kind was executed (this includes some cache ops fyi). If not, skip memory.txt crap*/
cmp w23, stwx_ident
bhi call_write_art_strings
cmp w23, dcbi_ident
blo call_write_art_strings
cmp w23, stb_ident
bhi call_write_mem_txt
cmp w23, psq_st_ident
blo 0xC
cmp w23, psq_stx_ident
bls call_write_mem_txt
cmp w23, dcbi_ident
beq call_write_mem_txt
cmp w23, dcbz_ident
beq call_write_mem_txt
cmp w23, dcbz_l_ident
bne call_write_art_strings

/*Func that handles creating memory.txt and writes all to it*/
call_write_mem_txt:
bl write_memory_txt
cbnz x0, ins_sim_main_epilogue

/*Write both strings to artemis.txt malloc space*/
/*x0 arg = 1st disassembled ins str pointer*/
/*x1 arg = 2nd disassembled ins str pointer*/
call_write_art_strings:
mov x0, x20
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

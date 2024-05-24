#include "sub2/write_memory_txt.S"
#include "sub2/instruction_simulate_main.S"
#include "console_input.S"

/*This func is basically a root func that will do all the simulation, console i/o's, and file i/o's. This func should never end whenever the emulation is running proper*/

txtartname:
.asciz "www/artemis.txt"
txtwb:
.asciz "wb"
artopenshit:
.asciz "Error! Unable to delete or remake new artemis.txt. Check your Operating System permissions.\n\n"
memopenshit:
.asciz "Error! Unable to delete or remake or write to new memory.txt. Check your Operating System permissions.\n\n"
input_error_msg:
.asciz "You must either enter 's' for simulate, or 'e' for exit. Try again.\n\n"
program_killed:
.asciz "You've exited the simulation. Thank you for using Artemis.\n\n"
successOUTPUT:
.asciz "Instruction has been simulated/stepped. View/refresh www/artemis.txt & www/memory txt for changes.\n\n"
welcomeMSG:
.asciz "Welcome to Artemis!\n\nVersion: 0.0-r056\n\nEnter 's' to simulate one instruction (step in). Enter 'e' to exit.\n\n"
fgets_error:
.asciz "Error! The fgets function failed when retrieving the Console's input.\n\n"
.align 2

.globl submain
submain:
/*Prologue*/
stp fp, lr, [sp, -0x10]!
mov fp, sp

/*Delete & Create new artemis.txt*/
adr x0, txtartname
bl remove /*No Error check because it's a force-no-matter-what deletion*/
adr x0, txtartname
adr x1, txtwb
bl fopen
cbz x0, can_remake_artemis_txt
bl fclose

/*Delete & Create new memory.txt. Then fill it with all of memory contents. This takes awhile*/
bl write_memory_txt
cbnz x0, cant_remake_memory_txt

/*Welcome Message*/
adr x0, welcomeMSG

emulation_root_loop:
bl puts

/*Call instruction_simulate_main but with the dont execute flag (0)*/
mov w0, 0
bl instruction_simulate_main
cbnz x0, submain_epilogue

/*Take in user's console input*/
bl console_input
cbz w0, fgetsEC /*r0 result will never come back as extended*/
cmp w0, 0x73 /*s*/
beq 0x14 /*Time to simulate!*/
cmp w0, 0x65 /*e*/
bne input_error

/*User wants to terminate Artemis, end program*/
adr x0, program_killed
b submain_epilogue

/*User wants to simulate next instruction, do it*/
mov w0, 1
bl instruction_simulate_main
cbnz x0, submain_epilogue

/*Print success output to terminal*/
adr x0, successOUTPUT
b emulation_root_loop

input_error:
adr x0, input_error_msg
b emulation_root_loop

fgetsEC:
adr x0, fgets_error
b submain_epilogue

cant_remake_memory_txt:
adr x0, memopenshit
b submain_epilogue

can_remake_artemis_txt:
adr x0, artopenshit

/*Epilogue*/
submain_epilogue:
ldp fp, lr, [sp], 0x10
ret

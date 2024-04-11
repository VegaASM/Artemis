/*This func (void) applies all settings from the config.txt file.*/

config_filepath:
.asciz "config/config.txt"
config_perms:
.asicz "rb"
cant_open_config_txtEC:
.asciz "Error! Can't open config.txt. Check your operating system permissions."
cant_dump_config_txtEC:
.asciz "Error! Can't dump config.txt to memory."
config_errorEC:
.asciz "Internal Error! There is something wrong with your config.txt file. Please repair it! Artemis now shutting down..."
.align 2

.set carriage, 0xD
.set enter, 0xA
.set comment, 0x23
.set space, 0x20
.set tab, 0x9
.set broa, 0x62726F61

.globl config_file_parser
config_file_parser:
/*Prologue*/
stp fp, lr, [sp, -0x30]!
stp x19, x20, [sp, 0x10]
str x21, [sp, 0x20]
mov fp, sp

/*Open config.txt with read perms*/
adr x0, config_filepath
adr x1, config_perms
bl fopen
cbz cant_open_config_txt
mov x19, x0

/*Get size of config.txt*/
mov w1, 0
mov w2, 2
bl fseek
cbnz cant_fseek_config_txt
mov x0, x19
bl ftell
mov w20, w0
mov x0, x19
bl rewind

/*Allocate mem for config.txt*/
mov w0, w20
bl malloc
cbz cant_allocmem_config_txt
mov x21, x0

/*Dump config.txt then close it*/
mov w1, 1
mov w2, w20
mov x3, x19
bl fread
cmp w0, w20
bne fread_failure_config_txt
mov x0, x19
bl fclose
cbnz cant_close_config_txt

/*Change all carriages, if they exist, to basic 8-bit enters (0xA)*/
mov x0, x21
ldrb w0, [x21], 1
cmp w0, carriage
bne -0x8
mov w0, enter
strb w0, [x21]
b -0x14

/*Change all comment related chars to spaces*/
mov x0, x21
mov w1, space
comment_parser_loop:
ldrb w2, [x0], 1
cmp w2, 0
beq grab_setting
cmp w2, comment
bne comment_parser_loop

/*Found a comment, turn its chars to spaces til we hit new line (enter)*/
strb w1, [x0] /*Get rid of the hashtag first*/
/*Now check for enter, once we hit, go back to comment_parser_loop*/
ldrb w2, [x0], 1
cmp w2, enter
beq comment_parser_loop
strb w1, [x0]
b -0x10

/*Grab setting*/
grab_setting:
ldr w0, [x21], 1
cmp w0, 0
beq config_error
cmp w0, space
beq grab_setting
cmp w0, comment
beq grab_setting
cmp w0, enter
beq grab_setting
cmp w0, tab
beq grab_setting
cmp w0, 0x30
blo config_error
cmp w0, 0x34
bhi config_error

/*Store setting to array table*/
strb w0, [x27, 0x68]

/*Set success return value*/
mov w0, 0
b config_file_parser_epilogue

cant_open_config_txt:
adr x0, cant_open_config_txtEC
b config_file_parser_epilogue

cant_fseek_config_txt:
adr x0, cant_fseek_config_txtEC
b config_file_parser_epilogue

cant_allocmem_config_txt:
adr x0, cant_allocmem_config_txtEC
b config_file_parser_epilogue

fread_failure_config_txt:
adr x0, fread_failure_config_txtEC
deallocate_config_txt:
mov x0, x21
bl free
b config_file_parser_epilogue

cant_close_config_txt:
adr x0, cant_close_config_txtEC
b deallocate_config_txt

config_error:
adr x0, config_errorEC
b deallocate_config_txt

config_file_parser_epilogue:
ldr x21, [sp, 0x20]
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x30
ret

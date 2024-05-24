#include "data_ea_to_pa_plus_verify.S"
#include "is_pa_in_dcache.S"
#include "add_to_dcache.S"
#include "dcache_algo_update_no_snoops.S"
#include "dcache_algo_update_yes_snoops.S"

/*Args
w0 = PA
w1 = read/write (0 = read, 1 = write)
Return Values
w0 = 0 Success
w0 = -1 Error (PPC exception was ran)
*/

.globl dcache_main
dcache_main:
/*Prologue*/
stp fp, lr, [sp, -0x30]!
stp x19, x20, [sp, 0x10]
stp x21, x22, [sp, 0x20]
mov fp, lr

/*Backup args*/
mov w19, w0
mov w20, w1

/*Make sure EA is legit*/
bl data_ea_to_pa_plus_verify
cbz w0, dcache_main_ppc_exception_call

/*Are we enforcing MEI coherency?*/
ldr x1, [x27, batsave_ptr]
ubfx x21, x1, 4, 1

/*Is PA in DCache?*/
mov w0, w19
bl is_pa_in_dcache
cbnz w0, 0x10
mov w22, w0

/*It's not, add to DCache*/
mov w0, w19
bl add_to_dcache

/*Based on IBAT M bit, call snoop func or non-snoop func*/
mov w0, w19
mov w1, w22
mov w2, w20
cbnz w21, 0xC
bl dcache_algo_update_no_snoops
b 0x8
bl dcache_algo_update_yes_snoops
mov w0, 0 /*Success return code*/

/*Epilogue*/
dcache_main_epilogue:
ldp x21, x22, [sp, 0x20]
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x30
ret

/*Run a PPC exception and then return right back to parent*/
dcache_main_ppc_exception_call:
mov w0, w1
blr x18
mov w0, -1 /*Error return code, PPC exception had to be executed*/
b dcache_main_epilogue

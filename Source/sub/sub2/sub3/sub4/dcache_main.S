#include "data_ea_to_pa_plus_verify.S"
#include "is_pa_in_dcache.S"
#include "add_to_dcache.S"
#include "dcache_algo_update_snoops.S"

/*Args
w0 = EA
w1 = read/write (0 = read, 1 = write)
Return Values
x0 = real OS mem addr
x0 = 0 = error (PPC exception was ran)
*/

.globl dcache_main
dcache_main:
/*Prologue*/
stp fp, lr, [sp, -0x40]!
stp x19, x20, [sp, 0x10]
stp x21, x22, [sp, 0x20]
str x23, [sp, 0x30]
mov fp, lr

/*Backup w1 arg*/
mov w19, w1

/*Make sure EA represents a legit PA
w0 = EA, w1 = Read(0)/Write(1) bool
w0 returns 1 for sucess, 0 for failure
if sucess w1 = PA; if failure, x18 = exception func and w1 = exception func arg*/
bl data_ea_to_pa_plus_verify
cbz w0, dcache_main_ppc_exception_call
mov w20, w1 /*Backup PPC PA*/

/*Is Real Mode on? If so, then WIMG is read as 0b0011*/
ldr x1, [x27, regbank_ptr]
ldr w0, [x1, msr]
tbz w0, msr_dr_b, call_is_pa_in_dcache

/*Is Cache enabled via BAT WIMG I? TODO page tables*/
ldr x21, [x27, batsave_ptr]
tbnz x21, bat_wimg_i_b, convert_dppcea_to_realmemaddr

/*Is PA in DCache?
w0 = PPC PA
w0 returns bool. 1 for hit, 0 for miss, -1 for locked
if w0 returns 1, x1 has real OS mem addr*/
call_is_pa_in_dcache:
mov w0, w19
bl is_pa_in_dcache
cbnz w0, 0x10
mov w22, w0
mov x23, x1

/*It's not, add to DCache
w0 = PPC PA
x0 returns real OS mem addr*/
mov w0, w19
bl add_to_dcache
mov x23, x0

/*Based on IBAT M bit, call snoop func or not*/
tbnz x21, bat_wimg_m_b, provide_parent_with_cache_OSmemaddr
mov w0, w19
mov w1, w22
mov w2, w20
bl dcache_algo_update_snoops

provide_parent_with_cache_OSmemaddr:
mov x0, x23
b dcache_main_epilogue

/*Convert PPC PA to real OS Mem Addr*/
convert_dppcea_to_realmemaddr:
mov w0, w20
bl convert

/*Epilogue*/
dcache_main_epilogue:
ldr x23, [sp, 0x30]
ldp x21, x22, [sp, 0x20]
ldp x19, x20, [sp, 0x10]
ldp fp, lr, [sp], 0x40
ret

/*Run a PPC exception and then return right back to parent*/
dcache_main_ppc_exception_call:
mov w0, w1
blr x18
mov w0, 0 /*Error return code, PPC exception had to be executed*/
b dcache_main_epilogue

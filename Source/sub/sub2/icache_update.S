#include "sub3/sub4/is_pa_in_icache.S"
#include "sub3/sub4/add_to_icache.S"

/*w0 = PA
w1 = Hit/Miss
w2 = Write/Read*/
.globl icache_update
icache_update:
/*Prologue*/
stp fp, lr, [sp, -0x20]!
str x19, [sp, 0x10]
mov fp, lr

/*Is PA in I-Cache?
w0 = PA
x0 returns ptr to cache entry buffer if found
x0 = 0 if not found*/
bl is_pa_in_icache
cbz x0, 0xC

/*Not in I-Cache, add it
w0 = PA
No return value*/
mov w0, w19
bl add_to_icache

/*Epilogue*/
ldr x19, [sp, 0x10]
ldp fp, lr, [sp], 0x20
ret

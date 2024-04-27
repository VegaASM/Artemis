/*w0 = physical EA
w0 returns 1 for good
w0 returns 0 for bad*/

.globl verify_physical_ea
verify_physical_ea:
cmp w0, mem1_base
blo bad_physical_ea
movz w2, :abs_g1: mem2_top
movk w2, :abs_g0_nc: mem2_top
cmp w0, w2
bhi bad_physical_ea
mov w2, mem2_base
cmp w0, w2
bhi good_physical_ea
movz w2, :abs_g1: mem1_top
movk w2, :abs_g0_nc: mem1_top
cmp w0, w2
bhi bad_physical_ea

good_physical_ea:
mov w0, 1
ret

bad_physical_ea:
mov w0, 0
ret

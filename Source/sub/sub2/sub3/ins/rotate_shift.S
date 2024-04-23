//rlwimi rA, rS, SH, MB, ME
.globl rlwimi_ppc
rlwimi_ppc:
ldr w2, [x0, rAoff] //load rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //load rS number
lsl w3, w3, 2
ldr w3, [x1, x3] //load rS value
ldr w4, [x0, SHoff] //load SH value
ldr w5, [x0, MBoff] //load MB value
ldr w6, [x0, MEoff] //load ME value
sub w4, w4, 32
neg w4, w4
ror w3, w3, w4 //rotate left via SH
//Is ME > MB
//If so we gotta make sure chain of bits "wraps" around when going from big endian bit 31 back over to bit 0
cmp w5, w6
bhi ME_higherthan_MBrlwimi
//First, set a signed mask using ME's value
mov w7, 0x80000000
asr w7, w7, w6
//Next, set a all bits high mask
mov w8, 0xFFFFFFFF
//Now, shift this mask to the right depending on MB's real value
lsr w8, w8, w5
b and_temp_masksrlwimi
ME_higherthan_MBrlwimi:
//First, set signed mask using MB's value
mov w7, 0x80000000
asr w7, w7, w5
//Next, set a all bits high mask
mov w8, 0xFFFFFFFF
//Now, shift this mask to the right depending on ME's real value
lsr w8, w8, w6
//And both masks together to get instruction's actual mask
and_temp_masksrlwimi:
and w7, w7, w8
//w7 has Mask, load rA
ldr w10, [x1, x2]
//newrA = (rA & mask) | (rS & !mask)
and w10, w10, w7
mvn w7, w7
and w3, w3, w7
orr w3, w10, w3
str w3, [x1, x2] //rlwimi::ppc
pc_adjust 0x4
ret

//rlwimi. rA, rS, SH, MB, ME
.globl rlwimiRC_ppc
rlwimiRC_ppc:
ldr w2, [x0, rAoff] //load rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //load rS number
lsl w3, w3, 2
ldr w3, [x1, x3] //load rS value
ldr w4, [x0, SHoff] //load SH value
ldr w5, [x0, MBoff] //load MB value
ldr w6, [x0, MEoff] //load ME value
sub w4, w4, 32
neg w4, w4
ror w3, w3, w4 //rotate left via SH
//Is ME > MB
//If so we gotta make sure chain of bits "wraps" around when going from big endian bit 31 back over to bit 0
cmp w5, w6
bhi ME_higherthan_MBrlwimiRC
//First, set a signed mask using ME's value
mov w7, 0x80000000
asr w7, w7, w6
//Next, set a all bits high mask
mov w8, 0xFFFFFFFF
//Now, shift this mask to the right depending on MB's real value
lsr w8, w8, w5
b and_temp_masksrlwimiRC
ME_higherthan_MBrlwimiRC:
//First, set signed mask using MB's value
mov w7, 0x80000000
asr w7, w7, w5
//Next, set a all bits high mask
mov w8, 0xFFFFFFFF
//Now, shift this mask to the right depending on ME's real value
lsr w8, w8, w6
//And both masks together to get instruction's actual mask
and_temp_masksrlwimiRC:
and w7, w7, w8
//w7 has Mask, load rA
ldr w10, [x1, x2]
//newrA = (rA & mask) | (rS & !mask)
and w10, w10, w7
mvn w7, w7
and w3, w3, w7
orr w3, w10, w3
str w3, [x1, x2] //rlwimiRC::ppc
record_feature w3
pc_adjust 0x4
ret

//rlwinm rA, rS, SH, MB, ME
.globl rlwinm_ppc
rlwinm_ppc:
ldr w2, [x0, rAoff] //load rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //load rS number
lsl w3, w3, 2
ldr w3, [x1, x3] //load rS value
ldr w4, [x0, SHoff] //load SH value
ldr w5, [x0, MBoff] //load MB value
ldr w6, [x0, MEoff] //load ME value
sub w4, w4, 32
neg w4, w4
ror w3, w3, w4 //rotate left via SH
//Is ME > MB
//If so we gotta make sure chain of bits "wraps" around when going from big endian bit 31 back over to bit 0
cmp w5, w6
bhi ME_higherthan_MBrlwinm
//First, set a signed mask using ME's value
mov w7, 0x80000000
asr w7, w7, w6
//Next, set a all bits high mask
mov w8, 0xFFFFFFFF
//Now, shift this mask to the right depending on MB's real value
lsr w8, w8, w5
b and_temp_masksrlwinm
ME_higherthan_MBrlwinm:
//First, set signed mask using MB's value
mov w7, 0x80000000
asr w7, w7, w5
//Next, set a all bits high mask
mov w8, 0xFFFFFFFF
//Now, shift this mask to the right depending on ME's real value
lsr w8, w8, w6
//And both masks together to get instruction's actual mask
and_temp_masksrlwinm:
and w7, w7, w8
//Now apply the mask and we're done
and w3, w3, w7
str w3, [x1, x2] //rlwinm::ppc
pc_adjust 0x4
ret

//rlwinm. rA, rS, SH, MB, ME
.globl rlwinmRC_ppc
rlwinmRC_ppc:
ldr w2, [x0, rAoff] //load rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //load rS number
lsl w3, w3, 2
ldr w3, [x1, x3] //load rS value
ldr w4, [x0, SHoff] //load SH value
ldr w5, [x0, MBoff] //load MB value
ldr w6, [x0, MEoff] //load ME value
sub w4, w4, 32
neg w4, w4
ror w3, w3, w4 //rotate left via SH
//Is ME > MB
//If so we gotta make sure chain of bits "wraps" around when going from big endian bit 31 back over to bit 0
cmp w5, w6
bhi ME_higherthan_MBrlwinmRC
//First, set a signed mask using ME's value
mov w7, 0x80000000
asr w7, w7, w6
//Next, set a all bits high mask
mov w8, 0xFFFFFFFF
//Now, shift this mask to the right depending on MB's real value
lsr w8, w8, w5
b and_temp_masksrlwinmRC
ME_higherthan_MBrlwinmRC:
//First, set signed mask using MB's value
mov w7, 0x80000000
asr w7, w7, w5
//Next, set a all bits high mask
mov w8, 0xFFFFFFFF
//Now, shift this mask to the right depending on ME's real value
lsr w8, w8, w6
//And both masks together to get instruction's actual mask
and_temp_masksrlwinmRC:
and w7, w7, w8
//Now apply the mask and we're done
and w3, w3, w7
str w3, [x1, x2] //rlwinmRC::ppc
pc_adjust 0x4
record_feature w3
ret

//rlwnm rA, rS, rB, MB, ME
.globl rlwnm_ppc
rlwnm_ppc:
ldr w2, [x0, rAoff] //load rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //load rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //load rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //load rS value
ldr w4, [x1, x4] //load rB value
ldr w5, [x0, MBoff] //load MB value
ldr w6, [x0, MEoff] //load ME value
sub w4, w4, 32
neg w4, w4
ror w3, w3, w4 //rotate left via rB
//Is ME > MB
//If so we gotta make sure chain of bits "wraps" around when going from big endian bit 31 back over to bit 0
cmp w5, w6
bhi ME_higherthan_MBrlwnm
//First, set a signed mask using ME's value
mov w7, 0x80000000
asr w7, w7, w6
//Next, set a all bits high mask
mov w8, 0xFFFFFFFF
//Now, shift this mask to the right depending on MB's real value
lsr w8, w8, w5
b and_temp_masksrlwnm
ME_higherthan_MBrlwnm:
//First, set signed mask using MB's value
mov w7, 0x80000000
asr w7, w7, w5
//Next, set a all bits high mask
mov w8, 0xFFFFFFFF
//Now, shift this mask to the right depending on ME's real value
lsr w8, w8, w6
//And both masks together to get instruction's actual mask
and_temp_masksrlwnm:
and w7, w7, w8
//Now apply the mask and we're done
and w3, w3, w7
str w3, [x1, x2] //rlwnm::ppc
pc_adjust 0x4
ret

//rlwnm. rA, rS, rB, MB, ME
.globl rlwnmRC_ppc
rlwnmRC_ppc:
ldr w2, [x0, rAoff] //load rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //load rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //load rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //load rS value
ldr w4, [x1, x4] //load rB value
ldr w5, [x0, MBoff] //load MB value
ldr w6, [x0, MEoff] //load ME value
sub w4, w4, 32
neg w4, w4
ror w3, w3, w4 //rotate left via rB
//Is ME > MB
//If so we gotta make sure chain of bits "wraps" around when going from big endian bit 31 back over to bit 0
cmp w5, w6
bhi ME_higherthan_MBrlwnmRC
//First, set a signed mask using ME's value
mov w7, 0x80000000
asr w7, w7, w6
//Next, set a all bits high mask
mov w8, 0xFFFFFFFF
//Now, shift this mask to the right depending on MB's real value
lsr w8, w8, w5
b and_temp_masksrlwnmRC
ME_higherthan_MBrlwnmRC:
//First, set signed mask using MB's value
mov w7, 0x80000000
asr w7, w7, w5
//Next, set a all bits high mask
mov w8, 0xFFFFFFFF
//Now, shift this mask to the right depending on ME's real value
lsr w8, w8, w6
//And both masks together to get instruction's actual mask
and_temp_masksrlwnmRC:
and w7, w7, w8
//Now apply the mask and we're done
and w3, w3, w7
str w3, [x1, x2] //rlwnmRC::ppc
pc_adjust 0x4
ret

//slw rA, rS, rB
.globl slw_ppc
slw_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
lsl w3, w3, w4 //slw::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//slw. rA, rS, rB
.globl slwRC_ppc
slwRC_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
lsl w3, w3, w4 //slwRC::ppc
str w3, [x1, x2] //write rA
record_feature w3
pc_adjust 0x4
ret

//sraw rA, rS, rB
.globl sraw_ppc
sraw_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w5, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
asr w3, w5, w4 //sraw::ppc
str w3, [x1, x2] //write rA
//Update Xer[CA]
ldr w0, [x1, xer]
//Find lsb high bit of rS
//Count trailing zeroes
rbit w5, w5
clz w5, w5
//Does rB shift amount exceed trailing zeroes of rS?
//If so, set CA. Otherwise clear
cmp w4, w5
bhi 0xC
bfc w0, 29, 1
b 0x8
orr w0, w0, 0x20000000
str w0, [x1, xer]
pc_adjust 0x4
ret

//sraw. rA, rS, rB
.globl srawRC_ppc
srawRC_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
asr w3, w3, w4 //srawRC::ppc
str w3, [x1, x2] //write rA
//Update Xer[CA]
ldr w0, [x1, xer]
//Find lsb high bit of rS
//Count trailing zeroes
rbit w5, w5
clz w5, w5
//Does rB shift amount exceed trailing zeroes of rS?
//If so, set CA. Otherwise clear
cmp w4, w5
bhi 0xC
bfc w0, 29, 1
b 0x8
orr w0, w0, 0x20000000
str w0, [x1, xer]
record_feature w3
pc_adjust 0x4
ret

//srawi rA, rS, SH
.globl srawi_ppc
srawi_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, SHoff] //get SH value
ldr w3, [x1, x3] //grab rS's value
asr w3, w3, w4 //srawi::ppc
str w3, [x1, x2] //write rA
//Update Xer[CA]
ldr w0, [x1, xer]
//Find lsb high bit of rS
//Count trailing zeroes
rbit w5, w5
clz w5, w5
//Does SH shift amount exceed trailing zeroes of rS?
//If so, set CA. Otherwise clear
cmp w4, w5
bhi 0xC
bfc w0, 29, 1
b 0x8
orr w0, w0, 0x20000000
str w0, [x1, xer]
pc_adjust 0x4
ret

//srawi. rA, rS, SH
.globl srawiRC_ppc
srawiRC_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, SHoff] //get SH value
ldr w3, [x1, x3] //grab rS's value
asr w3, w3, w4 //srawi::ppc
str w3, [x1, x2] //write rA
//Update Xer[CA]
ldr w0, [x1, xer]
//Find lsb high bit of rS
//Count trailing zeroes
rbit w5, w5
clz w5, w5
//Does SH shift amount exceed trailing zeroes of rS?
//If so, set CA. Otherwise clear
cmp w4, w5
bhi 0xC
bfc w0, 29, 1
b 0x8
orr w0, w0, 0x20000000
str w0, [x1, xer]
record_feature w3
pc_adjust 0x4
ret

//srw rA, rS, rB
.globl srw_ppc
srw_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
lsr w3, w3, w4 //srw::ppc
str w3, [x1, x2] //write rA
pc_adjust 0x4
ret

//srw. rA, rS, rB
.globl srwRC_ppc
srwRC_ppc:
ldr w2, [x0, rAoff] //get rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //get rS number
lsl w3, w3, 2
ldr w4, [x0, rBoff] //get rB number
lsl w4, w4, 2
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
lsr w3, w3, w4 //srw::ppc
str w3, [x1, x2] //write rA
record_feature w3
pc_adjust 0x4
ret

//rlwimi rA, rS, SH, MB, ME
.globl rlwimi_ppc
rlwimi_ppc:
ldr w2, [x0, rAoff] //load rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //load rS number
lsl w3, w3, w2
ldr w3, [x1, x3] //load rS value
ldr w4, [x0, SHoff] //load SH value
ldr w5, [x0, MBoff] //load MB value
ldr w6, [x0, MEoff] //load ME value
sub w4, w4, 32
neg w4, w4
ror w3, w3, w4 //rotate left via SH
//TODO calc how to do mask start and end..
pc_adjust 0x4
ret

//rlwimi. rA, rS, SH, MB, ME
.globl rlwimiRC_ppc
rlwimiRC_ppc:
ldr w2, [x0, rAoff] //load rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //load rS number
lsl w3, w3, w2
ldr w3, [x1, x3] //load rS value
ldr w4, [x0, SHoff] //load SH value
ldr w5, [x0, MBoff] //load MB value
ldr w6, [x0, MEoff] //load ME value
sub w4, w4, 32
neg w4, w4
ror w3, w3, w4 //rotate left via SH
//TODO calc how to do mask start and end..
pc_adjust 0x4
ret

//rlwinm rA, rS, SH, MB, ME
.globl rlwinm_ppc
rlwinm_ppc:
ldr w2, [x0, rAoff] //load rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //load rS number
lsl w3, w3, w2
ldr w3, [x1, x3] //load rS value
ldr w4, [x0, SHoff] //load SH value
ldr w5, [x0, MBoff] //load MB value
ldr w6, [x0, MEoff] //load ME value
sub w4, w4, 32
neg w4, w4
ror w3, w3, w4 //rotate left via SH
//TODO calc how to do mask start and end..
pc_adjust 0x4
ret

//rlwinm. rA, rS, SH, MB, ME
.globl rlwinmRC_ppc
rlwinmRC_ppc:
ldr w2, [x0, rAoff] //load rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //load rS number
lsl w3, w3, w2
ldr w3, [x1, x3] //load rS value
ldr w4, [x0, SHoff] //load SH value
ldr w5, [x0, MBoff] //load MB value
ldr w6, [x0, MEoff] //load ME value
sub w4, w4, 32
neg w4, w4
ror w3, w3, w4 //rotate left via SH
//TODO calc how to do mask start and end..
pc_adjust 0x4
ret

//rlwnm rA, rS, SH, MB, ME
.globl rlwnm_ppc
rlwnm_ppc:
ldr w2, [x0, rAoff] //load rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //load rS number
lsl w3, w3, w2
ldr w4, [x0, rBoff] //load rB number
ldr w3, [x1, x3] //load rS value
ldr w4, [x1, x4] //load rB value
ldr w5, [x0, MBoff] //load MB value
ldr w6, [x0, MEoff] //load ME value
sub w4, w4, 32
neg w4, w4
ror w3, w3, w4 //rotate left via SH
//TODO calc how to do mask start and end..
pc_adjust 0x4
ret

//rlwnm. rA, rS, SH, MB, ME
.globl rlwnmRC_ppc
rlwnmRC_ppc:
ldr w2, [x0, rAoff] //load rA number
lsl w2, w2, 2
ldr w3, [x0, rSoff] //load rS number
lsl w3, w3, w2
ldr w4, [x0, rBoff] //load rB number
ldr w3, [x1, x3] //load rS value
ldr w4, [x1, x4] //load rB value
ldr w5, [x0, MBoff] //load MB value
ldr w6, [x0, MEoff] //load ME value
sub w4, w4, 32
neg w4, w4
ror w3, w3, w4 //rotate left via SH
//TODO calc how to do mask start and end..
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
ldr w3, [x1, x3] //grab rS's value
ldr w4, [x1, x4] //grab rB's value
asr w3, w3, w4 //sraw::ppc
str w3, [x1, x2] //write rA
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

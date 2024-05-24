//note some of these will go unused, todo add the rest

//IABR
.set iabr_be, 0x00000002
.set iabr_te, 0x00000001

//HID0
.set hid0_emcp, 0x80000000
.set hid0_dbp, 0x40000000
.set hid0_eba, 0x20000000
.set hid0_edb, 0x10000000
.set hid0_bclk, 0x08000000
.set hid0_eclk, 0x02000000
.set hid0_par, 0x01000000
.set hid0_doze, 0x00800000
.set hid0_nap, 0x00400000
.set hid0_sleep, 0x00200000
.set hid0_dpm, 0x00100000
.set hid0_nhr, 0x00010000
.set hid0_ice, 0x00008000
.set hid0_dce, 0x00004000
.set hid0_ilock, 0x00002000
.set hid0_dlock, 0x00001000
.set hid0_icfi, 0x00000800
.set hid0_dcfi, 0x00000400
.set hid0_spd, 0x00000200
.set hid0_ifem, 0x00000100
.set hid0_sge, 0x00000080
.set hid0_dcfa, 0x00000040
.set hid0_btic, 0x00000020
.set hid0_abe, 0x00000008
.set hid0_bht, 0x00000004
.set hid0_noopti, 0x00000002

.set hid0_ice_b, 15
.set hid0_dce_b, 14

//HID1
.set hid1_pc0, 0x80000000
.set hid1_pc1, 0x40000000
.set hid1_pc2, 0x20000000
.set hid1_pc3, 0x10000000
.set hid1_pc4, 0x08000000

//HID2
.set hid2_lsqe, 0x80000000
.set hid2_wpe, 0x40000000
.set hid2_pse, 0x20000000
.set hid2_lce, 0x10000000
.set hid2_dmaql, 0x0F000000
.set hid2_dcherr, 0x00800000
.set hid2_dncerr, 0x00400000
.set hid2_dcmerr, 0x00200000
.set hid2_dqoerr, 0x00100000
.set hid2_dchee, 0x00080000
.set hid2_dncee, 0x00040000
.set hid2_dcmee, 0x00020000
.set hid2_dqoee, 0x00010000

//HID4
.set hid4_bit0, 0x80000000 //get actual leaked named of this bit later
.set hid4_l2fm, 0x60000000
.set hid4_bpd, 0x18000000
.set hid4_sbe, 0x02000000
.set hid4_st0, 0x01000000
.set hid4_lpe, 0x00800000
.set hid4_dbp, 0x00400000
.set hid4_l2mum, 0x00200000
.set hid2_l2cfi, 0x00100000

//GQR's
.set ld_scale, 0x3F000000
.set ld_type, 0x00070000
.set st_scale, 0x00003F00
.set st_type, 0x00000007

//MSR
.set msr_le, 0x00000001
.set msr_ri, 0x00000002
.set msr_pm, 0x00000004
.set msr_dr, 0x00000010
.set msr_ir, 0x00000020
.set msr_ip, 0x00000040
.set msr_fe1, 0x00000100
.set msr_be, 0x00000200
.set msr_se, 0x00000400
.set msr_fe0, 0x00000800
.set msr_me, 0x00001000
.set msr_fp, 0x00002000
.set msr_pr, 0x00004000
.set msr_ee, 0x00008000
.set msr_ile, 0x00010000
.set msr_pow, 0x00040000

.set msr_pr_b, 14
.set msr_ir_b, 5
.set msr_dr_b, 4

//XER
.set xer_so, 0x80000000
.set xer_ov, 0x40000000
.set xer_ca, 0x20000000
.set xer_bytecount, 0x0000007F

//FPSCR
.set fpscr_fx, 0x80000000
.set fpscr_fex, 0x40000000
.set fpscr_vx, 0x20000000
.set fpscr_ox, 0x10000000
.set fpscr_ux, 0x08000000
.set fpscr_zx, 0x04000000
.set fpscr_xx, 0x02000000
.set fpscr_vxsnan, 0x01000000
.set fpscr_vxisi, 0x00800000
.set fpscr_vxidi, 0x00400000
.set fpscr_vxzdz, 0x00200000
.set fpscr_vximz, 0x00100000
.set fpscr_vxvc, 0x00080000
.set fpscr_fr, 0x00040000
.set fpscr_fi, 0x00020000
.set fpscr_fprf, 0x0001F000
.set fpscr_vxsoft, 0x00000400
.set fpscr_vxsqrt, 0x00000200
.set fpscr_vxcvi, 0x00000100
.set fpscr_ve, 0x00000080
.set fpscr_oe, 0x00000040
.set fpscr_ue, 0x00000020
.set fpscr_ze, 0x00000010
.set fpscr_xe, 0x00000008
.set fpscr_ni, 0x00000004
.set fpscr_rn, 0x00000003

//PVR
.set pvr_version, 0xFFFF0000
.set pvr_revision, 0x0000FFFF

//BAT
.set bat_bepi, 0xFFFC000000000000
.set bat_bl, 0x00001FFC00000000
.set bat_vs, 0x0000000200000000
.set bat_vp, 0x0000000100000000
.set bat_brpn, 0x00000000FFFC0000
.set bat_wimg, 0x0000000000000780
.set bat_wimg_w, 0x0000000000000040
.set bat_wimg_i, 0x0000000000000020
.set bat_wimg_m, 0x0000000000000010
.set bat_wimg_g, 0x0000000000000008
.set bat_pp, 0x0000000000000003

.set bat_wimg_w_b, 6
.set bat_wimg_i_b, 5
.set bat_wimg_m_b, 4
.set bat_wimg_g_b, 3

//SDR1
.set sdr1_htaborg, 0xFFFF0000
.set sdr1_htabmask, 0x000001FFF

//L2CR
.set l2cr_l2e, 0x80000000
.set l2cr_l2ce, 0x40000000
.set l2cr_l2do, 0x00400000
.set l2cr_l2i, 0x00200000
.set l2cr_l2wt, 0x00080000
.set l2cr_l2ts, 0x00040000
.set l2cr_l2ip, 0x00000001

.set l2cr_l2e_b, 31
.set l2cr_l2do_b, 22

//DABR
.set dabr_bt, 0x00000004
.set dabr_dw, 0x00000002
.set dabr_dr, 0x00000001

//EAR
.set ear_e, 0x80000000
.set ear_rid, 0x0000003F

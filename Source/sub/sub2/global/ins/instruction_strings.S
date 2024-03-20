ins_add:
.asciz "add r%d, r%d, r%d"
ins_add_:
.asciz "add. r%d, r%d, r%d"
ins_addo:
.asciz "addo r%d, r%d, r%d"
ins_addo_:
.asciz "addo. r%d, r%d, r%d"

ins_addc:
.asciz "addc r%d, r%d, r%d"
ins_addc_:
.asciz "addc. r%d, r%d, r%d"
ins_addco:
.asciz "addco r%d, r%d, r%d"
ins_addco_:
.asciz "addco. r%d, r%d, r%d"

ins_adde:
.asciz "adde r%d, r%d, r%d"
ins_adde_:
.asciz "adde. r%d, r%d, r%d"
ins_addeo:
.asciz "addeo r%d, r%d, r%d"
ins_addeo_:
.asciz "addeo. r%d, r%d, r%d"

ins_addi:
.asciz "addi r%d, r%d, 0x%X"

ins_addic:
.asciz "addic r%d, r%d, 0x%X"

ins_addic_:
.asciz "addic. r%d, r%d, 0x%X"

ins_addis:
.asciz "addis r%d, r%d, 0x%X"

ins_addme:
.asciz "addme r%d, r%d"
ins_addme_:
.asciz "addme. r%d, r%d"
ins_addmeo:
.asciz "addmeo r%d, r%d"
ins_addmeo_:
.asciz "addmeo. r%d, r%d"

ins_addze:
.asciz "addze r%d, r%d"
ins_addze_:
.asciz "addze. r%d, r%d"
ins_addzeo:
.asciz "addzeo r%d, r%d"
ins_addzeo_:
.asciz "addzeo. r%d, r%d"

ins_and:
.asciz "and r%d, r%d, r%d"
ins_and_:
.asciz "and. r%d, r%d, r%d"

ins_andc:
.asciz "andc r%d, r%d, r%d"
ins_andc_:
.asciz "andc. r%d, r%d, r%d"

ins_andi_:
.asciz "andi. r%d, r%d, 0x%X"

ins_andis_:
.asciz "andis. r%d, r%d, 0x%X"

ins_b:
.asciz "b 0x%X"
ins_ba:
.asciz "ba 0x%X"
ins_bl:
.asciz "bl 0x%X"
ins_bla:
.asciz "bla 0x%X"

//Standard branch conditional mnemonics NOT needed in disassembler
//ins_bc:
//.asciz "bc %d, %d, 0x%X"
//ins_bca:
//.asciz "bca %d, %d, 0x%X"
//ins_bcl:
//.asciz "bcl %d, %d, 0x%X"
//ins_bcla:
//.asciz "bcla %d, %d, 0x%X"
//ins_bcctr:
//.asciz "bcctr %d, %d"
//ins_bcctrl:
//.asciz "bcctrl %d, %d"
//ins_bclr:
//.asciz "bclr %d, %d"
//ins_bclrl:
//.asciz "bclrl %d, %d"

//Standard mnemonics that include the L bit for compare instructions are not needed in disassembler
//ins_cmp:
//.asciz "cmp cr%d, %d, r%d, r%d"
ins_cmpw: //Simplified mnemonic for cmp crX, 0, rX, rY
.asciz "cmpw cr%d, r%d, r%d"
ins_cmpw_cr0:
.asciz "cmpw r%d, r%d"

//ins_cmpi:
//.asciz "cmpi cr%d, %d, r%d, 0x%X"
ins_cmpwi: //Simplified mnemonic for cmpi crX, 0, rX, rY
.asciz "cmpwi cr%d, r%d, 0x%X"
ins_cmpwi_cr0:
.asciz "cmpwi r%d, 0x%X"

//ins_cmpl:
//.asciz "cmpl cr%d, %d, r%d, r%d"
ins_cmplw: //Simplified mnemonic for cmpl crX, 0, rX, rY
.asciz "cmplw cr%d, r%d, r%d"
ins_cmplw_cr0:
.asciz "cmplw r%d, r%d"

//ins_cmpli:
//.asciz "cmpli cr%d, %d, r%d, 0x%X"
ins_cmplwi: //Simplified mnemonic for cmpli crX, 0, rX, rY
.asciz "cmplwi cr%d, r%d, 0x%X"
ins_cmplwi_cr0:
.asciz "cmplwi r%d, 0x%X"

ins_cntlzw:
.asciz "cntlzw r%d, r%d"
ins_cntlzw_:
.asciz "cntlzw. r%d, r%d"

ins_crand:
.asciz "crand %d, %d, %d"

ins_crandc:
.asciz "crandc %d, %d, %d"

ins_creqv:
.asciz "creqv %d, %d, %d"

ins_crnand:
.asciz "crnand %d, %d, %d"

ins_crnor:
.asciz "crnor %d, %d, %d"

ins_cror:
.asciz "cror %d, %d, %d"

ins_crorc:
.asciz "crorc %d, %d, %d"

ins_crxor:
.asciz "crxor %d, %d, %d"

ins_dcbf:
.asciz "dcbf r%d, r%d"

ins_dcbi:
.asciz "dcbi r%d, r%d"

ins_dcbst:
.asciz "dcbst r%d, r%d"

ins_dcbt:
.asciz "dcbt r%d, r%d"

ins_dcbtst:
.asciz "dcbtst r%d, r%d"

ins_dcbz:
.asciz "dcbz r%d, r%d"

ins_dcbz_l:
.asciz "dcbz_l r%d, r%d"

ins_divw:
.asciz "divw r%d, r%d, r%d"
ins_divw_:
.asciz "divw. r%d, r%d, r%d"
ins_divwo:
.asciz "divwo r%d, r%d, r%d"
ins_divwo_:
.asciz "divwo. r%d, r%d, r%d"

ins_divwu:
.asciz "divwu r%d, r%d, r%d"
ins_divwu_:
.asciz "divwu. r%d, r%d, r%d"
ins_divwuo:
.asciz "divwuo r%d, r%d, r%d"
ins_divwuo_:
.asciz "divwuo. r%d, r%d, r%d"

ins_eciwx:
.asciz "eciwx r%d, r%d, r%d"

ins_ecowx:
.asciz "ecowx r%d, r%d, r%d"

ins_eieio:
.asciz "eieio"

ins_eqv:
.asciz "eqv r%d, r%d, r%d"
ins_eqv_:
.asciz "eqv. r%d, r%d, r%d"

ins_extsb:
.asciz "extsb r%d, r%d"
ins_extsb_:
.asciz "extsb. r%d, r%d"

ins_extsh:
.asciz "extsh r%d, r%d"
ins_extsh_:
.asciz "extsh. r%d, r%d"

ins_fabs:
.asciz "fabs f%d, f%d" //0xE08
ins_fabs_:
.asciz "fabs. f%d, f%d" //0xE28

ins_fadd:
.asciz "fadd f%d, f%d, f%d" //0xE48
ins_fadd_:
.asciz "fadd. f%d, f%d, f%d" //0xE68

ins_fadds:
.asciz "fadds f%d, f%d, f%d" //0xE88
ins_fadds_:
.asciz "fadds. f%d, f%d, f%d" //0xEA8

ins_fcmpo:
.asciz "fcmpo cr%d, f%d, f%d" //0xEC8

ins_fcmpu:
.asciz "fcmpu cr%d, f%d, f%d" //0xEE8

ins_fctiw:
.asciz "fctiw f%d, f%d" //0xF08
ins_fctiw_:
.asciz "fctiw. f%d, f%d" //0xF28

ins_fctiwz:
.asciz "fctiwz f%d, f%d" //0xF48
ins_fctiwz_:
.asciz "fctiwz. f%d, f%d" //0xF68

ins_fdiv:
.asciz "fdiv f%d, f%d, f%d" //0xF88
ins_fdiv_:
.asciz "fdiv. f%d, f%d, f%d" //0xFA8

ins_fdivs:
.asciz "fdivs f%d, f%d, f%d" //0xFC8
ins_fdivs_:
.asciz "fdivs. f%d, f%d, f%d" //0xFE8

ins_fmadd:
.asciz "fmadd f%d, f%d, f%d, f%d" //0x1008
ins_fmadd_:
.asciz "fmadd. f%d, f%d, f%d, f%d" //0x1028

ins_fmadds:
.asciz "fmadds f%d, f%d, f%d, f%d" //0x1048
ins_fmadds_:
.asciz "fmadds. f%d, f%d, f%d, f%d" //0x1068

ins_fmr:
.asciz "fmr f%d, f%d" //0x1088
ins_fmr_:
.asciz "fmr. f%d, f%d" //0x10A8

ins_fmsub:
.asciz "fmsub f%d, f%d, f%d, f%d" //0x10C8
ins_fmsub_:
.asciz "fmsub. f%d, f%d, f%d, f%d" //0x10E8

ins_fmsubs:
.asciz "fmsubs f%d, f%d, f%d, f%d" //0x1108
ins_fmsubs_:
.asciz "fmsubs. f%d, f%d, f%d, f%d" //0x1128

ins_fmul:
.asciz "fmul f%d, f%d, f%d" //0x1148
ins_fmul_:
.asciz "fmul. f%d, f%d, f%d" //0x1168

ins_fmuls:
.asciz "fmuls f%d, f%d, f%d" //0x1188
ins_fmuls_:
.asciz "fmuls. f%d, f%d, f%d" //0x11A8

ins_fnabs:
.asciz "fnabs f%d, f%d" //0x11C8
ins_fnabs_:
.asciz "fnabs. f%d, f%d" //0x11E8

ins_fneg:
.asciz "fneg f%d, f%d" //0x1208
ins_fneg_:
.asciz "fneg. f%d, f%d" //0x1228

ins_fnmadd:
.asciz "fnmadd f%d, f%d, f%d, f%d" //0x1248
ins_fnmadd_:
.asciz "fnmadd. f%d, f%d, f%d, f%d" //0x1268

ins_fnmadds:
.asciz "fnmadds f%d, f%d, f%d, f%d" //0x1288
ins_fnmadds_:
.asciz "fnmadds. f%d, f%d, f%d, f%d" //0x12A8

ins_fnmsub:
.asciz "fnmsub f%d, f%d, f%d, f%d" //0x12C8
ins_fnmsub_:
.asciz "fnmsub. f%d, f%d, f%d, f%d" //0x12E8

ins_fnmsubs:
.asciz "fnmsubs f%d, f%d, f%d, f%d" //0x1308
ins_fnmsubs_:
.asciz "fnmsubs. f%d, f%d, f%d, f%d" //0x1328

ins_fres:
.asciz "fres f%d, f%d" //0x1348
ins_fres_:
.asciz "fres. f%d, f%d" //0x1368

ins_frsp:
.asciz "frsp f%d, f%d" //0x1388
ins_frsp_:
.asciz "frsp. f%d, f%d" //0x13A8

ins_frsqrte:
.asciz "frsqrte f%d, f%d" //0x13C8
ins_frsqrte_:
.asciz "frsqrte. f%d, f%d" //0x13E8

ins_fsel:
.asciz "fsel f%d, f%d, f%d, f%d" //0x1408
ins_fsel_:
.asciz "fsel. f%d, f%d, f%d, f%d" //0x1428

ins_fsub:
.asciz "fsub f%d, f%d, f%d" //0x1448
ins_fsub_:
.asciz "fsub. f%d, f%d, f%d" //0x1468

ins_fsubs:
.asciz "fsubs f%d, f%d, f%d" //0x1488
ins_fsubs_:
.asciz "fsubs. f%d, f%d, f%d" //0x14A8

ins_icbi:
.asciz "icbi r%d, r%d" //0x14C8

ins_isync:
.asciz "isync"

ins_lbz:
.asciz "lbz r%d, 0x%X (r%d)"

ins_lbzu:
.asciz "lbzu r%d, 0x%X (r%d)" //0x1518

ins_lbzux:
.asciz "lbzux r%d, r%d, r%d" //0x1538

ins_lbzx:
.asciz "lbzx r%d, r%d, r%d" //0x1558

ins_lfd:
.asciz "lfd f%d, 0x%X (r%d)" //0x1578

ins_lfdu:
.asciz "lfdu f%d, 0x%X (r%d)" //0x1598

ins_lfdux:
.asciz "lfdux f%d, r%d, r%d" //0x15B8

ins_lfdx:
.asciz "lfdx f%d, r%d, r%d" //0x15D8

ins_lfs:
.asciz "lfs f%d, 0x%X (r%d)" //0x15F8

ins_lfsu:
.asciz "lfsu f%d, 0x%X (r%d)" //0x1618

ins_lfsux:
.asciz "lfsux f%d, r%d, r%d" //0x1638

ins_lfsx:
.asciz "lfsx f%d, r%d, r%d" //0x1658

ins_lha:
.asciz "lha r%d, 0x%X (r%d)" //0x1678

ins_lhau:
.asciz "lhau r%d, 0x%X (r%d)" //0x1698

ins_lhaux:
.asciz "lhaux r%d, r%d, r%d" //0x16B8

ins_lhax:
.asciz "lhax r%d, r%d, r%d" //0x16D8

ins_lhbrx:
.asciz "lhbrx r%d, r%d, r%d" //0x16F8

ins_lhz:
.asciz "lhz r%d, 0x%X (r%d)" //0x1718

ins_lhzu:
.asciz "lhzu r%d, 0x%X (r%d)" //0x1738

ins_lhzux:
.asciz "lhzux r%d, r%d, r%d" //0x1758

ins_lhzx:
.asciz "lhzx r%d, r%d, r%d" //0x1778

ins_li: //Simplified mnemonic for addi rX, r0, 0xXXXX
.asciz "li r%d, 0x%X"
ins_lis: //Simplified mnemonic for addis rX, r0, 0xXXXX
.asciz "lis r%d, 0x%X"

ins_lmw:
.asciz "lmw r%d, 0x%X (r%d)" //0x1798

ins_lswi:
.asciz "lswi r%d, r%d, %d" //0x17B8

ins_lswx:
.asciz "lswx r%d, r%d, r%d" //0x17D8

ins_lwarx:
.asciz "lwarx r%d, r%d, r%d" //0x17F8

ins_lwbrx:
.asciz "lwbrx r%d, r%d, r%d" //0x1818

ins_lwz:
.asciz "lwz r%d, 0x%X (r%d)" //0x1838

ins_lwzu:
.asciz "lwzu r%d, 0x%X (r%d)" //0x1858

ins_lwzux:
.asciz "lwzux r%d, r%d, r%d" //0x1878

ins_lwzx:
.asciz "lwzx r%d, r%d, r%d" //0x1898

ins_mcrf:
.asciz "mcrf cr%d, cr%d" //0x18B8

ins_mcrfs:
.asciz "mcrfs cr%d, cr%d" //0x18D8

ins_mcrxr:
.asciz "mcrxr cr%d" //0x18F8

ins_mfcr:
.asciz "mfcr r%d" //0x1918

ins_mffs:
.asciz "mffs f%d" //0x1938
ins_mffs_:
.asciz "mffs. f%d" //0x1958

ins_mfmsr:
.asciz "mfmsr r%d" //0x1978

//Not needed for disassembler
//ins_mfspr:
//.asciz "mfspr r%d, %d" //0x1998

ins_mfsr:
.asciz "mfsr r%d, %d" //0x19B8

ins_mfsrin:
.asciz "mfsrin r%d, r%d" //0x19D8

//ins_mftb: //Not needed for disassembler
//.asciz "mftb r%d, %d"

//Following are mftb simplifed mnemonics, first is unused for disassembler
//ins_mftb_simp: //Simplified mnemonic for mftb rD, 268
//.asciz "mftb r%d"
ins_mftbl: //Same thing as above
.asciz "mftbl r%d"
ins_mftbu: //Simplified mnemonic for mftb rD, 269
.asciz "mftbu r%d"

ins_mr: //Simplified mnemonic for or rA, rS, rS
.asciz "mr r%d, r%d"
ins_mr_: //Simplified mnemonic for or. rA, rS, rS
.asciz "mr. r%d, r%d"

ins_mtcrf:
.asciz "mtcrf 0x%X, r%d" //0x1A18
ins_mtcr: //Simplified mnemonic for mtcrfs 0xFF, rS
.asciz "mtcr r%d"

ins_mtfsb0:
.asciz "mtfsb0 %d" //0x1A38
ins_mtfsb0_:
.asciz "mtfsb0. %d" //0x1A58

ins_mtfsb1:
.asciz "mtfsb1 %d" //0x1A78
ins_mtfsb1_:
.asciz "mtfsb1. %d" //0x1A98

ins_mtfsf:
.asciz "mtfsf 0x%X, f%d" //0x1AB8
ins_mtfsf_:
.asciz "mtfsf. 0x%X, f%d" //0x1AD8

ins_mtfsfi:
.asciz "mtfsfi cr%d, %d" //0x1AF8
ins_mtfsfi_:
.asciz "mtfsfi. cr%d, %d" //0x1B18

ins_mtmsr:
.asciz "mtmsr r%d" //0x1B38

//Not needed for disassembler
//ins_mtspr:
//.asciz "mtspr %d, r%d" //0x1B58

ins_mtsr:
.asciz "mtsr %d, r%d" //0x1B78

ins_mtsrin:
.asciz "mtsrin r%d, r%d" //0x1B98

ins_mulhw:
.asciz "mulhw r%d, r%d, r%d" //0x1BB8
ins_mulhw_:
.asciz "mulhw. r%d, r%d, r%d" //0x1BD8

ins_mulhwu:
.asciz "mulhwu r%d, r%d, r%d" //0x1BF8
ins_mulhwu_:
.asciz "mulhwu. r%d, r%d, r%d" //0x1C18

ins_mulli:
.asciz "mulli r%d, r%d, 0x%X" //0x1C38

ins_mullw:
.asciz "mullw r%d, r%d, r%d" //0x1C58
ins_mullw_:
.asciz "mullw. r%d, r%d, r%d" //0x1C78
ins_mullwo:
.asciz "mullwo r%d, r%d, r%d" //0x1C98
ins_mullwo_:
.asciz "mullwo. r%d, r%d, r%d" //0x1CB8

ins_nand:
.asciz "nand r%d, r%d, r%d" //0x1CD8
ins_nand_:
.asciz "nand. r%d, r%d, r%d" //0x1CF8

ins_neg:
.asciz "neg r%d, r%d" //0x1D18
ins_neg_:
.asciz "neg. r%d, r%d" //0x1D38
ins_nego:
.asciz "nego r%d, r%d" //0x1D58
ins_nego_:
.asciz "nego. r%d, r%d" //0x1D78

ins_nor:
.asciz "nor r%d, r%d, r%d" //0x1D98
ins_nor_:
.asciz "nor. r%d, r%d, r%d" //0x1DB8

ins_not: //Simplified mnemonic for nor rA, rS, rS
.asciz "not r%d, r%d"
ins_not_: //Simplified mnemonic for nor. rA, rS, rS
.asciz "not. r%d, r%d"

ins_nop: //Simplified mnemonic for ori r0, r0, 0x0000
.asciz "nop"

ins_or:
.asciz "or r%d, r%d, r%d" //0x1DD8
ins_or_:
.asciz "or. r%d, r%d, r%d" //0x1DF8

ins_orc:
.asciz "orc r%d, r%d, r%d" //0x1E18
ins_orc_:
.asciz "orc. r%d, r%d, r%d" //0x1E38

ins_ori:
.asciz "ori r%d, r%d, 0x%X" //0x1E58

ins_oris:
.asciz "oris r%d, r%d, 0x%X" //0x1E78

ins_psq_l:
.asciz "psq_l f%d, 0x%X (r%d), %d, %d" //0x1E98

ins_psq_lu:
.asciz "psq_lu f%d, 0x%X (r%d), %d, %d" //0x1ED8

ins_psq_lux:
.asciz "psq_lux f%d, r%d, r%d, %d, %d" //0x1F18

ins_psq_lx:
.asciz "psq_lx f%d, r%d, r%d, %d, %d" //0x1F58

ins_psq_st:
.asciz "psq_st f%d, 0x%X (r%d), %d, %d" //0x1F98

ins_psq_stu:
.asciz "psq_stu f%d, 0x%X (r%d), %d, %d" //0x1FD8

ins_psq_stux:
.asciz "psq_stux f%d, r%d, r%d, %d, %d" //0x2018

ins_psq_stx:
.asciz "psq_stx f%d, r%d, r%d, %d, %d" //0x2058

ins_ps_abs:
.asciz "ps_abs f%d, f%d" //0x2098;
ins_ps_abs_:
.asciz "ps_abs. f%d, f%d" //0x20B8

ins_ps_add:
.asciz "ps_add f%d, f%d, f%d" //0x20D8
ins_ps_add_:
.asciz "ps_add. f%d, f%d, f%d" //0x20F8

ins_ps_cmpo0:
.asciz "ps_cmpo0 cr%d, f%d, f%d" //0x2118

ins_ps_cmpo1:
.asciz "ps_cmpo1 cr%d, f%d, f%d" //0x2138

ins_ps_cmpu0:
.asciz "ps_cmpu0 cr%d, f%d, f%d" //0x2158

ins_ps_cmpu1:
.asciz "ps_cmpu1 cr%d, f%d, f%d" //0x2178

ins_ps_div:
.asciz "ps_div f%d, f%d, f%d" //0x2198
ins_ps_div_:
.asciz "ps_div. f%d, f%d, f%d" //0x21B8

ins_ps_madd:
.asciz "ps_madd f%d, f%d, f%d, f%d" //0x21D8
ins_ps_madd_:
.asciz "ps_madd. f%d, f%d, f%d, f%d" //0x21F8

ins_ps_madds0:
.asciz "ps_madds0 f%d, f%d, f%d, f%d" //0x2218
ins_ps_madds0_:
.asciz "ps_madds0. f%d, f%d, f%d, f%d" //0x2238

ins_ps_madds1:
.asciz "ps_madds1 f%d, f%d, f%d, f%d" //0x2258
ins_ps_madds1_:
.asciz "ps_madds1. f%d, f%d, f%d, f%d" //0x2278

ins_ps_merge00:
.asciz "ps_merge00 f%d, f%d, f%d" //0x2298
ins_ps_merge00_:
.asciz "ps_merge00. f%d, f%d, f%d" //0x22B8

ins_ps_merge01:
.asciz "ps_merge01 f%d, f%d, f%d" //0x22D8
ins_ps_merge01_:
.asciz "ps_merge01. f%d, f%d, f%d" //0x22F8

ins_ps_merge10:
.asciz "ps_merge10 f%d, f%d, f%d" //0x2318
ins_ps_merge10_:
.asciz "ps_merge10. f%d, f%d, f%d" //0x2338

ins_ps_merge11:
.asciz "ps_merge11 f%d, f%d, f%d" //0x2358
ins_ps_merge11_:
.asciz "ps_merge11. f%d, f%d, f%d" //0x2378

ins_ps_mr:
.asciz "ps_mr f%d, f%d" //0x2398
ins_ps_mr_:
.asciz "ps_mr. f%d, f%d" //0x23B8

ins_ps_msub:
.asciz "ps_msub f%d, f%d, f%d, f%d" //0x23D8
ins_ps_msub_:
.asciz "ps_msub. f%d, f%d, f%d, f%d" //0x23F8

ins_ps_mul:
.asciz "ps_mul f%d, f%d, f%d" //0x2418
ins_ps_mul_:
.asciz "ps_mul. f%d, f%d, f%d" //0x2438

ins_ps_muls0:
.asciz "ps_muls0 f%d, f%d, f%d" //0x2458
ins_ps_muls0_:
.asciz "ps_muls0. f%d, f%d, f%d" //0x2478

ins_ps_muls1:
.asciz "ps_muls1 f%d, f%d, f%d" //0x2498
ins_ps_muls1_:
.asciz "ps_muls1. f%d, f%d, f%d" //0x24B8

ins_ps_nabs:
.asciz "ps_nabs f%d, f%d" //0x24D8
ins_ps_nabs_:
.asciz "ps_nabs. f%d, f%d" //0x24F8

ins_ps_neg:
.asciz "ps_neg f%d, f%d" //0x2518
ins_ps_neg_:
.asciz "ps_neg. f%d, f%d" //0x2538

ins_ps_nmadd:
.asciz "ps_nmadd f%d, f%d, f%d, f%d" //0x2558
ins_ps_nmadd_:
.asciz "ps_nmadd. f%d, f%d, f%d, f%d" //0x2578

ins_ps_nmsub:
.asciz "ps_nmsub f%d, f%d, f%d, f%d" //0x2598
ins_ps_nmsub_:
.asciz "ps_nmsub. f%d, f%d, f%d, f%d" //0x25B8

ins_ps_res:
.asciz "ps_res f%d, f%d" //0x25D8
ins_ps_res_:
.asciz "ps_res. f%d, f%d" //0x25F8

ins_ps_rsqrte:
.asciz "ps_rsqrte f%d, f%d" //0x2618
ins_ps_rsqrte_:
.asciz "ps_rsqrte. f%d, f%d" //0x2638

ins_ps_sel:
.asciz "ps_sel f%d, f%d, f%d, f%d" //0x2658
ins_ps_sel_:
.asciz "ps_sel. f%d, f%d, f%d, f%d" //0x2678

ins_ps_sub:
.asciz "ps_sub f%d, f%d, f%d" //0x2698
ins_ps_sub_:
.asciz "ps_sub. f%d, f%d, f%d" //0x26B8

ins_ps_sum0:
.asciz "ps_sum0 f%d, f%d, f%d, f%d" //0x26D8
ins_ps_sum0_:
.asciz "ps_sum0. f%d, f%d, f%d, f%d" //0x26F8

ins_ps_sum1:
.asciz "ps_sum1 f%d, f%d, f%d, f%d" //0x2718
ins_ps_sum1_:
.asciz "ps_sum1. f%d, f%d, f%d, f%d" //0x2738

ins_rfi:
.asciz "rfi" //0x2758

ins_rlwimi:
.asciz "rlwimi r%d, r%d, %d, %d, %d" //0x2768;
ins_rlwimi_:
.asciz "rlwimi. r%d, r%d, %d, %d, %d" //0x2788

ins_rlwinm:
.asciz "rlwinm r%d, r%d, %d, %d, %d" //0x27A8
ins_rlwinm_:
.asciz "rlwinm. r%d, r%d, %d, %d, %d" //0x27C8

ins_rlwnm:
.asciz "rlwnm r%d, r%d, r%d, %d, %d" //0x27E8
ins_rlwnm_:
.asciz "rlwnm. r%d, r%d, r%d, %d, %d" //0x2808

ins_sc:
.asciz "sc" //0x2828

ins_slw:
.asciz "slw r%d, r%d, r%d" //0x2838;
ins_slw_:
.asciz "slw. r%d, r%d, r%d" //0x2858

ins_sraw:
.asciz "sraw r%d, r%d, r%d" //0x2878
ins_sraw_:
.asciz "sraw. r%d, r%d, r%d" //0x2898

ins_srawi:
.asciz "srawi r%d, r%d, %d" //0x28B8
ins_srawi_:
.asciz "srawi. r%d, r%d, %d" //0x28D8

ins_srw:
.asciz "srw r%d, r%d, r%d" //0x28F8
ins_srw_:
.asciz "srw. r%d, r%d, r%d" //0x2918

ins_stb:
.asciz "stb r%d, 0x%X (r%d)" //0x2938

ins_stbu:
.asciz "stbu r%d, 0x%X (r%d)" //0x2958

ins_stbux:
.asciz "stbux r%d, r%d, r%d" //0x2978

ins_stbx:
.asciz "stbx r%d, r%d, r%d" //0x2998

ins_stfd:
.asciz "stfd f%d, 0x%X (r%d)"

ins_stfdu:
.asciz "stfdu f%d, 0x%X (r%d)"

ins_stfdux:
.asciz "stfdux f%d, r%d, r%d"

ins_stfdx:
.asciz "stfdx f%d, r%d, r%d"

ins_stfiwx:
.asciz "stfiwx f%d, r%d, r%d"

ins_stfs:
.asciz "stfs f%d, 0x%X (r%d)"

ins_stfsu:
.asciz "stfsu f%d, 0x%X (r%d)"

ins_stfsux:
.asciz "stfsux f%d, r%d, r%d"

ins_stfsx:
.asciz "stfsx f%d, r%d, r%d"

ins_sth:
.asciz "sth r%d, 0x%X (r%d)"

ins_sthbrx:
.asciz "sthbrx r%d, r%d, r%d"

ins_sthu:
.asciz "sthu r%d, 0x%X (r%d)"

ins_sthux:
.asciz "sthux r%d, r%d, r%d"

ins_sthx:
.asciz "sthx r%d, r%d, r%d"

ins_stmw:
.asciz "stmw r%d, 0x%X (r%d)"

ins_stswi:
.asciz "stswi r%d, r%d, %d"

ins_stswx:
.asciz "stswx r%d, r%d, r%d"

ins_stw:
.asciz "stw r%d, 0x%X (r%d)"

ins_stwbrx:
.asciz "stwbrx r%d, r%d, r%d"

ins_stwcx_:
.asciz "stwcx. r%d, r%d, r%d"

ins_stwu:
.asciz "stwu r%d, 0x%X (r%d)"

ins_stwux:
.asciz "stwux r%d, r%d, r%d"

ins_stwx:
.asciz "stwx r%d, r%d, r%d"

//ins_subf: //NOT NEEDED in the disassembler
//.asciz "subf r%d, r%d, r%d"
//ins_subf_:
//.asciz "subf. r%d, r%d, r%d"
//ins_subfo:
//.asciz "subfo r%d, r%d, r%d"
//ins_subfo_:
//.asciz "subfo. r%d, r%d, r%d"

//Simplified mnemonics for subfX rD, rB, rA
ins_sub:
.asciz "sub r%d, r%d, r%d"
ins_sub_:
.asciz "sub. r%d, r%d, r%d"
ins_subo:
.asciz "subo r%d, r%d, r%d"
ins_subo_:
.asciz "subo. r%d, r%d, r%d"

//ins_subfc: //NOT NEEDED in the disassembler
//.asciz "subfc r%d, r%d, r%d"
//ins_subfc_:
//.asciz "subfc. r%d, r%d, r%d"
//ins_subfco:
//.asciz "subfco r%d, r%d, r%d"
//ins_subfco_:
//.asciz "subfco. r%d, r%d, r%d"

//Simplified mnemonics for subfcX rD, rB, rA
ins_subc:
.asciz "subc r%d, r%d, r%d"
ins_subc_:
.asciz "subc. r%d, r%d, r%d"
ins_subco:
.asciz "subco r%d, r%d, r%d"
ins_subco_:
.asciz "subco. r%d, r%d, r%d"

ins_subfe:
.asciz "subfe r%d, r%d, r%d"
ins_subfe_:
.asciz "subfe. r%d, r%d, r%d"
ins_subfeo:
.asciz "subfeo r%d, r%d, r%d"
ins_subfeo_:
.asciz "subfeo. r%d, r%d, r%d"

ins_subfic:
.asciz "subfic r%d, r%d, 0x%X"

ins_subfme:
.asciz "subfme r%d, r%d"
ins_subfme_:
.asciz "subfme. r%d, r%d"
ins_subfmeo:
.asciz "subfmeo r%d, r%d"
ins_subfmeo_:
.asciz "subfmeo. r%d, r%d"

ins_subfze:
.asciz "subfze r%d, r%d"
ins_subfze_:
.asciz "subfze. r%d, r%d"
ins_subfzeo:
.asciz "subfzeo r%d, r%d"
ins_subfzeo_:
.asciz "subfzeo. r%d, r%d"

ins_sync:
.asciz "sync"

ins_tlbie:
.asciz "tlbie r%d"

ins_tlbsync:
.asciz "tlbsync"

ins_trap: //Simplified mnemonic for tw 31, rA, rB
.asciz "trap"

ins_tw:
.asciz "tw %d, r%d, r%d"

ins_twi:
.asciz "twi %d, r%d, 0x%X"

ins_xor:
.asciz "xor r%d, r%d, r%d"
ins_xor_:
.asciz "xor. r%d, r%d, r%d"

ins_xori:
.asciz "xori r%d, r%d, 0x%X"

ins_xoris:
.asciz "xoris r%d, r%d, 0x%X"

//Following are mfspr simplified mnemonics, rather have these in a group than placed in alphabetically
ins_mfxer:
.asciz "mfxer r%d"
ins_mflr:
.asciz "mflr r%d"
ins_mfctr:
.asciz "mfctr r%d"
ins_mfdsisr:
.asciz "mfdsisr r%d"
ins_mfdar:
.asciz "mfdar r%d"
ins_mfdec:
.asciz "mfdec r%d"
ins_mfsdr1:
.asciz "mfsdr1 r%d"
ins_mfsrr0:
.asciz "mfsrr0 r%d"
ins_mfsrr1:
.asciz "mfsrr1 r%d"
ins_mfsprg0:
.asciz "mfsprg0 r%d"
ins_mfsprg1:
.asciz "mfsprg1 r%d"
ins_mfsprg2:
.asciz "mfsprg2 r%d"
ins_mfsprg3:
.asciz "mfsprg3 r%d"
ins_mfear:
.asciz "mfear r%d"
ins_mfpvr:
.asciz "mfpvr r%d"
ins_mfibat0u:
.asciz "mfibat0u r%d"
ins_mfibat0l:
.asciz "mfibat0l r%d"
ins_mfibat1u:
.asciz "mfibat1u r%d"
ins_mfibat1l:
.asciz "mfibat1l r%d"
ins_mfibat2u:
.asciz "mfibat2u r%d"
ins_mfibat2l:
.asciz "mfibat2l r%d"
ins_mfibat3u:
.asciz "mfibat3u r%d"
ins_mfibat3l:
.asciz "mfibat3l r%d"
ins_mfibat4u:
.asciz "mfibat4u r%d"
ins_mfibat4l:
.asciz "mfibat4l r%d"
ins_mfibat5u:
.asciz "mfibat5u r%d"
ins_mfibat5l:
.asciz "mfibat5l r%d"
ins_mfibat6u:
.asciz "mfibat6u r%d"
ins_mfibat6l:
.asciz "mfibat6l r%d"
ins_mfibat7u:
.asciz "mfibat7u r%d"
ins_mfibat7l:
.asciz "mfibat7l r%d"
ins_mfdbat0u:
.asciz "mfdbat0u r%d"
ins_mfdbat0l:
.asciz "mfdbat0l r%d"
ins_mfdbat1u:
.asciz "mfdbat1u r%d"
ins_mfdbat1l:
.asciz "mfdbat1l r%d"
ins_mfdbat2u:
.asciz "mfdbat2u r%d"
ins_mfdbat2l:
.asciz "mfdbat2l r%d"
ins_mfdbat3u:
.asciz "mfdbat3u r%d"
ins_mfdbat3l:
.asciz "mfdbat3l r%d"
ins_mfdbat4u:
.asciz "mfdbat4u r%d"
ins_mfdbat4l:
.asciz "mfdbat4l r%d"
ins_mfdbat5u:
.asciz "mfdbat5u r%d"
ins_mfdbat5l:
.asciz "mfdbat5l r%d"
ins_mfdbat6u:
.asciz "mfdbat6u r%d"
ins_mfdbat6l:
.asciz "mfdbat6l r%d"
ins_mfdbat7u:
.asciz "mfdbat7u r%d"
ins_mfdbat7l:
.asciz "mfdbat7l r%d"
ins_mfgqr0:
.asciz "mfgqr0 r%d"
ins_mfgqr1:
.asciz "mfgqr1 r%d"
ins_mfgqr2:
.asciz "mfgqr2 r%d"
ins_mfgqr3:
.asciz "mfgqr3 r%d"
ins_mfgqr4:
.asciz "mfgqr4 r%d"
ins_mfgqr5:
.asciz "mfgqr5 r%d"
ins_mfgqr6:
.asciz "mfgqr6 r%d"
ins_mfgqr7:
.asciz "mfgqr7 r%d"
ins_mfhid2:
.asciz "mfhid2 r%d"
ins_mfwpar:
.asciz "mfwpar r%d"
ins_mfdma_u:
.asciz "mfdma_u r%d"
ins_mfdma_l:
.asciz "mfdma_l r%d"
ins_mfcidh:
.asciz "mfcidh r%d" //Special Broadway Chip IDs supported
ins_mfcidm:
.asciz "mfcidm r%d" //Special Broadway Chip IDs supported
ins_mfcidl:
.asciz "mfcidl r%d" //Special Broadway Chip IDs supported
ins_mfummcr0:
.asciz "mfummcr0 r%d"
ins_mfupmc1:
.asciz "mfupmc1 r%d"
ins_mfupmc2:
.asciz "mfupmc2 r%d"
ins_mfusia:
.asciz "mfusia r%d"
ins_mfummcr1:
.asciz "mfummcr1 r%d"
ins_mfupmc3:
.asciz "mfupmc3 r%d"
ins_mfupmc4:
.asciz "mfupmc4 r%d"
ins_mfusda:
.asciz "mfusda r%d"
ins_mfmmcr0:
.asciz "mfmmcr0 r%d"
ins_mfpmc1:
.asciz "mfpmc1 r%d"
ins_mfpmc2:
.asciz "mfpmc2 r%d"
ins_mfsia:
.asciz "mfsia r%d"
ins_mfmmcr1:
.asciz "mfmmcr1 r%d"
ins_mfpmc3:
.asciz "mfpmc3 r%d"
ins_mfpmc4:
.asciz "mfpmc4 r%d"
ins_mfsda:
.asciz "mfsda r%d"
ins_mfhid0:
.asciz "mfhid0 r%d"
ins_mfhid1:
.asciz "mfhid1 r%d"
ins_mfiabr:
.asciz "mfiabr r%d"
ins_mfhid4:
.asciz "mfhid4 r%d"
ins_mftdcl:
.asciz "mftdcl r%d"
ins_mfdabr:
.asciz "mfdabr r%d"
ins_mfl2cr:
.asciz "mfl2cr r%d"
ins_mftdch:
.asciz "mftdch r%d"
ins_mfictc:
.asciz "mfictc r%d"
ins_mfthrm1:
.asciz "mfthrm1 r%d"
ins_mfthrm2:
.asciz "mfthrm2 r%d"
ins_mfthrm3:
.asciz "mfthrm3 r%d"

//Following are mtspr simplified mnemonics, rather have these in a group than placed in alphabetically
ins_mtxer:
.asciz "mtxer r%d"
ins_mtlr:
.asciz "mtlr r%d"
ins_mtctr:
.asciz "mtctr r%d"
ins_mtdsisr:
.asciz "mtdsisr r%d"
ins_mtdar:
.asciz "mtdar r%d"
ins_mtdec:
.asciz "mtdec r%d"
ins_mtsdr1:
.asciz "mtsdr1 r%d"
ins_mtsrr0:
.asciz "mtsrr0 r%d"
ins_mtsrr1:
.asciz "mtsrr1 r%d"
ins_mtsprg0:
.asciz "mtsprg0 r%d"
ins_mtsprg1:
.asciz "mtsprg1 r%d"
ins_mtsprg2:
.asciz "mtsprg2 r%d"
ins_mtsprg3:
.asciz "mtsprg3 r%d"
ins_mtear:
.asciz "mtear r%d"
ins_mttbl:
.asciz "mttbl r%d"
ins_mttbu:
.asciz "mttbu r%d"
ins_mtibat0u:
.asciz "mtibat0u r%d"
ins_mtibat0l:
.asciz "mtibat0l r%d"
ins_mtibat1u:
.asciz "mtibat1u r%d"
ins_mtibat1l:
.asciz "mtibat1l r%d"
ins_mtibat2u:
.asciz "mtibat2u r%d"
ins_mtibat2l:
.asciz "mtibat2l r%d"
ins_mtibat3u:
.asciz "mtibat3u r%d"
ins_mtibat3l:
.asciz "mtibat3l r%d"
ins_mtibat4u:
.asciz "mtibat4u r%d"
ins_mtibat4l:
.asciz "mtibat4l r%d"
ins_mtibat5u:
.asciz "mtibat5u r%d"
ins_mtibat5l:
.asciz "mtibat5l r%d"
ins_mtibat6u:
.asciz "mtibat6u r%d"
ins_mtibat6l:
.asciz "mtibat6l r%d"
ins_mtibat7u:
.asciz "mtibat7u r%d"
ins_mtibat7l:
.asciz "mtibat7l r%d"
ins_mtdbat0u:
.asciz "mtdbat0u r%d"
ins_mtdbat0l:
.asciz "mtdbat0l r%d"
ins_mtdbat1u:
.asciz "mtdbat1u r%d"
ins_mtdbat1l:
.asciz "mtdbat1l r%d"
ins_mtdbat2u:
.asciz "mtdbat2u r%d"
ins_mtdbat2l:
.asciz "mtdbat2l r%d"
ins_mtdbat3u:
.asciz "mtdbat3u r%d"
ins_mtdbat3l:
.asciz "mtdbat3l r%d"
ins_mtdbat4u:
.asciz "mtdbat4u r%d"
ins_mtdbat4l:
.asciz "mtdbat4l r%d"
ins_mtdbat5u:
.asciz "mtdbat5u r%d"
ins_mtdbat5l:
.asciz "mtdbat5l r%d"
ins_mtdbat6u:
.asciz "mtdbat6u r%d"
ins_mtdbat6l:
.asciz "mtdbat6l r%d"
ins_mtdbat7u:
.asciz "mtdbat7u r%d"
ins_mtdbat7l:
.asciz "mtdbat7l r%d"
ins_mtgqr0:
.asciz "mtgqr0 r%d"
ins_mtgqr1:
.asciz "mtgqr1 r%d"
ins_mtgqr2:
.asciz "mtgqr2 r%d"
ins_mtgqr3:
.asciz "mtgqr3 r%d"
ins_mtgqr4:
.asciz "mtgqr4 r%d"
ins_mtgqr5:
.asciz "mtgqr5 r%d"
ins_mtgqr6:
.asciz "mtgqr6 r%d"
ins_mtgqr7:
.asciz "mtgqr7 r%d"
ins_mthid2:
.asciz "mthid2 r%d"
ins_mtwpar:
.asciz "mtwpar r%d"
ins_mtdma_u:
.asciz "mtdma_u r%d"
ins_mtdma_l:
.asciz "mtdma_l r%d"
ins_mtummcr0:
.asciz "mtummcr0 r%d"
ins_mtupmc1:
.asciz "mtupmc1 r%d"
ins_mtupmc2:
.asciz "mtupmc2 r%d"
ins_mtusia:
.asciz "mtusia r%d"
ins_mtummcr1:
.asciz "mtummcr1 r%d"
ins_mtupmc3:
.asciz "mtupmc3 r%d"
ins_mtupmc4:
.asciz "mtupmc4 r%d"
ins_mtusda:
.asciz "mtusda r%d"
ins_mtmmcr0:
.asciz "mtmmcr0 r%d"
ins_mtpmc1:
.asciz "mtpmc1 r%d"
ins_mtpmc2:
.asciz "mtpmc2 r%d"
ins_mtsia:
.asciz "mtsia r%d"
ins_mtmmcr1:
.asciz "mtmmcr1 r%d"
ins_mtpmc3:
.asciz "mtpmc3 r%d"
ins_mtpmc4:
.asciz "mtpmc4 r%d"
ins_mtsda:
.asciz "mtsda r%d"
ins_mthid0:
.asciz "mthid0 r%d"
ins_mthid1:
.asciz "mthid1 r%d"
ins_mtiabr:
.asciz "mtiabr r%d"
ins_mthid4:
.asciz "mthid4 r%d"
ins_mtdabr:
.asciz "mtdabr r%d"
ins_mtl2cr:
.asciz "mtl2cr r%d"
ins_mtictc:
.asciz "mtictc r%d"
ins_mtthrm1:
.asciz "mtthrm1 r%d"
ins_mtthrm2:
.asciz "mtthrm2 r%d"
ins_mtthrm3:
.asciz "mtthrm3 r%d"

//Following are CR simplified mnemonics
ins_crset:
.asciz "crset %d" //creqv d, d, d
ins_crnot:
.asciz "crnot %d, %d" //crnor d, a, a
ins_crmove:
.asciz "crmove %d, %d" //cror d, a, a
ins_crclr:
.asciz "crclr %d" //crxor d, d, d

//Following are SOME rlwinmX simplified mnemonics
ins_slwi: //Simplified mnemonic for rlwinm rX, rY, b, 0, 31-b
.asciz "slwi r%d, r%d, %d"
ins_slwi_:
.asciz "slwi. r%d, r%d, %d"
ins_srwi: //Simplified mnemonic for rlwinm rX, rY, 32-b, b, 31
.asciz "srwi r%d, r%d, %d"
ins_srwi_:
.asciz "srwi. r%d, r%d, %d"
ins_clrlwi: //Simplified mnemonic for rlwinm rX, rY, 0, b, 31
.asciz "clrlwi r%d, r%d, %d"
ins_clrlwi_:
.asciz "clrlwi. r%d, r%d, %d"
ins_clrrwi: //Simplified mnemonic for rlwinm rX, rY, 0, 0, 31-b
.asciz "clrrwi r%d, r%d, %d"
ins_clrrwi_:
.asciz "clrrwi. r%d, r%d, %d"
ins_rotlwi: //Simplified mnemonic for rlwinm rX, rY, b, 0, 31
.asciz "rotlwi r%d, r%d, %d"
ins_rotlwi_:
.asciz "rotlwi. r%d, r%d, %d"

//Simplified mnemonic for rlwnmX
ins_rotlw: //Simplified mnemonic for rlwnm rX, rY, rZ, 0, 31
.asciz "rotlw r%d, r%d, r%d"
ins_rotlw_:
.asciz "rotlw. r%d, r%d, r%d"

//Following are all the branch simplified mnemonics
ins_bdnzf_ll:
.asciz "bdnzf- %d, 0x%X"
ins_bdnzf_ml:
.asciz "bdnzf+ %d, 0x%X"
ins_bdnzfa_ll:
.asciz "bdnzfa- %d, 0x%X"
ins_bdnzfa_ml:
.asciz "bdnzfa+ %d, 0x%X"
ins_bdnzfl_ll:
.asciz "bdnzfl- %d, 0x%X"
ins_bdnzfl_ml:
.asciz "bdnzfl+ %d, 0x%X"
ins_bdnzfla_ll:
.asciz "bdnzfla- %d, 0x%X"
ins_bdnzfla_ml:
.asciz "bdnzfla+ %d, 0x%X"

ins_bdzf_ll:
.asciz "bdzf- %d, 0x%X"
ins_bdzf_ml:
.asciz "bdzf+ %d, 0x%X"
ins_bdzfa_ll:
.asciz "bdzfa- %d, 0x%X"
ins_bdzfa_ml:
.asciz "bdzfa+ %d, 0x%X"
ins_bdzfl_ll:
.asciz "bdzfl- %d, 0x%X"
ins_bdzfl_ml:
.asciz "bdzfl+ %d, 0x%X"
ins_bdzfla_ll:
.asciz "bdzfla- %d, 0x%X"
ins_bdzfla_ml:
.asciz "bdzfla+ %d, 0x%X"

ins_bge_ll_cr0:
.asciz "bge- 0x%X"
ins_bge_ml_cr0:
.asciz "bge+ 0x%X"
ins_bgea_ll_cr0:
.asciz "bgea- 0x%X"
ins_bgea_ml_cr0:
.asciz "bgea+ 0x%X"
ins_bgel_ll_cr0:
.asciz "bgel- 0x%X"
ins_bgel_ml_cr0:
.asciz "bgel+ 0x%X"
ins_bgela_ll_cr0:
.asciz "bgela- 0x%X"
ins_bgela_ml_cr0:
.asciz "bgela+ 0x%X"
ins_bge_ll:
.asciz "bge- cr%d, 0x%X"
ins_bge_ml:
.asciz "bge+ cr%d, 0x%X"
ins_bgea_ll:
.asciz "bgea- cr%d, 0x%X"
ins_bgea_ml:
.asciz "bgea+ cr%d, 0x%X"
ins_bgel_ll:
.asciz "bgel- cr%d, 0x%X"
ins_bgel_ml:
.asciz "bgel+ cr%d, 0x%X"
ins_bgela_ll:
.asciz "bgela- cr%d, 0x%X"
ins_bgela_ml:
.asciz "bgela+ cr%d, 0x%X"

ins_ble_ll_cr0:
.asciz "ble- 0x%X"
ins_ble_ml_cr0:
.asciz "ble+ 0x%X"
ins_blea_ll_cr0:
.asciz "blea- 0x%X"
ins_blea_ml_cr0:
.asciz "blea+ 0x%X"
ins_blel_ll_cr0:
.asciz "blel- 0x%X"
ins_blel_ml_cr0:
.asciz "blel+ 0x%X"
ins_blela_ll_cr0:
.asciz "blela- 0x%X"
ins_blela_ml_cr0:
.asciz "blela+ 0x%X"
ins_ble_ll:
.asciz "ble- cr%d, 0x%X"
ins_ble_ml:
.asciz "ble+ cr%d, 0x%X"
ins_blea_ll:
.asciz "blea- cr%d, 0x%X"
ins_blea_ml:
.asciz "blea+ cr%d, 0x%X"
ins_blel_ll:
.asciz "blel- cr%d, 0x%X"
ins_blel_ml:
.asciz "blel+ cr%d, 0x%X"
ins_blela_ll:
.asciz "blela- cr%d, 0x%X"
ins_blela_ml:
.asciz "blela+ cr%d, 0x%X"

ins_bne_ll_cr0:
.asciz "bne- 0x%X"
ins_bne_ml_cr0:
.asciz "bne+ 0x%X"
ins_bnea_ll_cr0:
.asciz "bnea- 0x%X"
ins_bnea_ml_cr0:
.asciz "bnea+ 0x%X"
ins_bnel_ll_cr0:
.asciz "bnel- 0x%X"
ins_bnel_ml_cr0:
.asciz "bnel+ 0x%X"
ins_bnela_ll_cr0:
.asciz "bnela- 0x%X"
ins_bnela_ml_cr0:
.asciz "bnela+ 0x%X"
ins_bne_ll:
.asciz "bne- cr%d, 0x%X"
ins_bne_ml:
.asciz "bne+ cr%d, 0x%X"
ins_bnea_ll:
.asciz "bnea- cr%d, 0x%X"
ins_bnea_ml:
.asciz "bnea+ cr%d, 0x%X"
ins_bnel_ll:
.asciz "bnel- cr%d, 0x%X"
ins_bnel_ml:
.asciz "bnel+ cr%d, 0x%X"
ins_bnela_ll:
.asciz "bnela- cr%d, 0x%X"
ins_bnela_ml:
.asciz "bnela+ cr%d, 0x%X"

ins_bns_ll_cr0:
.asciz "bns- 0x%X"
ins_bns_ml_cr0:
.asciz "bns+ 0x%X"
ins_bnsa_ll_cr0:
.asciz "bnsa- 0x%X"
ins_bnsa_ml_cr0:
.asciz "bnsa+ 0x%X"
ins_bnsl_ll_cr0:
.asciz "bnsl- 0x%X"
ins_bnsl_ml_cr0:
.asciz "bnsl+ 0x%X"
ins_bnsla_ll_cr0:
.asciz "bnsla- 0x%X"
ins_bnsla_ml_cr0:
.asciz "bnsla+ 0x%X"
ins_bns_ll:
.asciz "bns- cr%d, 0x%X"
ins_bns_ml:
.asciz "bns+ cr%d, 0x%X"
ins_bnsa_ll:
.asciz "bnsa- cr%d, 0x%X"
ins_bnsa_ml:
.asciz "bnsa+ cr%d, 0x%X"
ins_bnsl_ll:
.asciz "bnsl- cr%d, 0x%X"
ins_bnsl_ml:
.asciz "bnsl+ cr%d, 0x%X"
ins_bnsla_ll:
.asciz "bnsla- cr%d, 0x%X"
ins_bnsla_ml:
.asciz "bnsla+ cr%d, 0x%X"

ins_bdnzt_ll:
.asciz "bdnzt- %d, 0x%X"
ins_bdnzt_ml:
.asciz "bdnzt+ %d, 0x%X"
ins_bdnzta_ll:
.asciz "bdnzta- %d, 0x%X"
ins_bdnzta_ml:
.asciz "bdnzta+ %d, 0x%X"
ins_bdnztl_ll:
.asciz "bdnztl- %d, 0x%X"
ins_bdnztl_ml:
.asciz "bdnztl+ %d, 0x%X"
ins_bdnztla_ll:
.asciz "bdnztla- %d, 0x%X"
ins_bdnztla_ml:
.asciz "bdnztla+ %d, 0x%X"

ins_bdzt_ll:
.asciz "bdzt- %d, 0x%X"
ins_bdzt_ml:
.asciz "bdzt+ %d, 0x%X"
ins_bdzta_ll:
.asciz "bdzta- %d, 0x%X"
ins_bdzta_ml:
.asciz "bdzta+ %d, 0x%X"
ins_bdztl_ll:
.asciz "bdztl- %d, 0x%X"
ins_bdztl_ml:
.asciz "bdztl+ %d, 0x%X"
ins_bdztla_ll:
.asciz "bdztla- %d, 0x%X"
ins_bdztla_ml:
.asciz "bdztla+ %d, 0x%X"

ins_blt_ll_cr0:
.asciz "blt- 0x%X"
ins_blt_ml_cr0:
.asciz "blt+ 0x%X"
ins_blta_ll_cr0:
.asciz "blta- 0x%X"
ins_blta_ml_cr0:
.asciz "blta+ 0x%X"
ins_bltl_ll_cr0:
.asciz "bltl- 0x%X"
ins_bltl_ml_cr0:
.asciz "bltl+ 0x%X"
ins_bltla_ll_cr0:
.asciz "bltla- 0x%X"
ins_bltla_ml_cr0:
.asciz "bltla+ 0x%X"
ins_blt_ll:
.asciz "blt- cr%d, 0x%X"
ins_blt_ml:
.asciz "blt+ cr%d, 0x%X"
ins_blta_ll:
.asciz "blta- cr%d, 0x%X"
ins_blta_ml:
.asciz "blta+ cr%d, 0x%X"
ins_bltl_ll:
.asciz "bltl- cr%d, 0x%X"
ins_bltl_ml:
.asciz "bltl+ cr%d, 0x%X"
ins_bltla_ll:
.asciz "bltla- cr%d, 0x%X"
ins_bltla_ml:
.asciz "bltla+ cr%d, 0x%X"

ins_bgt_ll_cr0:
.asciz "bgt- 0x%X"
ins_bgt_ml_cr0:
.asciz "bgt+ 0x%X"
ins_bgta_ll_cr0:
.asciz "bgta- 0x%X"
ins_bgta_ml_cr0:
.asciz "bgta+ 0x%X"
ins_bgtl_ll_cr0:
.asciz "bgtl- 0x%X"
ins_bgtl_ml_cr0:
.asciz "bgtl+ 0x%X"
ins_bgtla_ll_cr0:
.asciz "bgtla- 0x%X"
ins_bgtla_ml_cr0:
.asciz "bgtla+ 0x%X"
ins_bgt_ll:
.asciz "bgt- cr%d, 0x%X"
ins_bgt_ml:
.asciz "bgt+ cr%d, 0x%X"
ins_bgta_ll:
.asciz "bgta- cr%d, 0x%X"
ins_bgta_ml:
.asciz "bgta+ cr%d, 0x%X"
ins_bgtl_ll:
.asciz "bgtl- cr%d, 0x%X"
ins_bgtl_ml:
.asciz "bgtl+ cr%d, 0x%X"
ins_bgtla_ll:
.asciz "bgtla- cr%d, 0x%X"
ins_bgtla_ml:
.asciz "bgtla+ cr%d, 0x%X"

ins_beq_ll_cr0:
.asciz "beq- 0x%X"
ins_beq_ml_cr0:
.asciz "beq+ 0x%X"
ins_beqa_ll_cr0:
.asciz "beqa- 0x%X"
ins_beqa_ml_cr0:
.asciz "beqa+ 0x%X"
ins_beql_ll_cr0:
.asciz "beql- 0x%X"
ins_beql_ml_cr0:
.asciz "beql+ 0x%X"
ins_beqla_ll_cr0:
.asciz "beqla- 0x%X"
ins_beqla_ml_cr0:
.asciz "beqla+ 0x%X"
ins_beq_ll:
.asciz "beq- cr%d, 0x%X"
ins_beq_ml:
.asciz "beq+ cr%d, 0x%X"
ins_beqa_ll:
.asciz "beqa- cr%d, 0x%X"
ins_beqa_ml:
.asciz "beqa+ cr%d, 0x%X"
ins_beql_ll:
.asciz "beql- cr%d, 0x%X"
ins_beql_ml:
.asciz "beql+ cr%d, 0x%X"
ins_beqla_ll:
.asciz "beqla- cr%d, 0x%X"
ins_beqla_ml:
.asciz "beqla+ cr%d, 0x%X"

ins_bso_ll_cr0:
.asciz "bso- 0x%X"
ins_bso_ml_cr0:
.asciz "bso+ 0x%X"
ins_bsoa_ll_cr0:
.asciz "bsoa- 0x%X"
ins_bsoa_ml_cr0:
.asciz "bsoa+ 0x%X"
ins_bsol_ll_cr0:
.asciz "bsol- 0x%X"
ins_bsol_ml_cr0:
.asciz "bsol+ 0x%X"
ins_bsola_ll_cr0:
.asciz "bsola- 0x%X"
ins_bsola_ml_cr0:
.asciz "bsola+ 0x%X"
ins_bso_ll:
.asciz "bso- cr%d, 0x%X"
ins_bso_ml:
.asciz "bso+ cr%d, 0x%X"
ins_bsoa_ll:
.asciz "bsoa- cr%d, 0x%X"
ins_bsoa_ml:
.asciz "bsoa+ cr%d, 0x%X"
ins_bsol_ll:
.asciz "bsol- cr%d, 0x%X"
ins_bsol_ml:
.asciz "bsol+ cr%d, 0x%X"
ins_bsola_ll:
.asciz "bsola- cr%d, 0x%X"
ins_bsola_ml:
.asciz "bsola+ cr%d, 0x%X"

ins_bdnz_ll:
.asciz "bdnz- 0x%X"
ins_bdnz_ml:
.asciz "bdnz+ 0x%X"
ins_bdnza_ll:
.asciz "bdnza- 0x%X"
ins_bdnza_ml:
.asciz "bdnza+ 0x%X"
ins_bdnzl_ll:
.asciz "bdnzl- 0x%X"
ins_bdnzl_ml:
.asciz "bdnzl+ 0x%X"
ins_bdnzla_ll:
.asciz "bdnzla- 0x%X"
ins_bdnzla_ml:
.asciz "bdnzla+ 0x%X"

ins_bdz_ll:
.asciz "bdz- 0x%X"
ins_bdz_ml:
.asciz "bdz+ 0x%X"
ins_bdza_ll:
.asciz "bdza- 0x%X"
ins_bdza_ml:
.asciz "bdza+ 0x%X"
ins_bdzl_ll:
.asciz "bdzl- 0x%X"
ins_bdzl_ml:
.asciz "bdzl+ 0x%X"
ins_bdzla_ll:
.asciz "bdzla- 0x%X"
ins_bdzla_ml:
.asciz "bdzla+ 0x%X"

ins_bcalways:
.asciz "bal 0x%0X"
ins_bcalwaysA:
.asciz "bala 0x%0X"
ins_bcalwaysL:
.asciz "ball 0x%0X"
ins_bcalwaysAL:
.asciz "balla 0x%0X"

//
ins_bdnzfctr_ll:
.asciz "bdnzfctr- %d"
ins_bdnzfctr_ml:
.asciz "bdnzfctr+ %d"
ins_bdnzfctrl_ll:
.asciz "bdnzfctrl- %d"
ins_bdnzfctrl_ml:
.asciz "bdnzfctrl+ %d"

ins_bdzfctr_ll:
.asciz "bdzfctr- %d"
ins_bdzfctr_ml:
.asciz "bdzfctr+ %d"
ins_bdzfctrl_ll:
.asciz "bdzfctrl- %d"
ins_bdzfctrl_ml:
.asciz "bdzfctrl+ %d"

ins_bgectr_ll_cr0:
.asciz "bgectr-"
ins_bgectr_ml_cr0:
.asciz "bgectr+"
ins_bgectrl_ll_cr0:
.asciz "bgectrl-"
ins_bgectrl_ml_cr0:
.asciz "bgectrl+"
ins_bgectr_ll:
.asciz "bgectr- cr%d"
ins_bgectr_ml:
.asciz "bgectr+ cr%d"
ins_bgectrl_ll:
.asciz "bgectrl- cr%d"
ins_bgectrl_ml:
.asciz "bgectrl+ cr%d"

ins_blectr_ll_cr0:
.asciz "blectr-"
ins_blectr_ml_cr0:
.asciz "blectr+"
ins_blectrl_ll_cr0:
.asciz "blectrl-"
ins_blectrl_ml_cr0:
.asciz "blectrl+"
ins_blectr_ll:
.asciz "blectr- cr%d"
ins_blectr_ml:
.asciz "blectr+ cr%d"
ins_blectrl_ll:
.asciz "blectrl- cr%d"
ins_blectrl_ml:
.asciz "blectrl+ cr%d"

ins_bnectr_ll_cr0:
.asciz "bnectr-"
ins_bnectr_ml_cr0:
.asciz "bnectr+"
ins_bnectrl_ll_cr0:
.asciz "bnectrl-"
ins_bnectrl_ml_cr0:
.asciz "bnectrl+"
ins_bnectr_ll:
.asciz "bnectr- cr%d"
ins_bnectr_ml:
.asciz "bnectr+ cr%d"
ins_bnectrl_ll:
.asciz "bnectrl- cr%d"
ins_bnectrl_ml:
.asciz "bnectrl+ cr%d"

ins_bnsctr_ll_cr0:
.asciz "bnsctr-"
ins_bnsctr_ml_cr0:
.asciz "bnsctr+"
ins_bnsctrl_ll_cr0:
.asciz "bnsctrl-"
ins_bnsctrl_ml_cr0:
.asciz "bnsctrl+"
ins_bnsctr_ll:
.asciz "bnsctr- cr%d"
ins_bnsctr_ml:
.asciz "bnsctr+ cr%d"
ins_bnsctrl_ll:
.asciz "bnsctrl- cr%d"
ins_bnsctrl_ml:
.asciz "bnsctrl+ cr%d"

ins_bdnztctr_ll:
.asciz "bdnztctr- %d"
ins_bdnztctr_ml:
.asciz "bdnztctr+ %d"
ins_bdnztctrl_ll:
.asciz "bdnztctrl- %d"
ins_bdnztctrl_ml:
.asciz "bdnztctrl+ %d"

ins_bdztctr_ll:
.asciz "bdztctr- %d"
ins_bdztctr_ml:
.asciz "bdztctr+ %d"
ins_bdztctrl_ll:
.asciz "bdztctrl- %d"
ins_bdztctrl_ml:
.asciz "bdztctrl+ %d"

ins_bltctr_ll_cr0:
.asciz "bltctr-"
ins_bltctr_ml_cr0:
.asciz "bltctr+"
ins_bltctrl_ll_cr0:
.asciz "bltctrl-"
ins_bltctrl_ml_cr0:
.asciz "bltctrl+"
ins_bltctr_ll:
.asciz "bltctr- cr%d"
ins_bltctr_ml:
.asciz "bltctr+ cr%d"
ins_bltctrl_ll:
.asciz "bltctrl- cr%d"
ins_bltctrl_ml:
.asciz "bltctrl+ cr%d"

ins_bgtctr_ll_cr0:
.asciz "bgtctr-"
ins_bgtctr_ml_cr0:
.asciz "bgtctr+"
ins_bgtctrl_ll_cr0:
.asciz "bgtctrl-"
ins_bgtctrl_ml_cr0:
.asciz "bgtctrl+"
ins_bgtctr_ll:
.asciz "bgtctr- cr%d"
ins_bgtctr_ml:
.asciz "bgtctr+ cr%d"
ins_bgtctrl_ll:
.asciz "bgtctrl- cr%d"
ins_bgtctrl_ml:
.asciz "bgtctrl+ cr%d"

ins_beqctr_ll_cr0:
.asciz "beqctr-"
ins_beqctr_ml_cr0:
.asciz "beqctr+"
ins_beqctrl_ll_cr0:
.asciz "beqctrl-"
ins_beqctrl_ml_cr0:
.asciz "beqctrl+"
ins_beqctr_ll:
.asciz "beqctr- cr%d"
ins_beqctr_ml:
.asciz "beqctr+ cr%d"
ins_beqctrl_ll:
.asciz "beqctrl- cr%d"
ins_beqctrl_ml:
.asciz "beqctrl+ cr%d"

ins_bsoctr_ll_cr0:
.asciz "bsoctr-"
ins_bsoctr_ml_cr0:
.asciz "bsoctr+"
ins_bsoctrl_ll_cr0:
.asciz "bsoctrl-"
ins_bsoctrl_ml_cr0:
.asciz "bsoctrl+"
ins_bsoctr_ll:
.asciz "bsoctr- cr%d"
ins_bsoctr_ml:
.asciz "bsoctr+ cr%d"
ins_bsoctrl_ll:
.asciz "bsoctrl- cr%d"
ins_bsoctrl_ml:
.asciz "bsoctrl+ cr%d"

ins_bdnzctr_ll:
.asciz "bdnzctr-"
ins_bdnzctr_ml:
.asciz "bdnzctr+"
ins_bdnzctrl_ll:
.asciz "bdnzctrl-"
ins_bdnzctrl_ml:
.asciz "bdnzctrl+"

ins_bdzctr_ll:
.asciz "bdzctr-"
ins_bdzctr_ml:
.asciz "bdzctr+"
ins_bdzctrl_ll:
.asciz "bdzctrl-"
ins_bdzctrl_ml:
.asciz "bdzctrl+"

ins_bctr:
.asciz "bctr"
ins_bctrl:
.asciz "bctrl"

//
ins_bdnzflr_ll:
.asciz "bdnzflr- %d"
ins_bdnzflr_ml:
.asciz "bdnzflr+ %d"
ins_bdnzflrl_ll:
.asciz "bdnzflrl- %d"
ins_bdnzflrl_ml:
.asciz "bdnzflrl+ %d"

ins_bdzflr_ll:
.asciz "bdzflr- %d"
ins_bdzflr_ml:
.asciz "bdzflr+ %d"
ins_bdzflrl_ll:
.asciz "bdzflrl- %d"
ins_bdzflrl_ml:
.asciz "bdzflrl+ %d"

ins_bgelr_ll_cr0:
.asciz "bgelr-"
ins_bgelr_ml_cr0:
.asciz "bgelr+"
ins_bgelrl_ll_cr0:
.asciz "bgelrl-"
ins_bgelrl_ml_cr0:
.asciz "bgelrl+"
ins_bgelr_ll:
.asciz "bgelr- cr%d"
ins_bgelr_ml:
.asciz "bgelr+ cr%d"
ins_bgelrl_ll:
.asciz "bgelrl- cr%d"
ins_bgelrl_ml:
.asciz "bgelrl+ cr%d"

ins_blelr_ll_cr0:
.asciz "blelr-"
ins_blelr_ml_cr0:
.asciz "blelr+"
ins_blelrl_ll_cr0:
.asciz "blelrl-"
ins_blelrl_ml_cr0:
.asciz "blelrl+"
ins_blelr_ll:
.asciz "blelr- cr%d"
ins_blelr_ml:
.asciz "blelr+ cr%d"
ins_blelrl_ll:
.asciz "blelrl- cr%d"
ins_blelrl_ml:
.asciz "blelrl+ cr%d"

ins_bnelr_ll_cr0:
.asciz "bnelr-"
ins_bnelr_ml_cr0:
.asciz "bnelr+"
ins_bnelrl_ll_cr0:
.asciz "bnelrl-"
ins_bnelrl_ml_cr0:
.asciz "bnelrl+"
ins_bnelr_ll:
.asciz "bnelr- cr%d"
ins_bnelr_ml:
.asciz "bnelr+ cr%d"
ins_bnelrl_ll:
.asciz "bnelrl- cr%d"
ins_bnelrl_ml:
.asciz "bnelrl+ cr%d"

ins_bnslr_ll_cr0:
.asciz "bnslr-"
ins_bnslr_ml_cr0:
.asciz "bnslr+"
ins_bnslrl_ll_cr0:
.asciz "bnslrl-"
ins_bnslrl_ml_cr0:
.asciz "bnslrl+"
ins_bnslr_ll:
.asciz "bnslr- cr%d"
ins_bnslr_ml:
.asciz "bnslr+ cr%d"
ins_bnslrl_ll:
.asciz "bnslrl- cr%d"
ins_bnslrl_ml:
.asciz "bnslrl+ cr%d"

ins_bdnztlr_ll:
.asciz "bdnztlr- %d"
ins_bdnztlr_ml:
.asciz "bdnztlr+ %d"
ins_bdnztlrl_ll:
.asciz "bdnztlrl- %d"
ins_bdnztlrl_ml:
.asciz "bdnztlrl+ %d"

ins_bdztlr_ll:
.asciz "bdztlr- %d"
ins_bdztlr_ml:
.asciz "bdztlr+ %d"
ins_bdztlrl_ll:
.asciz "bdztlrl- %d"
ins_bdztlrl_ml:
.asciz "bdztlrl+ %d"

ins_bltlr_ll_cr0:
.asciz "bltlr-"
ins_bltlr_ml_cr0:
.asciz "bltlr+"
ins_bltlrl_ll_cr0:
.asciz "bltlrl-"
ins_bltlrl_ml_cr0:
.asciz "bltlrl+"
ins_bltlr_ll:
.asciz "bltlr- cr%d"
ins_bltlr_ml:
.asciz "bltlr+ cr%d"
ins_bltlrl_ll:
.asciz "bltlrl- cr%d"
ins_bltlrl_ml:
.asciz "bltlrl+ cr%d"

ins_bgtlr_ll_cr0:
.asciz "bgtlr-"
ins_bgtlr_ml_cr0:
.asciz "bgtlr+"
ins_bgtlrl_ll_cr0:
.asciz "bgtlrl-"
ins_bgtlrl_ml_cr0:
.asciz "bgtlrl+"
ins_bgtlr_ll:
.asciz "bgtlr- cr%d"
ins_bgtlr_ml:
.asciz "bgtlr+ cr%d"
ins_bgtlrl_ll:
.asciz "bgtlrl- cr%d"
ins_bgtlrl_ml:
.asciz "bgtlrl+ cr%d"

ins_beqlr_ll_cr0:
.asciz "beqlr-"
ins_beqlr_ml_cr0:
.asciz "beqlr+"
ins_beqlrl_ll_cr0:
.asciz "beqlrl-"
ins_beqlrl_ml_cr0:
.asciz "beqlrl+"
ins_beqlr_ll:
.asciz "beqlr- cr%d"
ins_beqlr_ml:
.asciz "beqlr+ cr%d"
ins_beqlrl_ll:
.asciz "beqlrl- cr%d"
ins_beqlrl_ml:
.asciz "beqlrl+ cr%d"

ins_bsolr_ll_cr0:
.asciz "bsolr-"
ins_bsolr_ml_cr0:
.asciz "bsolr+"
ins_bsolrl_ll_cr0:
.asciz "bsolrl-"
ins_bsolrl_ml_cr0:
.asciz "bsolrl+"
ins_bsolr_ll:
.asciz "bsolr- cr%d"
ins_bsolr_ml:
.asciz "bsolr+ cr%d"
ins_bsolrl_ll:
.asciz "bsolrl- cr%d"
ins_bsolrl_ml:
.asciz "bsolrl+ cr%d"

ins_bdnzlr_ll:
.asciz "bdnzlr-"
ins_bdnzlr_ml:
.asciz "bdnzlr+"
ins_bdnzlrl_ll:
.asciz "bdnzlrl-"
ins_bdnzlrl_ml:
.asciz "bdnzlrl+"

ins_bdzlr_ll:
.asciz "bdzlr-"
ins_bdzlr_ml:
.asciz "bdzlr+"
ins_bdzlrl_ll:
.asciz "bdzlrl-"
ins_bdzlrl_ml:
.asciz "bdzlrl+"

ins_blr:
.asciz "blr"
ins_blrl:
.asciz "blrl"

//No valid instruction
invalid_instruction:
.asciz ".long 0x%08X"

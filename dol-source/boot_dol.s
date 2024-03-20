/*Plug this into any generic PPC32-bit Assembler. Name the output file to boot.dol and place in the /dol folder*/

text0_size = text0_end - text0_location
text1_size = text1_end - text1_location
text2_size = text2_end - text2_location
text3_size = text3_end - text3_location
text4_size = text4_end - text4_location
text5_size = text5_end - text5_location
text6_size = text6_end - text6_location
data0_size = data0_end - data0_location
data1_size = data1_end - data1_location
data2_size = data2_end - data2_location
data3_size = data3_end - data3_location
data4_size = data4_end - data4_location
data5_size = data5_end - data5_location
data6_size = data6_end - data6_location
data7_size = data7_end - data7_location
data8_size = data8_end - data8_location
data9_size = data9_end - data9_location
data10size = data10_end - data10_location

/*Offsets*/
dol_start:
.long text0_location - dol_start
.long text1_location - dol_start
.long text2_location - dol_start
.long text3_location - dol_start
.long text4_location - dol_start
.long text5_location - dol_start
.long text6_location - dol_start
.long data0_location - dol_start
.long data1_location - dol_start
.long data2_location - dol_start
.long data3_location - dol_start
.long data4_location - dol_start
.long data5_location - dol_start
.long data6_location - dol_start
.long data7_location - dol_start
.long data8_location - dol_start
.long data9_location - dol_start
.long data10_location - dol_start

/*Text0 loading addr, text1 loading addr... etc etc til Data 11 loading addr*/
.long 0x00003400 /*Text0 loading addr*/
.long 0 /*Text1 loading addr*/
.long 0
.long 0
.long 0
.long 0
.long 0 /*Text6 loading addr*/
.long 0 /*Data0 loading addr*/
.long 0
.long 0
.long 0
.long 0
.long 0
.long 0
.long 0
.long 0
.long 0
.long 0 /*Data10 loading addr*/

/*Section Sizes*/
.long text0_size
.long text1_size
.long text2_size
.long text3_size
.long text4_size
.long text5_size
.long text6_size
.long data0_size
.long data1_size
.long data2_size
.long data3_size
.long data4_size
.long data5_size
.long data6_size
.long data7_size
.long data8_size
.long data9_size
.long data10_size

/*BSS Address*/
.long 0

/*BSS size*/
.long 0

/*Entry point; MUST be physical*/
.long 0x00003400

/*Padding*/
.zero 28

/*Example instructions, replace these with your own entire source!*/
text0_location:
add r1, r2, r3
add r4, r1, r1
text0_end:

text1_location:
text1_end:

text2_location:
text2_end:

text3_location:
text3_end:

text4_location:
text4_end:

text5_location:
text5_end:

text6_location:
text6_end:

data0_location:
data0_end:

data1_location:
data1_end:

data2_location:
data2_end:

data3_location:
data3_end:

data4_location:
data4_end:

data5_location:
data5_end:

data6_location:
data6_end:

data7_location:
data7_end:

data8_location:
data8_end:

data9_location:
data9_end:

data10_location:
data10_end:

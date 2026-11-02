/******************************************************************************************
  Filename    : intvect.s

  Core        : RH850G3K (v850e3v5)

  Mcu         : R7F701030xAFP (RH850/F1L)

  Author      : Chalandi Amine

  Owner       : Chalandi Amine

  Date        : 28.10.2026

  Description : Interrupt vector table for RH850G3K

******************************************************************************************/

/*******************************************************************************************
  \brief  
  
  \param  
  
  \return 
********************************************************************************************/
.section .text
.type _unused_isr, @function
.align 2
.globl _unused_isr

_unused_isr:
    br .
.size _unused_isr, .-_unused_isr

/*******************************************************************************************
  \brief  
  
  \param  
  
  \return 
********************************************************************************************/
.macro SaveCpuContext
    addi -4*31, sp, sp
    st.w r1, (0*4)[sp]
    st.w r2, (1*4)[sp]
    st.w r3, (2*4)[sp]
    st.w r4, (3*4)[sp]
    st.w r5, (4*4)[sp]
    st.w r6, (5*4)[sp]
    st.w r7, (6*4)[sp]
    st.w r8, (7*4)[sp]
    st.w r9, (8*4)[sp]
    st.w r10, (9*4)[sp]
    st.w r11, (10*4)[sp]
    st.w r12, (11*4)[sp]
    st.w r13, (12*4)[sp]
    st.w r14, (13*4)[sp]
    st.w r15, (14*4)[sp]
    st.w r16, (15*4)[sp]
    st.w r17, (16*4)[sp]
    st.w r18, (17*4)[sp]
    st.w r19, (18*4)[sp]
    st.w r20, (19*4)[sp]
    st.w r21, (20*4)[sp]
    st.w r22, (21*4)[sp]
    st.w r23, (22*4)[sp]
    st.w r24, (23*4)[sp]
    st.w r25, (24*4)[sp]
    st.w r26, (25*4)[sp]
    st.w r27, (26*4)[sp]
    st.w r28, (27*4)[sp]
    st.w r29, (28*4)[sp]
    st.w r30, (29*4)[sp]
    st.w r31, (30*4)[sp]
.endm
/*******************************************************************************************
  \brief  
  
  \param  
  
  \return 
********************************************************************************************/
.macro RestoreCpuContext
    ld.w (0*4)[sp], r1
    ld.w (1*4)[sp], r2
    ld.w (2*4)[sp], r3
    ld.w (3*4)[sp], r4
    ld.w (4*4)[sp], r5
    ld.w (5*4)[sp], r6
    ld.w (6*4)[sp], r7
    ld.w (7*4)[sp], r8
    ld.w (8*4)[sp], r9
    ld.w (9*4)[sp], r10
    ld.w (10*4)[sp], r11
    ld.w (11*4)[sp], r12
    ld.w (12*4)[sp], r13
    ld.w (13*4)[sp], r14
    ld.w (14*4)[sp], r15
    ld.w (15*4)[sp], r16
    ld.w (16*4)[sp], r17
    ld.w (17*4)[sp], r18
    ld.w (18*4)[sp], r19
    ld.w (19*4)[sp], r20
    ld.w (20*4)[sp], r21
    ld.w (21*4)[sp], r22
    ld.w (22*4)[sp], r23
    ld.w (23*4)[sp], r24
    ld.w (24*4)[sp], r25
    ld.w (25*4)[sp], r26
    ld.w (26*4)[sp], r27
    ld.w (27*4)[sp], r28
    ld.w (28*4)[sp], r29
    ld.w (29*4)[sp], r30
    ld.w (30*4)[sp], r31
    addi 4*31, sp, sp
.endm

/*******************************************************************************************
  \brief  
  
  \param  
  
  \return 
********************************************************************************************/
.macro isr_wrapper isr_func
    .section .text
    .type _wrapper_\isr_func, @function
    .align 2
    .globl _wrapper_\isr_func
_wrapper_\isr_func:
        SaveCpuContext
        jarl \isr_func ,lp
        RestoreCpuContext
        eiret
    .size _wrapper_\isr_func, .-_wrapper_\isr_func
.endm

/*******************************************************************************************
  \brief  
  
  \param  
  
  \return 
********************************************************************************************/
isr_wrapper _timer_isr

/*******************************************************************************************
  \brief  
  
  \param  
  
  \return 
********************************************************************************************/
#.section .text
#.type __timer_isr, @function
#.align 2
#.globl __timer_isr

#__timer_isr:
#    call_isr _timer_isr
#.size __timer_isr, .-__timer_isr

/*******************************************************************************************
  \brief  
  
  \param  
  
  \return 
********************************************************************************************/
.section .intvect
.type _intvecttable, @object
.align 9
.globl _intvecttable

_intvecttable:

    .word _unused_isr /* int[0] */
    .word _unused_isr /* int[1] */
    .word _unused_isr /* int[2] */
    .word _unused_isr /* int[3] */
    .word _unused_isr /* int[4] */
    .word _unused_isr /* int[5] */
    .word _unused_isr /* int[6] */
    .word _unused_isr /* int[7] */
    .word _unused_isr /* int[8] */
    .word _unused_isr /* int[9] */
    .word _unused_isr /* int[10] */
    .word _unused_isr /* int[11] */
    .word _unused_isr /* int[12] */
    .word _unused_isr /* int[13] */
    .word _unused_isr /* int[14] */
    .word _unused_isr /* int[15] */
    .word _unused_isr /* int[16] */
    .word _unused_isr /* int[17] */
    .word _unused_isr /* int[18] */
    .word _unused_isr /* int[19] */
    .word _unused_isr /* int[20] */
    .word _unused_isr /* int[21] */
    .word _unused_isr /* int[22] */
    .word _unused_isr /* int[23] */
    .word _unused_isr /* int[24] */
    .word _unused_isr /* int[25] */
    .word _unused_isr /* int[26] */
    .word _unused_isr /* int[27] */
    .word _unused_isr /* int[28] */
    .word _unused_isr /* int[29] */
    .word _unused_isr /* int[30] */
    .word _unused_isr /* int[31] */
    .word _unused_isr /* int[32] */
    .word _unused_isr /* int[33] */
    .word _unused_isr /* int[34] */
    .word _unused_isr /* int[35] */
    .word _unused_isr /* int[36] */
    .word _unused_isr /* int[37] */
    .word _unused_isr /* int[38] */
    .word _unused_isr /* int[39] */
    .word _unused_isr /* int[40] */
    .word _unused_isr /* int[41] */
    .word _unused_isr /* int[42] */
    .word _unused_isr /* int[43] */
    .word _unused_isr /* int[44] */
    .word _unused_isr /* int[45] */
    .word _unused_isr /* int[46] */
    .word _unused_isr /* int[47] */
    .word _unused_isr /* int[48] */
    .word _unused_isr /* int[49] */
    .word _unused_isr /* int[50] */
    .word _unused_isr /* int[51] */
    .word _unused_isr /* int[52] */
    .word _unused_isr /* int[53] */
    .word _unused_isr /* int[54] */
    .word _unused_isr /* int[55] */
    .word _unused_isr /* int[56] */
    .word _unused_isr /* int[57] */
    .word _unused_isr /* int[58] */
    .word _unused_isr /* int[59] */
    .word _unused_isr /* int[60] */
    .word _unused_isr /* int[61] */
    .word _unused_isr /* int[62] */
    .word _unused_isr /* int[63] */
    .word _unused_isr /* int[64] */
    .word _unused_isr /* int[65] */
    .word _unused_isr /* int[66] */
    .word _unused_isr /* int[67] */
    .word _unused_isr /* int[68] */
    .word _unused_isr /* int[69] */
    .word _unused_isr /* int[70] */
    .word _unused_isr /* int[71] */
    .word _unused_isr /* int[72] */
    .word _unused_isr /* int[73] */
    .word _unused_isr /* int[74] */
    .word _unused_isr /* int[75] */
    .word _wrapper__timer_isr                /* int[76] */
    .word _unused_isr /* int[77] */
    .word _unused_isr /* int[78] */
    .word _unused_isr /* int[79] */
    .word _unused_isr /* int[80] */
    .word _unused_isr /* int[81] */
    .word _unused_isr /* int[82] */
    .word _unused_isr /* int[83] */
    .word _unused_isr /* int[84] */
    .word _unused_isr /* int[85] */
    .word _unused_isr /* int[86] */
    .word _unused_isr /* int[87] */
    .word _unused_isr /* int[88] */
    .word _unused_isr /* int[89] */
    .word _unused_isr /* int[90] */
    .word _unused_isr /* int[91] */
    .word _unused_isr /* int[92] */
    .word _unused_isr /* int[93] */
    .word _unused_isr /* int[94] */
    .word _unused_isr /* int[95] */
    .word _unused_isr /* int[96] */
    .word _unused_isr /* int[97] */
    .word _unused_isr /* int[98] */
    .word _unused_isr /* int[99] */
    .word _unused_isr /* int[100] */
    .word _unused_isr /* int[101] */
    .word _unused_isr /* int[102] */
    .word _unused_isr /* int[103] */
    .word _unused_isr /* int[104] */
    .word _unused_isr /* int[105] */
    .word _unused_isr /* int[106] */
    .word _unused_isr /* int[107] */
    .word _unused_isr /* int[108] */
    .word _unused_isr /* int[109] */
    .word _unused_isr /* int[110] */
    .word _unused_isr /* int[111] */
    .word _unused_isr /* int[112] */
    .word _unused_isr /* int[113] */
    .word _unused_isr /* int[114] */
    .word _unused_isr /* int[115] */
    .word _unused_isr /* int[116] */
    .word _unused_isr /* int[117] */
    .word _unused_isr /* int[118] */
    .word _unused_isr /* int[119] */
    .word _unused_isr /* int[120] */
    .word _unused_isr /* int[121] */
    .word _unused_isr /* int[122] */
    .word _unused_isr /* int[123] */
    .word _unused_isr /* int[124] */
    .word _unused_isr /* int[125] */
    .word _unused_isr /* int[126] */
    .word _unused_isr /* int[127] */
    .word _unused_isr /* int[128] */
    .word _unused_isr /* int[129] */
    .word _unused_isr /* int[130] */
    .word _unused_isr /* int[131] */
    .word _unused_isr /* int[132] */
    .word _unused_isr /* int[133] */
    .word _unused_isr /* int[134] */
    .word _unused_isr /* int[135] */
    .word _unused_isr /* int[136] */
    .word _unused_isr /* int[137] */
    .word _unused_isr /* int[138] */
    .word _unused_isr /* int[139] */
    .word _unused_isr /* int[140] */
    .word _unused_isr /* int[141] */
    .word _unused_isr /* int[142] */
    .word _unused_isr /* int[143] */
    .word _unused_isr /* int[144] */
    .word _unused_isr /* int[145] */
    .word _unused_isr /* int[146] */
    .word _unused_isr /* int[147] */
    .word _unused_isr /* int[148] */
    .word _unused_isr /* int[149] */
    .word _unused_isr /* int[150] */
    .word _unused_isr /* int[151] */
    .word _unused_isr /* int[152] */
    .word _unused_isr /* int[153] */
    .word _unused_isr /* int[154] */
    .word _unused_isr /* int[155] */
    .word _unused_isr /* int[156] */
    .word _unused_isr /* int[157] */
    .word _unused_isr /* int[158] */
    .word _unused_isr /* int[159] */
    .word _unused_isr /* int[160] */
    .word _unused_isr /* int[161] */
    .word _unused_isr /* int[162] */
    .word _unused_isr /* int[163] */
    .word _unused_isr /* int[164] */
    .word _unused_isr /* int[165] */
    .word _unused_isr /* int[166] */
    .word _unused_isr /* int[167] */
    .word _unused_isr /* int[168] */
    .word _unused_isr /* int[169] */
    .word _unused_isr /* int[170] */
    .word _unused_isr /* int[171] */
    .word _unused_isr /* int[172] */
    .word _unused_isr /* int[173] */
    .word _unused_isr /* int[174] */
    .word _unused_isr /* int[175] */
    .word _unused_isr /* int[176] */
    .word _unused_isr /* int[177] */
    .word _unused_isr /* int[178] */
    .word _unused_isr /* int[179] */
    .word _unused_isr /* int[180] */
    .word _unused_isr /* int[181] */
    .word _unused_isr /* int[182] */
    .word _unused_isr /* int[183] */
    .word _unused_isr /* int[184] */
    .word _unused_isr /* int[185] */
    .word _unused_isr /* int[186] */
    .word _unused_isr /* int[187] */
    .word _unused_isr /* int[188] */
    .word _unused_isr /* int[189] */
    .word _unused_isr /* int[190] */
    .word _unused_isr /* int[191] */
    .word _unused_isr /* int[192] */
    .word _unused_isr /* int[193] */
    .word _unused_isr /* int[194] */
    .word _unused_isr /* int[195] */
    .word _unused_isr /* int[196] */
    .word _unused_isr /* int[197] */
    .word _unused_isr /* int[198] */
    .word _unused_isr /* int[199] */
    .word _unused_isr /* int[200] */
    .word _unused_isr /* int[201] */
    .word _unused_isr /* int[202] */
    .word _unused_isr /* int[203] */
    .word _unused_isr /* int[204] */
    .word _unused_isr /* int[205] */
    .word _unused_isr /* int[206] */
    .word _unused_isr /* int[207] */
    .word _unused_isr /* int[208] */
    .word _unused_isr /* int[209] */
    .word _unused_isr /* int[210] */
    .word _unused_isr /* int[211] */
    .word _unused_isr /* int[212] */
    .word _unused_isr /* int[213] */
    .word _unused_isr /* int[214] */
    .word _unused_isr /* int[215] */
    .word _unused_isr /* int[216] */
    .word _unused_isr /* int[217] */
    .word _unused_isr /* int[218] */
    .word _unused_isr /* int[219] */
    .word _unused_isr /* int[220] */
    .word _unused_isr /* int[221] */
    .word _unused_isr /* int[222] */
    .word _unused_isr /* int[223] */
    .word _unused_isr /* int[224] */
    .word _unused_isr /* int[225] */
    .word _unused_isr /* int[226] */
    .word _unused_isr /* int[227] */
    .word _unused_isr /* int[228] */
    .word _unused_isr /* int[229] */
    .word _unused_isr /* int[230] */
    .word _unused_isr /* int[231] */
    .word _unused_isr /* int[232] */
    .word _unused_isr /* int[233] */
    .word _unused_isr /* int[234] */
    .word _unused_isr /* int[235] */
    .word _unused_isr /* int[236] */
    .word _unused_isr /* int[237] */
    .word _unused_isr /* int[238] */
    .word _unused_isr /* int[239] */
    .word _unused_isr /* int[240] */
    .word _unused_isr /* int[241] */
    .word _unused_isr /* int[242] */
    .word _unused_isr /* int[243] */
    .word _unused_isr /* int[244] */
    .word _unused_isr /* int[245] */
    .word _unused_isr /* int[246] */
    .word _unused_isr /* int[247] */
    .word _unused_isr /* int[248] */
    .word _unused_isr /* int[249] */
    .word _unused_isr /* int[250] */
    .word _unused_isr /* int[251] */
    .word _unused_isr /* int[252] */
    .word _unused_isr /* int[253] */
    .word _unused_isr /* int[254] */
    .word _unused_isr /* int[255] */
    .word _unused_isr /* int[256] */
    .word _unused_isr /* int[257] */
    .word _unused_isr /* int[258] */
    .word _unused_isr /* int[259] */
    .word _unused_isr /* int[260] */
    .word _unused_isr /* int[261] */
    .word _unused_isr /* int[262] */
    .word _unused_isr /* int[263] */
    .word _unused_isr /* int[264] */
    .word _unused_isr /* int[265] */
    .word _unused_isr /* int[266] */
    .word _unused_isr /* int[267] */
    .word _unused_isr /* int[268] */
    .word _unused_isr /* int[269] */
    .word _unused_isr /* int[270] */
    .word _unused_isr /* int[271] */
    .word _unused_isr /* int[272] */
    .word _unused_isr /* int[273] */
    .word _unused_isr /* int[274] */
    .word _unused_isr /* int[275] */
    .word _unused_isr /* int[276] */
    .word _unused_isr /* int[277] */
    .word _unused_isr /* int[278] */
    .word _unused_isr /* int[279] */
    .word _unused_isr /* int[280] */
    .word _unused_isr /* int[281] */
    .word _unused_isr /* int[282] */
    .word _unused_isr /* int[283] */
    .word _unused_isr /* int[284] */
    .word _unused_isr /* int[285] */
    .word _unused_isr /* int[286] */
    .word _unused_isr /* int[287] */
    .word _unused_isr /* int[288] */
    .word _unused_isr /* int[289] */
    .word _unused_isr /* int[290] */
    .word _unused_isr /* int[291] */
    .word _unused_isr /* int[292] */
    .word _unused_isr /* int[293] */
    .word _unused_isr /* int[294] */
    .word _unused_isr /* int[295] */
    .word _unused_isr /* int[296] */
    .word _unused_isr /* int[297] */
    .word _unused_isr /* int[298] */
    .word _unused_isr /* int[299] */

.size _intvecttable, .-_intvecttable

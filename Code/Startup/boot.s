/******************************************************************************************
  Filename    : boot.s

  Core        : V850ES/JG3-L

  Mcu         : μPD70F3793

  Author      : Chalandi Amine

  Owner       : Chalandi Amine

  Date        : 28.10.2026

  Description : boot routine for V850ES

******************************************************************************************/

.section .boot
.type _start, @function
.align 2
.globl _start


_start:
    # set reset vector base address to 0
    ldsr r0, sr2, 1

    # set exception handler vector address to 0
    ldsr r0, sr3, 1

    # set base address of the interrupt handler table
    movhi hi(_intvecttable), r0, r1
    movea lo(_intvecttable), r1, r1
    ldsr r1, sr4, 1

    # enable the PLL (96MHz)
    jarl _pll_init, lp

    # setup the stack pointer
    movhi hi(__STACK_TOP), r0, sp
    movea lo(__STACK_TOP), sp, sp

    # enable interrupt
    ei

    # call C/C++ runtime initialization
    jr _Startup_Init


.size _start, .-_start

/******************************************************************************************
  Filename    : exceptvect.s

  Core        : RH850G3K (v850e3v5)

  Mcu         : R7F701030xAFP (RH850/F1L)

  Author      : Chalandi Amine

  Owner       : Chalandi Amine

  Date        : 28.10.2026

  Description : Exception vector table for RH850G3K

******************************************************************************************/

.section .exceptvect
.type exception_vect_table, @function
.align 2
.globl exception_vect_table

exception_vect_table:
    .balign 0x10
    vector_0x00:
        jr _start

    .balign 0x10
    vector_0x10:
        br .

    .balign 0x10
    vector_0x20:
        br .

    .balign 0x10
    vector_0x30:
        br .

    .balign 0x10
    vector_0x40:
        br .

    .balign 0x10
    vector_0x50:
        br .

    .balign 0x10
    vector_0x60:
        br .

    .balign 0x10
    vector_0x70:
        br .

    .balign 0x10
    vector_0x80:
        br .

    .balign 0x10
    vector_0x90:
        br .

    .balign 0x10
    vector_0xa0:
        br .

    .balign 0x10
    vector_0xb0:
        br .

    .balign 0x10
    vector_0xc0:
        br .

    .balign 0x10
    vector_0xd0:
        br .

    .balign 0x10
    vector_0xe0:
        br .

    .balign 0x10
    vector_0xf0:
        br .

    .balign 0x10
    vector_0x100:
        br .

    .balign 0x10
    vector_0x110:
        br .

    .balign 0x10
    vector_0x120:
        br .

    .balign 0x10
    vector_0x130:
        br .

    .balign 0x10
    vector_0x140:
        br .

    .balign 0x10
    vector_0x150:
        br .

    .balign 0x10
    vector_0x160:
        br .

    .balign 0x10
    vector_0x170:
        br .

.size exception_vect_table, .-exception_vect_table

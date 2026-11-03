# Bare Metal RH850/F1L Project

[![Build Status](https://github.com/Chalandi/Baremetal_RH850_nosdk/actions/workflows/Baremetal_RH850_nosdk.yml/badge.svg)](https://github.com/Chalandi/Baremetal_RH850_nosdk/actions)

This repository contains a bare-metal firmware project for the Renesas RH850/F1L family, targeting the R7F701030xAFP microcontroller. The project is designed to provide a clean and educational starting point for embedded software development without relying on Renesas’ proprietary SDK.

The codebase focuses on direct register access, custom startup initialization, linker configuration, and a GNU Make-based build flow. It is intended for learning, experimentation, and firmware development in a zero-dependency embedded environment.

## Overview

This project demonstrates how to build a firmware image from scratch using:

- C11 for application logic
- Assembly for startup and interrupt handling
- A custom linker script for memory layout
- A custom Makefile for compilation, linking, and output generation
- Generic GNU toolchain support for RH850 targets

The repository is organized to separate low-level infrastructure from application code, making it easier to understand how a bare-metal firmware project is structured.

## Application Behavior

The RH850/G3K core starts executing from its reset vector. The bootstrap configures both RBASE and EBASE to be located at address 0 using the table reference method for handling peripheral interrupts, and initializes the PLL and stack pointer before calling the handwritten C/C++ runtime environment setup.

The handwritten C/C++ runtime environment calls main(), which configures the LED1 port 10 pin 3 as an output and sets up the OSTM0 timer for a 500 ms timeout interrupt.

On each interrupt signal, the OSTM0 ISR toggles LED1.

## Repository Structure

```text
.
├── Build                              # Build scripts and Makefile
│   ├── Build.ps1
│   ├── Build.sh
│   ├── Clean.ps1
│   ├── Clean.sh
│   ├── Makefile
│   ├── Rebuild.ps1
│   └── Rebuild.sh
├── Code                               # Firmware source files
│   ├── Appli
│   │   └── main.c
│   ├── Mcal
│   │   ├── ostm.c
│   │   └── pll.c
│   ├── RH850_F1L.ld
│   ├── Startup
│   │   ├── boot.s
│   │   ├── exceptvect.s
│   │   ├── intvect.s
│   │   └── Startup.c
│   └── StdLib
│       ├── printf/
│       └── StdLib.c
├── Doc                                 # Vendor documentation
│   ├── r01uh0390ej0133_rh850f1l.pdf
│   ├── R20UT2940ED0100_RH850F1x.pdf
│   ├── REN_r01ds0170ej0131_rh850f1l_176pin_DST_20171026_1.pdf
│   └── REN_r01us0125ej0120_rh850g3k_MAS_20180729_1.pdf
├── LICENSE
├── README.md
├── Output/                            # Generated firmware artifacts
└── Tools                              # Utility and flashing tools
    ├── RFI
    │   └── RFP_CLI_Linux_V32500_x64.tgz
    └── scripts
        ├── CompilerErrorFormater.py
        └── LinkerErrorFormater.py

```

## Building the Project

From the repository root, run:

```
cd ./Build
./Rebuild.sh
```

You can also use:

```
./Build/Build.sh
```

The build process compiles the firmware and generates output files in the `Output` directory, including:

- ELF executable
- HEX file
- BIN file
- MAP file
- Disassembly and symbol-related reports

## Flashing the Binary

After a successful build, use Renesas Flash Programmer tool from the `Tools` folder to flash the generated firmware image to the target board.

## Tools

The following tools are needed to build and flash the application :

| Tool                        | Link                                                         |
| --------------------------- | ------------------------------------------------------------ |
| V850 GCC compiler (Linux)   | [gcc-16.2.0-v850-unknown-elf.tar.gz](https://github.com/ckormanyos/gcc-v850-unknown-elf/releases/download/v16.2.0/gcc-16.2.0-v850-unknown-elf.tar.gz) |
| V850 GCC compiler (Windows) | [gcc-16.2.0-v850-unknown-elf_x86_64-w64-mingw32.zip](https://github.com/ckormanyos/gcc-v850-unknown-elf/releases/download/v16.2.0/gcc-16.2.0-v850-unknown-elf_x86_64-w64-mingw32.zip) |
| Renesas Flash Programmer V3.25 (Linux)    | [RFP_CLI_Linux_V32500_x64.tgz](https://github.com/Chalandi/Baremetal_v850es_nosdk/blob/master/Tools/RFI/RFP_CLI_Linux_V32500_x64.tgz) |


## Continuous Integration

The repository includes GitHub Actions-based continuous integration to validate the project build on a clean environment. CI runs automatically for pushes and pull requests using `ubuntu-latest`.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more information.

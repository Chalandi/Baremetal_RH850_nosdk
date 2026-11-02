# ******************************************************************************************
#   Filename    : Makefile
#
#   Author      : Chalandi Amine
#
#   Owner       : Chalandi Amine
#
#   Date        : 30.08.2026
#
#   Description : Build system
#
# ******************************************************************************************

############################################################################################
# Defines
############################################################################################
PRJ_NAME   = RH850_F1L
ROOT_DIR   = $(abspath $(CURDIR)/..)
OUTPUT_DIR = $(ROOT_DIR)/Output
TOOLS_DIR  = $(ROOT_DIR)/Tools
OBJ_DIR    = $(OUTPUT_DIR)/obj
SRC_DIR    = $(ROOT_DIR)/Code
LD_SCRIPT  = $(SRC_DIR)/$(PRJ_NAME).ld
PRJ_FILE   = $(OUTPUT_DIR)/$(PRJ_NAME)
ELF_FILE   = $(PRJ_FILE).elf


PYTHON = python
ERR_MSG_FORMATER_SCRIPT = $(TOOLS_DIR)/scripts/CompilerErrorFormater.py
LINKER_ERR_MSG_FORMATER_SCRIPT = $(TOOLS_DIR)/scripts/LinkerErrorFormater.py
FORMAT_LINKER_ERR =

RTOS = 

LOCKDIR := $(OUTPUT_DIR)/err_formatter.lock

############################################################################################
# Toolchain
############################################################################################
TOOLCHAIN ?= v850-unknown-elf

AS      = $(TOOLCHAIN)-gcc
CC      = $(TOOLCHAIN)-gcc
CPP     = $(TOOLCHAIN)-g++
LD      = $(TOOLCHAIN)-gcc
OBJDUMP = $(TOOLCHAIN)-objdump
OBJCOPY = $(TOOLCHAIN)-objcopy
SIZE    = $(TOOLCHAIN)-size
READELF = $(TOOLCHAIN)-readelf

ARCH      = -mv850e3v5                                               \
            -msoft-float                                             \
            -mtda=0 -msda=0 -Wl,--defsym=__gp=0 -Wl,--defsym=__ep=0  \
            -falign-functions=4                                      \
            -fomit-frame-pointer

DEFS = -DPRINTF_INCLUDE_CONFIG_H

############################################################################################
# Optimization Compiler flags
############################################################################################

OPT_MODIFIED_O2 = -O2                               \
                  -fno-reorder-blocks-and-partition \
                  -fno-reorder-functions

NO_OPT = -O0

OPT = $(NO_OPT)

############################################################################################
# GCC Compiler verbose flags
############################################################################################

VERBOSE_GCC = -frecord-gcc-switches -fverbose-asm

############################################################################################
# C Compiler flags
############################################################################################

COPS  = $(OPT)                         \
        $(ARCH)                        \
        $(DEFS)                        \
        -ffreestanding                 \
        -MD                            \
        -Wa,-adhln=$(subst .o,.lst,$@) \
        -gdwarf-4 -ggdb                \
        -Wconversion                   \
        -Wsign-conversion              \
        -Wunused-parameter             \
        -Wuninitialized                \
        -Wmissing-declarations         \
        -Wshadow                       \
        -Wunreachable-code             \
        -Wmissing-include-dirs         \
        -x c                           \
        -std=c11                       \
        --specs=nosys.specs            \
        -Wall                          \
        -Wextra                        \
        -fomit-frame-pointer           \
        -gdwarf-2                      \
        -fno-exceptions                \
        -save-temps

############################################################################################
# C++ Compiler flags
############################################################################################

CPPOPS  = $(OPT)                          \
          $(ARCH)                         \
          $(DEFS)                         \
          -ffreestanding                  \
          -Wa,-adhln=$(subst .o,.lst,$@)  \
          -gdwarf-4 -ggdb                 \
          -Wconversion                    \
          -Wsign-conversion               \
          -Wunused-parameter              \
          -Wuninitialized                 \
          -Wmissing-declarations          \
          -Wshadow                        \
          -Wunreachable-code              \
          -Wmissing-include-dirs          \
          -Wall                           \
          -Wextra                         \
          -fomit-frame-pointer            \
          -gdwarf-2                       \
          -fno-exceptions                 \
          -x c++                          \
          --specs=nosys.specs             \
          -fno-rtti                       \
          -fno-use-cxa-atexit             \
          -fno-nonansi-builtins           \
          -fno-threadsafe-statics         \
          -fno-enforce-eh-specs           \
          -ftemplate-depth=128            \
          -Wzero-as-null-pointer-constant \
          -save-temps

############################################################################################
# Assembler flags
############################################################################################
ifeq ($(AS), $(TOOLCHAIN)-as)
  ASOPS =  $(ARCH)       \
           -alh          \
           -g
else
  ASOPS = $(OPT)                         \
          $(ARCH)                        \
          $(DEFS)                        \
          -MD                            \
          -Wa,-adhln=$(subst .o,.lst,$@) \
          -gdwarf-4 -ggdb                \
          -Wconversion                   \
          -Wsign-conversion              \
          -Wunused-parameter             \
          -Wuninitialized                \
          -Wmissing-declarations         \
          -Wshadow                       \
          -Wunreachable-code             \
          -Wmissing-include-dirs         \
          -x assembler                   \
          -std=c11                       \
          --specs=nosys.specs            \
          -Wall                          \
          -Wextra                        \
          -fomit-frame-pointer           \
          -gdwarf-2                      \
          -fno-exceptions                \
          -save-temps
endif

############################################################################################
# Linker flags
############################################################################################

ifeq ($(LD), $(TOOLCHAIN)-ld)
  LOPS = -nostartfiles          \
         -nostdlib              \
         $(ARCH)                \
         $(DEFS)                \
         -e Startup_Init        \
         --print-memory-usage   \
         --print-map            \
         -dT $(LD_SCRIPT)       \
         -Map=$(PRJ_FILE).map   \
         --no-warn-rwx-segments \
         -z,max-page-size=4096  
else
  LOPS = -nostartfiles              \
         -nostdlib                  \
         -fno-lto                   \
         $(ARCH)                    \
         $(DEFS)                    \
         -e _start                  \
         -Wl,--print-memory-usage   \
         -Wl,--print-map            \
         -Wl,-dT $(LD_SCRIPT)       \
         -Wl,-Map=$(PRJ_FILE).map   \
         -Wl,--no-warn-rwx-segments \
         -Wl,-z,max-page-size=4096  

endif

############################################################################################
# Source Files
############################################################################################

SRC_FILES := $(SRC_DIR)/Appli/main.c                  \
             $(SRC_DIR)/Mcal/ostm.c                   \
             $(SRC_DIR)/Mcal/pll.c                    \
             $(SRC_DIR)/Startup/boot.s                \
             $(SRC_DIR)/Startup/exceptvect.s          \
             $(SRC_DIR)/Startup/intvect.s             \
             $(SRC_DIR)/Startup/Startup.c             \
             $(SRC_DIR)/StdLib/printf/printf.c        \
             $(SRC_DIR)/StdLib/StdLib.c



############################################################################################
# Include Paths
############################################################################################
INC_FILES := $(SRC_DIR)               \
             $(SRC_DIR)/Appli         \
             $(SRC_DIR)/Mcal          \
             $(SRC_DIR)/Startup       \
             $(SRC_DIR)/StdLib/printf \
             $(SRC_DIR)/StdLib

############################################################################################
# Rules
############################################################################################
OBJ_FILES := $(subst $(SRC_DIR), $(OBJ_DIR), $(addsuffix .o, $(SRC_FILES)))

LIB = -lgcc

ifeq ($(MAKECMDGOALS), BUILD_STAGE_2)
-include $(subst .o,.d,$(OBJ_FILES))
endif

REBUILD_STAGE_1 : CLEAN PRE_BUILD $(CUSTOM_PRE_BUILD_TARGET)
REBUILD_STAGE_2 : link
REBUILD_STAGE_3 : GENERATE POST_BUILD $(OS_SIZE_INFO_TARGET)

BUILD_STAGE_1   : PRE_BUILD $(OS_TCB_GEN)
BUILD_STAGE_2   : link
BUILD_STAGE_3   : GENERATE POST_BUILD $(CUSTOM_POST_BUILD_TARGET)

############################################################################################
# Recipes
############################################################################################
.PHONY : link
link : $(ELF_FILE)
	@-echo "" > /dev/null

.PHONY : PRE_BUILD
PRE_BUILD:
	@-echo +++ Building Baremetal $(PRJ_NAME) image
	@git log -n 1 --decorate-refs=refs/heads/ --pretty=format:"+++ Git branch: %D (%h)" 2>/dev/null || true
	@git log -n 1 --clear-decorations 2> /dev/null > /dev/null || true
	@echo +++ info: "$(shell $(CC) -v 2>&1 | tail -n 1)"
	@echo +++ info: "$(shell make -v 2>&1 | head -n 1)"
	@echo +++ info: "$(shell $(PYTHON) --version 2>&1 | head -n 1)"
	@$(if $(shell test -d $(OBJ_DIR) && echo yes),,mkdir -p $(subst \,/,$(OBJ_DIR)))


.PHONY : POST_BUILD
POST_BUILD:
	@-echo +++ End


.PHONY : CLEAN
CLEAN :
	@-rm -rf $(subst \,/,$(OUTPUT_DIR))/* 2>/dev/null || true
	@-mkdir -p $(subst \,/,$(OUTPUT_DIR))


$(OBJ_DIR)/%.c.o : $(SRC_DIR)/%.c
	@-echo +++ compile: $(subst $(ROOT_DIR)/,,$<)
	@-mkdir -p $(@D)
	@-$(CC) $(COPS) $(addprefix -I, $(INC_FILES)) -c $< -o $@ 2>  $(subst .o,.err,$@)
	@-while ! mkdir $(LOCKDIR) 2>/dev/null; do sleep 0.1; done; $(PYTHON) $(ERR_MSG_FORMATER_SCRIPT) $(subst .o,.err,$@) -COLOR; rmdir $(LOCKDIR)

$(OBJ_DIR)/%.S.o : $(SRC_DIR)/%.S
	@-echo +++ compile: $(subst $(ROOT_DIR)/,,$<)
	@-mkdir -p $(@D)
	@-$(CC) $(OPT) $(ARCH) $(DEFS) $(addprefix -I, $(INC_FILES)) -c $< -o $@ 2> $(subst .o,.err,$@)
	@-while ! mkdir $(LOCKDIR) 2>/dev/null; do sleep 0.1; done; $(PYTHON) $(ERR_MSG_FORMATER_SCRIPT) $(subst .o,.err,$@) -COLOR; rmdir $(LOCKDIR)

ifeq ($(AS), $(TOOLCHAIN)-as)
$(OBJ_DIR)/%.s.o : $(SRC_DIR)/%.s
	@-echo +++ compile: $(subst $(ROOT_DIR)/,,$<)
	@-mkdir -p $(@D)
	@-$(AS) $(ASOPS) $< -o $@ 2> $(subst .o,.err,$@) > $(subst .o,.lst,$@)
	@-while ! mkdir $(LOCKDIR) 2>/dev/null; do sleep 0.1; done; $(PYTHON) $(ERR_MSG_FORMATER_SCRIPT) $(subst .o,.err,$@) -COLOR; rmdir $(LOCKDIR)
else
$(OBJ_DIR)/%.s.o : $(SRC_DIR)/%.s
	@-echo +++ compile: $(subst $(ROOT_DIR)/,,$<)
	@-mkdir -p $(@D)
	@-$(CC) $(ASOPS) $(addprefix -I, $(INC_FILES)) -c $< -o $@ 2> $(subst .o,.err,$@)
	@-while ! mkdir $(LOCKDIR) 2>/dev/null; do sleep 0.1; done; $(PYTHON) $(ERR_MSG_FORMATER_SCRIPT) $(subst .o,.err,$@) -COLOR; rmdir $(LOCKDIR)
endif

$(OBJ_DIR)/%.cpp.o : $(SRC_DIR)/%.cpp
	@-echo +++ compile: $(subst $(ROOT_DIR)/,,$<)
	@-mkdir -p $(@D)
	@$(CPP) $(CPPOPS) $(addprefix -I, $(INC_FILES)) -c $< -o $@ 2> $(subst .o,.err,$@)
	@-while ! mkdir $(LOCKDIR) 2>/dev/null; do sleep 0.1; done; $(PYTHON) $(ERR_MSG_FORMATER_SCRIPT) $(subst .o,.err,$@) -COLOR; rmdir $(LOCKDIR)

$(ELF_FILE) : $(OBJ_FILES) $(LD_SCRIPT)
	@-echo +++ link: $(subst \,/,$@)
ifeq ($(FORMAT_LINKER_ERR), )
	@$(LD) $(LOPS) $(OBJ_FILES) $(LIB) -o $(ELF_FILE) 2>&1
else
	@$(LD) $(LOPS) $(OBJ_FILES) $(LIB) -o $(ELF_FILE) > $(OBJ_DIR)/linker.err 2>&1 || true
	$(PYTHON) $(LINKER_ERR_MSG_FORMATER_SCRIPT) $(OBJ_DIR)/linker.err
endif

.PHONY : GENERATE
GENERATE:
	@$(if $(wildcard $(ELF_FILE)), ,$(error Error: Link not succeeded !))
	@-echo +++ generate: $(PRJ_FILE).readelf
	@$(READELF) -WhS $(ELF_FILE) > $(PRJ_FILE).readelf
	@-cat $(PRJ_FILE).map >> $(PRJ_FILE).readelf
	@-echo +++ generate: $(PRJ_FILE).sym
	@$(READELF) -Ws $(ELF_FILE) >> $(PRJ_FILE).readelf
	@-echo +++ generate: $(PRJ_FILE).dis
	@$(OBJDUMP) -d --wide $(ELF_FILE) >> $(PRJ_FILE).readelf
	@-echo +++ generate: $(PRJ_FILE).hex
	@$(OBJCOPY) $(ELF_FILE) -O ihex $(PRJ_FILE).hex
	@-echo +++ generate: $(PRJ_FILE).bin
	@$(OBJCOPY) $(ELF_FILE) -O binary $(PRJ_FILE).bin

# template
BUILD_DIR=build
SRC=$(wildcard *.asm)
OBJS=$(addprefix $(BUILD_DIR)/, $(SRC:.asm=.o))

CSRC=$(wildcard *.c)
COBJS=$(addprefix $(BUILD_DIR)/, $(CSRC:.c=.o))

MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MAKEFILE_DIR := $(dir $(MAKEFILE_PATH))

.PHONY: run clean all

# Keep the intermediate .o files
.SECONDARY: $(OBJS) $(COBJS)

# == ALL ==
all: $(BUILD_DIR)/c2asm

# == Make BUILD Dir ==
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# == Link ==
$(BUILD_DIR)/c2asm : $(OBJS) $(COBJS) | $(BUILD_DIR)
	gcc -o $@ $^ -no-pie
	ln -sf $(abspath $@) $(abspath $(BUILD_DIR)/program)

# == Assemble ==
$(BUILD_DIR)/%.o: %.asm | $(BUILD_DIR)
	nasm -f elf64 -g -F dwarf $^ -o $@ -l $@.lst --keep-all #-p "$(MAKEFILE_DIR)../constants.inc"

$(BUILD_DIR)/%.o: %.c | $(BUILD_DIR)
	gcc -c $^ -o $@ 

run: all
	$(BUILD_DIR)/program

clean:
	rm -rf $(BUILD_DIR)


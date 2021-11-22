# template
BUILD_DIR=build
SRC=$(wildcard *.asm)
OBJS=$(addprefix $(BUILD_DIR)/, $(SRC:.asm=.o))

MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MAKEFILE_DIR := $(dir $(MAKEFILE_PATH))

.PHONY: clean all

# Keep the intermediate .o files
.SECONDARY: $(OBJS)

# == ALL ==
all: $(patsubst %.o,%,$(OBJS)) 

# == Make BUILD Dir ==
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# == Link ==
$(BUILD_DIR)/% : $(BUILD_DIR)/%.o | $(BUILD_DIR)
	gcc -o $@ $^ -no-pie
	cp $@ $(BUILD_DIR)/program

# == Assemble ==
$(BUILD_DIR)/%.o : %.asm | $(BUILD_DIR)
	nasm -f elf64 -g -F dwarf $^ -o $@ -l $@.lst --keep-all -p "$(MAKEFILE_DIR)../constants.inc"

clean:
	rm -rf $(BUILD_DIR)


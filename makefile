ALL_EXE=hello hello-aak hello-aak2 printf-ex1

% : %.o
	gcc -o $@ $^ -no-pie

%.o : %.asm
	nasm -f elf64 -g -F dwarf $^ -l $@.lst

#$(HW): $(HW).o
#	gcc -o $(HW) $(HW).o -no-pie

#$(HW).o: $(HW).asm
#	nasm -f elf64 -g -F dwarf $(HW).asm -l $(HW).lst

all: $(ALL_EXE)

PHONY: clean
clean:
	rm -f *.o *.lst $(ALL_EXE)

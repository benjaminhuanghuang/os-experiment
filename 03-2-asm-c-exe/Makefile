all: demo.exe


c_part.elf.o: c_part.c
	gcc -m32  -o c_part.elf.o -c c_part.c

asm_part.elf.o: asm_part.asm
	nasm -f elf32 -o asm_part.elf.o asm_part.asm

demo.exe: c_part.elf.o asm_part.elf.o
	ld -m elf_i386 c_part.elf.o asm_part.elf.o -o demo.exe	


clean: 
	rm -f *.bin *.o *.elf *.exe



   
 
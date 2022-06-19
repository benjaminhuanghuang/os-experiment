all: Image

.PHONY=clean run

run: Image
	@qemu-system-i386 -hda disk.vhd

boot.bin: boot.asm
	nasm boot.asm -o boot.bin

loader.bin: loader.asm
	nasm loader.asm -o loader.bin

kernel.elf.o: kernel.asm
	nasm -f elf32 -o kernel.elf.o kernel.asm

kernel_c.elf.o: kernel_c.c
	gcc -m32 -c kernel_c.c -o kernel_c.elf.o 

kernel.elf.bin: kernel_c.elf.o kernel.elf.o
	ld -m elf_i386 -Ttext 0x1500 kernel.elf.o kernel_c.elf.o -o kernel.elf.bin
	
kernel.bin: kernel.elf.bin
	objcopy -O binary -j .text kernel.elf.bin kernel.bin  
 
Image: boot.bin loader.bin kernel.bin
	dd if=boot.bin of=disk.vhd bs=512 count=1
	dd if=loader.bin of=disk.vhd bs=512 count=1 seek=2
	dd if=kernel.bin of=disk.vhd bs=512 count=1 seek=9   
	@echo "Image created"	


clean: 
	rm -f *.bin *.o *.elf Image



   
 
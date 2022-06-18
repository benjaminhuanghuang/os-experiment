all: Image

.PHONY=clean run

run: Image
	@qemu-system-i386 -boot a -fda Image

boot.bin: boot.asm
	nasm boot.asm -o boot.bin

kernel_c.elf.o: kernel_c.c
	gcc -m32 -o kernel_c.elf.o -c kernel_c.c

kernel.elf.o: kernel.asm
	nasm -f elf32 -o kernel.elf.o kernel.asm
	
kernel.bin: kernel_c.elf.o kernel.elf.o
	ld -m elf_i386 -Ttext 0x900 kernel.elf.o kernel_c.elf.o -o kernel.bin
	objcopy -O binary -j .text kernel.bin 		

Image: boot.bin loader.bin kernel.bin
	dd if=boot.bin of=Image bs=512 count=1
	dd if=kernel.bin of=Image bs=512 count=1 seek=1
	@echo "Image created"	


clean: 
	rm -f *.bin *.o Image



   
 
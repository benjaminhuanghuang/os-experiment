all: Image

.PHONY=clean run

run: Image
	@qemu-system-i386 -boot a -fda Image

boot.bin: boot.asm
	nasm boot.asm -o boot.bin

loader.bin: loader.asm
	nasm loader.asm -o loader.bin

kernel_main.elf.o: kernel_main.c
	gcc -o kernel_main.elf.o -c kernel_main.c

kernel.elf.o: kernel.asm
	nasm -f elf32 -o kernel.elf.o kernel.asm
	
kernel.bin: kernel_main.elf.o kernel.elf.o
	ld -Ttext 0x900 kernel.elf.o kernel_main.elf.o
	objcoyp -O binary kernel.elf kernel.bin 		

Image: boot.bin kernel.bin
	dd if=boot.bin of=Image bs=512 count=1
	dd if=loader.bin of=Image bs=512 count=1 seek=1
	dd if=kernel.bin of=Image bs=512 count=1 seek=2
	@echo "Image created"	


clean: 
	rm -f *.bin Image



   
 
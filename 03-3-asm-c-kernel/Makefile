all: Image

.PHONY=clean run

run: Image
	@qemu-system-i386 -boot a -fda Image

boot.bin: boot.asm
	nasm boot.asm -o boot.bin

kernel.elf.o: kernel.asm
	nasm -f elf -o kernel.elf.o kernel.asm

kernel_c.elf.o: kernel_c.c
	gcc -c kernel_c.c -o kernel_c.elf.o 

kernel.elf.bin: kernel_c.elf.o kernel.elf.o
	ld -s -Ttext 0x900 kernel.elf.o kernel_c.elf.o -o kernel.elf.bin
	
kernel.bin: kernel.elf.bin
	objcopy -O binary kernel.elf.bin kernel.bin  
 
Image: boot.bin kernel.bin
	dd if=boot.bin of=Image bs=512 count=1
	dd if=kernel.bin of=Image bs=512 count=1 seek=1     
	@echo "Image created"	


clean: 
	rm -f *.bin *.o *.elf Image



   
 
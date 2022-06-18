all: Image

.PHONY=clean run

run: Image
	@qemu-system-i386 -boot a -fda Image

boot.bin: boot.asm
	nasm boot.asm -o boot.bin

kernel.elf.o: kernel.asm
	nasm -f elf32 -o kernel.elf.o kernel.asm

kernel.elf: kernel.elf.o
	ld -m elf_i386 -Ttext 0x900 kernel.elf.o -o kernel.elf

kernel.bin: kernel.elf
	objcopy -O binary -j .text kernel.elf kernel.bin  

Image: boot.bin kernel.bin
	dd if=boot.bin of=Image bs=512 count=1
	dd if=kernel.bin of=Image bs=512 count=1 seek=1
	@echo "Image created"	


clean: 
	rm -f *.bin *.o *.elf Image



   
 
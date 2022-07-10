all: Image

.PHONY=clean run

run: Image
	@qemu-system-i386 -boot a -fda myos.img

boot.bin: boot.asm
	nasm boot.asm -o boot.bin

kernel.elf.o: kernel.asm
	nasm -f elf32 -o kernel.elf.o kernel.asm

kernel_c.elf.o: kernel_c.c
	gcc -m32 -fno-pie -o kernel_c.elf.o -c kernel_c.c

kernel.bin: kernel_c.elf.o kernel.elf.o
	ld -m elf_i386 --oformat binary -T kernel.ld  $^ -o $@
 
Image: boot.bin kernel.bin
	dd if=/dev/zero of=myos.img bs=512 count=2880
	dd if=boot.bin of=myos.img bs=512 count=1 conv=notrunc
	dd if=kernel.bin of=myos.img seek=1 bs=512 count=1 conv=notrunc

	@echo "Image created"	


clean: 
	rm -f *.bin *.o *.elf Image



   
 
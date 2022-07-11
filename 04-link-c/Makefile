all: Image

.PHONY=clean run

run: Image
	@qemu-system-i386 -boot a -fda myos.img

boot.bin: boot.asm
	nasm boot.asm -o boot.bin

kernel.o: kernel.asm
	nasm kernel.asm -o kernel.bin

%.o: %.c
	gcc -fno-pie -m32 -c $< -o $@

kernel_c.bin: kernel_c.o
	ld -m elf_i386 --oformat binary -T bootpack.ld $^ -o $@

kernel.bin: kernel_c.bin asmhead.bin
	cat asmhead.bin > kernel.bin
	cat kernel_c.bin >> kernel.bin
 
Image: boot.bin kernel.bin
	dd if=/dev/zero of=myos.img bs=512 count=2880
	dd if=boot.bin of=myos.img bs=512 count=1 conv=notrunc
	dd if=kernel.bin of=myos.img seek=1 bs=512 count=1 conv=notrunc

	@echo "Image created"	


clean: 
	rm -f *.bin *.o *.elf *.img



   
 
# Kernel Objects, the order matters!
OBJS:=  kernel_c.o asmfunc.o

all: Image

.PHONY=clean run

run: Image
	@qemu-system-i386 -boot a -fda myos.img

boot.bin: boot.asm
	nasm boot.asm -o boot.bin

# asmhead.bin to bin
asmhead.bin: asmhead.asm
	nasm -f bin $< -o $@

# asm to elf-32 obj
%.o: %.asm 
	nasm -f elf32 $< -o $@
# c to elf-32 obj
%.o: %.c
	gcc -m32 -fno-pie -c $< -o $@

# link asm objs and c objs
kernel_c.bin: ${OBJS}
	ld -m elf_i386 --oformat binary -T kernel.ld $^ -o $@

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



   
 
# Kernel Objects, the order matters!
OBJS:= asmhead.o kernel_c.o asmfunc.o

all: Image

.PHONY=clean run

run: Image
	@qemu-system-i386 -boot a -fda myos.img

debug: Image
	qemu-system-i386 -fda myos.img -boot a -s -S

boot.bin: boot.asm
	nasm boot.asm -o boot.bin

# asm to elf-32 obj
%.o: %.asm 
	nasm -f elf32 $< -o $@
# c to elf-32 obj
%.o: %.c
	gcc -m32 -fno-pie -c $< -o $@

# link asm objs and c objs
kernel.bin: ${OBJS}
	ld -m elf_i386 --oformat binary -T kernel.ld $^ -o $@

 
Image: boot.bin kernel.bin
	dd if=/dev/zero of=myos.img bs=512 count=2880
	dd if=boot.bin of=myos.img bs=512 count=1 conv=notrunc
	dd if=kernel.bin of=myos.img seek=1 bs=512 count=1 conv=notrunc

	@echo "Image created"	


clean: 
	rm -f *.bin *.o *.elf *.img



   
 
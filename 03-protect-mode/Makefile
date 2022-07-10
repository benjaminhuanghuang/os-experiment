all: Image

.PHONY=clean run

run: Image
	@qemu-system-i386 -boot a -fda myos.img

boot.bin: boot.asm
	nasm boot.asm -o boot.bin

kernel.bin: kernel.asm pm.inc
	nasm $< -o $@ 

Image: boot.bin kernel.bin
	dd if=boot.bin of=myos.img bs=512 count=1
	dd if=kernel.bin of=myos.img bs=512 count=1 seek=1
	@echo "Image created"	


clean: 
	rm -f *.bin *.img



   
 
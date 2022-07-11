all: Image

.PHONY=clean run

run: Image
	@qemu-system-i386 -boot a -fda myos.img

debug: Image
	qemu-system-i386 -fda myos.img -boot a -s -S

boot.bin: boot.asm
	nasm boot.asm -o boot.bin

kernel.bin: kernel.asm
	nasm kernel.asm -o kernel.bin

Image: boot.bin kernel.bin
	dd if=boot.bin of=myos.img bs=512 count=1
	dd if=kernel.bin of=myos.img bs=512 count=1 seek=1
	@echo "Image created"	

clean: 
	rm -f *.bin *.img



   
 
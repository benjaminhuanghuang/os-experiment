all: boot.bin

.PHONY=clean run

run: boot.bin
	@qemu-system-i386 -boot a -fda boot.bin

boot.bin: boot.asm
	nasm boot.asm -o boot.bin


clean: 
	rm -f *.o boot



   
 
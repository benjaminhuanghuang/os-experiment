all: Image

.PHONY=clean run-qemu

run-qemu: Image
	@qemu-system-i386 -boot a -fda Image

boot.o: boot.asm
	as --32 bootsect.s  -o bootsect.o

boot: boot.o ld-bootsect.ld
	ld -T ld-bootsect.ld bootsect.o -o bootsect
	objcopy -O binary -j .text bootsect       

Image: boot
	dd if=boot of=Image bs=512 count=1
	@echo "Image created"

clean: 
	rm -f *.o boot



   
 
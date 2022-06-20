ld -m elf_i386 -Ttext 0x1500 dst.elf.o xcj.elf.o -o k.bin
dd if=k.bin of=disk.vhd bs=512 count=1 seek=9   
#
   
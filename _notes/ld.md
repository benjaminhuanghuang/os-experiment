

```
  # link a exe
  ld -m elf_i386 -s kernel_c.elf.p kernel.elf.o -o exe
  
  ld -m elf_i386 kernel_c.elf.o -s -Ttext 0x900 -e main -o kernel.elf.bin


  -m elf_i386 : 32-bit
  -e: entry point
```

check the kernel.elf.bin
```
  objdump -D kernel.elf.bin

  file kernel.elf.bin

  # show file length
  ll kernel.elf.bin    

  hexdump kernel.elf.bin   
```



## ld script
```
OUTPUT_FORMAT(elf32-i386)
OUTPUT_ARCH(i386)
ENTRY(_start)

SECTIONS {
  . = 0x100000;
   .text : { *(.text) } 
}
```

```
ld -T config.ld kernel.elf.o -o kernel.elf
```
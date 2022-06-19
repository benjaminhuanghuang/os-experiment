

```
  ld kernel_c.elf.o -s -Ttext 0x900 -e main -o kernel.elf.bin

  ld -m elf_i386 mult.o -o mult


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
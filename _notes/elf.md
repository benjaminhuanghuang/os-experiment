研究 ELF 是因为 linux 下 gcc只能生成 ELF 文件


check the kernel.elf.bin
```
  objdump -D kernel.elf.bin

  file kernel.elf.bin

  # show file length
  ll kernel.elf.bin    

  hexdump kernel.elf.bin   
```
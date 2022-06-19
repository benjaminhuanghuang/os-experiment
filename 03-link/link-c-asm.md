# Link .c and .asm together

1. 编译 .c 文件， 生成 32-bit elf 格式的obj文件
```
  gcc -m32 -o kernel_c.elf.o -c kernal_c.c
```
查看 kernel_c.elf.o
```
  file -h kernel_c.elf.o

  kernel_c.elf.o: ELF 32-bit LSB relocatable, Intel 80386, version 1 (SYSV), not stripped
```

```
  readelf -a kernel_c.elf.o
```

2. asm Part

nasm 缺省会生成 bin文件
```
  nasm kernel-bin.asm -o kernel.bin 
```

如果想 link asm代码和c代码, nasm 要生成 elf 格式的obj文件
```
  nasm -f elf32 kernel.asm -o kernel.elf.o
```

代码也要做相应改动
```
```

3. 链接 asm 和 c 生成的 obj 文件
```
  ld -Ttext 0x900 kernel.elf.o kernel_c.elf.o -o kernel.elf

  0x900 为入口地址
```

查看链接结果 kernel.elf
```
  objdump -D kernel.elf
```

4. 提取 .text 段内容

```
  objcoyp -O binary -j .text kernel.elf kernel.bin 
```

查看结果 
```
  hexdump kernel.bin
```


5. create Image

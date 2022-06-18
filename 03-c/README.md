


1. 编译 .c 文件， 生成 .elf 格式的obj文件
```
  gcc -o kernel_main.elf.o -c kernal_main
```
查看 elf
```
  readelf -a kernel_main.elf.o
```

2. 编译 .asm 文件
对于.asm 文件，也要生成 elf 格式的obj文件
```
  nasm -f elf32 -o kernel.elf.o kernel.asm
```

3. 链接 asm 和 c 生成的 obj 文件
```
  ld -j text 0x1500 kernel.elf.o kernel_mail.elf.o

  0x1500 为入口地址
```

查看链接结果, 
```
  objdum kernel.out
```

4. 提取 .text 段内容

```
  objcoyp -O binary kernel.out kernel.bin 
```

查看结果 
```
  hexdump kernel.bin
```


5. create Image

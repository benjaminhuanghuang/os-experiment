# asm -> ELF -> BIN


1. Create ELF fromat obj
nasm 缺省会生成 bin文件
```
  nasm kernel-bin.asm -o kernel.bin 
```

nasm 生成 elf 格式的obj文件
```
  nasm -f elf32 kernel.asm -o kernel.elf.o
```

check kernel.elf.o
```
  readelf -a kernel.elf.o
```
可以看到kernel.elf.o 是 REL(Relocatable file)

2. Link
为obj文件添加定位信息
```
  ld -Ttext 0x900 kernel.elf.o -o kernel.elf.bin

  0x900 为入口地址
```

查看链接结果 kernel.elf
```
  objdump -D kernel.elf.bin
```

3. 提取 .text 段内容

```
  objcoyp -O binary -j .text kernel.elf.bin kernel.bin 
```

查看结果 
```
  hexdump kernel.bin
```


4. create Image

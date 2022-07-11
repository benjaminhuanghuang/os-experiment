# Link Asm and C code - Method 3: link 生成 bin 文件

因为引入C语言, kernel.bin 的大小会超过 512 bytes, 需要修改 Makefile 中生成myos.img 和 boot.asm 中加载kernel 的相应部分

最终的kernel.bin 由3部分代码组成
1. asmheader.asm 是整个内核的入口, 负责初始化GDT, 然后跳转到 32位的代码空间
2. 若干个 asm 代码文件, 包含硬件操作, 比如IO操作
3. 若干个 c 代码文件, 

把 kernel 的c语言部分(多个.c文件) 编译成 32-bit elf 格式的.obj 文件, 

把所有的 asm 代码(包括 asmheader.asm) 全都编译成 32-bit elf 格式的.obj 文件, 此时的 asmheader.asm 不用 org 指令指定代码的加载地址, 这个工作交给 ld 来做

链接 asm 生成的 obj文件 和 c 生成的 obj 文件, 通过链接器参数 或 链接脚本 指定 代码的起始地址, 同时指定输出格式为 binary, 直接生成kernel.bin

## 问题
这个方法的缺点是


## Link .c and .asm together

1. 编译 .c 文件， 生成 32-bit elf 格式的obj文件
```
  gcc -m32 -fno-pie -o kernel_c.elf.o -c kernal_c.c
```
gcc在ubuntu 17.04上默认会生成-fpic代码，默认情况下会链接-fPIE

PIE能使程序像共享库一样在主存任何位置装载，这需要将程序编译成位置无关，并链接为ELF共享对象。
引入PIE的原因是让程序能装载在随机的地址，通常情况下，内核都在固定的地址运行，如果能改用位置无关，那攻击者就很难借助系统中的可执行码实施攻击了。

查看 kernel_c.elf.o
```
  file -h kernel_c.elf.o

  kernel_c.elf.o: ELF 32-bit LSB relocatable, Intel 80386, version 1 (SYSV), not stripped
```

```
  readelf -a kernel_c.elf.o
```

2. 编译 .asm 文件
对于.asm 文件，也要生成 elf 格式的obj文件
```
  nasm -f elf32 -o kernel.elf.o kernel.asm
```

3. 链接 asm 和 c 生成的 obj 文件 

用 ld 生成 binary
```
ld -m elf_i386 --oformat binary -T kernel.ld  $^ -o $@
```

查看结果 
```
  hexdump kernel.bin
```


5. create Image
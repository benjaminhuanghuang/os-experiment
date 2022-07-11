# Link Asm and C code - Method 4: 文件拼接

因为引入C语言, kernel.bin 的大小会超过512bytes, 需要修改Makefile 中生成myos.img 和 boot.asm 中加载kernel 的相应部分

最终的kernel.bin 由3部分代码组成
1. asmheader.asm 是整个内核的入口, 负责初始化GDT, 然后跳转到 32位的代码空间
2. 若干个 asm 代码文件, 包含硬件操作, 比如IO操作
3. 若干个 c 代码文件, 


把 c 代码 和 asm 代码 都编译成 32-bit elf 格式的.obj 文件, 

链接多个 obj 文件, 指定代码加载地址为 0x0, 同时指定输出格式为 binary, 直接生成kernel_c.bin

asmheader.asm 中指定代码加载地址0x90000 编译成 binary 格式的kernel_asm.bin 文件

把两部分直接拼接成最终的 kernel.bin


## 问题: 
在asmheader.asm要给32bit 代码段 设置 GDT, 而 c 代码是拼接时才和asmheader.asm拼接在一起的, 如何知道代码段的大小? 
目前只好把 代码段界限写成 0xFFFF

1. 把 .c 代码编译 32-bit elf 格式的obj文件
```
%.o: %.c
  gcc -m32 -fno-pie -c $< -o $@
```

2. 把 .asm 代码 编译成 32-bit elf 格式的obj文件
```
%.o: %.asm 
  nasm -f elf32 $< -o $@
```

3. 链接 obj 文件, 生成 binary 文件
```
kernel_c.bin: ${OBJS}
	ld -m elf_i386 --oformat binary -T bootpack.ld $^ -o $@
```

4. 把 asmhead.asm 编译成 bin 格式
asmhead.asm  中会指定代码加载的地址
```
asmhead.bin: asmhead.asm
	nasm -f bin asmhead.asm -o asmhead.bin
```

5. 拼接 kernel.bin
```
kernel.bin: kernel_c.bin asmhead.bin
	cat asmhead.bin > kernel.bin
	cat kernel_c.bin >> kernel.bin
```

6. create Image
```
img: ipl.bin kernel.bin
	dd if=/dev/zero of=myos.img bs=512 count=2880
	dd if=ipl.bin of=myos.img bs=512 count=1 conv=notrunc
	dd if=kernel.bin of=myos.img seek=33 bs=512 conv=notrunc
```



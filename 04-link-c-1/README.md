# Link Asm and C code - Method 1: copy-past

参考 https://www.bilibili.com/video/BV1hJ411n7rs?p=8&vd_source=b7025abbc1efd8b7631e43fa506ade3a

最终的kernel.bin 由3部分代码组成
1. asmheader.asm 是整个内核的入口, 负责初始化GDT, 然后跳转到 32位的代码空间
2. 若干个 asm 代码文件, 包含硬件操作, 比如IO操作
3. 若干个 c 代码文件, 


## 问题
这个方法的缺点是只能用于文件很少的情况


1. 编译 .c 文件, 生成 32-bit elf 格式的 .obj文件
```
  gcc -m32 -fno-pie -o kernel_c.elf.o -c kernal_c.c
```

2. 把 .c 文件生成的 .obj 反汇编成 汇编代码
```
```

3. 把 .c 文件生成的 汇编代码 include 或 copy-paste 到 asmhead.asm 中
copy-paste 的时候手动移除 extern 等函数声明, 因为最终所有的代码都包含在一个文件中, 不再需要这些声明


4. 把最终生成的, 包含所有kernel代码的 asmheader.asm 编译成 bin 格式

在 asmheader.asm 中用 org 指令指定 代码开始执行的地址

```
  nasm asmhead.asm -o kernel.bin
```


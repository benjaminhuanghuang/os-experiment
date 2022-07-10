## Use LAB 模式读取disk
LBA 模式 不能用于 floppy disk , 改用 virtual disk 
```
run: Image
	@qemu-system-i386 -hda disk.vhd
```

LBA 模式 section 的索引从 1 开始，因此要修改dd的参数
```
  dd if=loader.bin of=disk.vhd bs=512 count=1 seek=2
  dd if=kernel.bin of=disk.vhd bs=512 count=1 seek=9 
```



1. use virtual box -> file -> Virtual Media Manager create .vhd



2. dd write .vhd



3. qemu load .vhd
```
  @qemu-system-i386 -hda disk.vhd
```
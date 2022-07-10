

1. use virtual box -> file -> Virtual Media Manager create .vhd



2. dd write .vhd



3. qemu load .vhd
```
  @qemu-system-i386 -hda disk.vhd
```
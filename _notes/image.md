## Create virtual disk
```
diskpart

diskpart> ceate vdisk file=dis.vhd maximum=10 type=fixed
```

## copy boot.bin to virtual disk
```
  dd if=boot.bin of=disk.vhd bs=512 count=1
```
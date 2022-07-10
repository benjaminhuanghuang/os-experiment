## Create floppy disk
```
  dd if=/dev/zero of=myos.img bs=512 count=2880
	
```


## Create virtual disk
```
diskpart

diskpart> ceate vdisk file=dis.vhd maximum=10 type=fixed
```

## copy boot.bin to virtual disk
```
  dd if=boot.bin of=disk.vhd bs=512 count=1
```


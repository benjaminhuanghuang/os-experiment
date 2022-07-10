## Create a boot section

User asm file create a 512 bytes bin file, end with 0x55AA,

BIOS will load it to 0x7C00 and run it



## check file
```
  hexdump boot.bin
  
```
打开 VGA 模式
```
  mov al, 0x13h   ; 320*200*8 调色板 模式, 显存地址 0xa0000
  mov ah, 0
  int 0x10
```




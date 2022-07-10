; 
; 实模式下内存地址0xb8000到0xbffff是显示适配器BIOS所在区域
; 
mov ax,0xb800
mov es,ax
mov byte [es:0x00], 'O'
mov byte [es:0x01],0x07
mov byte [es: 0x02], 'K'
mov byte [es: 0x03], 0X41

jmp $

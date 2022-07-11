	mov ax,0xb800
	mov es,ax
	mov byte [es: 0x00], 'K'
  mov byte [es: 0x01], 0x24
  mov byte [es: 0x02], 'E'
  mov byte [es: 0x03], 0X41
  jmp $

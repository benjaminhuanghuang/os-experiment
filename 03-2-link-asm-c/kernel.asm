extern display        ; from C fun
[BITS 16]
[section .text]
global _start
global myprint

mov ax,0xb800
mov es,ax
mov byte [es:0x00], '@'
mov byte [es:0x01],0x07
mov byte [es: 0x02], '#'
mov byte [es: 0x03], 0X41

_start:
  call display ; asm call c function

myprint:
	mov ax,0xb800
	mov es,ax
	mov byte [es:0x00], 'A'
	mov byte [es:0x01],0x07
	ret

extern DISPLAY; from C fun

[BITS 16]
[section .text]
global _start
global _myprint

mov ax,0xb800
	mov es,ax
	mov byte [es:0x00], 'K'
	mov byte [es:0x01],0x07
	ret


_start:
	call DISPLAY ; asm call c function

_myprint:
	mov ax,0xb800
	mov es,ax
	mov byte [es:0x00], 'Z'
	mov byte [es:0x01],0x07
	ret

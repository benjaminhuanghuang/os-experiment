extern DISPLAY        	; c function
[bits 16]

[section .text]
global _start
global myprint


_start:
  call DISPLAY;  asm call c function 


myprint:
  MOV AX, 0XB800        	;显存位置
  MOV ES, AX

  MOV BYTE[ES: 0X00], 'O'
  MOV BYTE[ES: 0X01], 0x24
  MOV BYTE[ES: 0X02], 'S'
  MOV BYTE[ES: 0X03], 0X41
  ret
  
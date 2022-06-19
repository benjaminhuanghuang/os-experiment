extern DISPLAY; from C fun
[BITS 16]
[section .text]
global _start
global myprint

_start:
	call DISPLAY ; asm call c function

myprint:
  MOV AX, 0XB800        	;显存位置
  MOV ES, AX

  mov byte [ES: 0X00], 'K'
  mov byte [ES: 0X01], 0x07
  ;mov byte [ES: 0X02], 'L'
  ;mov byte [ES: 0X03], 0X41
  ret 
  
extern DISPLAY        	   ; c function
[bits 16]

[section .text]
global _start
global myprint


_start:
  call DISPLAY            ;  asm call c function 


myprint:
  MOV AX, 0XB800        	;显存位置
  MOV ES, AX

  mov byte [ES: 0X00], 'O'
  mov byte [ES: 0X01], 0x07
  mov byte [ES: 0X02], 'S'
  mov byte [ES: 0X03], 0X41
  ret 
  
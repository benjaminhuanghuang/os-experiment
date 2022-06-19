[BITS 16]
[SECTION .text]
GLOBAL _start

_start:
  MOV AX, 0XB800        	;显存位置
  MOV ES, AX

  MOV BYTE[ES: 0X00], 'P'
  MOV BYTE[ES: 0X01], 0x24
  MOV BYTE[ES: 0X02], 'K'
  MOV BYTE[ES: 0X03], 0X41
  JMP $
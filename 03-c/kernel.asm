SECTION LOADER VSTART=0x900

EXTERN DisplayC    ; import c function
[BIT 16]
[SECTION .TEXT]

GLOABAL _start
GLOABAL PrintASM

_start:
  CALL DisplayC


PrintASM:
  MOV AX, 0XB800        	;显存位置
  MOV ES, AX

  MOV BYTE[ES: 0X00], 'O'
  MOV BYTE[ES: 0X01], 0x24
  MOV BYTE[ES: 0X02], 'K'
  MOV BYTE[ES: 0X03], 0X41
  RET
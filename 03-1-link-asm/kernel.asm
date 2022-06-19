[BITS 16]
[SECTION .text]
GLOBAL _start

_start:
  MOV AX, 0XB800        	;显存位置
  MOV ES, AX

  mov byte [es: 0x00], 'K'
  mov byte [es: 0x01], 0x24
  mov byte [es: 0x02], 'E'
  mov byte [es: 0x03], 0X41
  mov byte [es: 0x04], 'R'
  mov byte [es: 0x05], 0XA4
  mov byte [es: 0x06], 'N'
  mov byte [es: 0x07], 0XA4
  mov byte [es: 0x08], 'E'
  mov byte [es: 0x09], 0XA4
  mov byte [es: 0xA], 'L'
  mov byte [es: 0xB], 0XA4
  JMP $
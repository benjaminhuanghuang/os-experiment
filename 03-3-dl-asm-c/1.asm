[section .data]
strHello db "OS Kernal", 0xA
STRLEN equ S - strHello


[section .text]
global _start

_start:
  mov edx, STRLEN
  mov ecx, strHello
  mov ebx, 1
  mov eax, 4        ; sys_write
  int 0x80

  mov ebx, 0
  mov eax, 1        ; sys_exit
  int 0x80

  


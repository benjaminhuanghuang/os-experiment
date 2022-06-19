EXTERN DISPLAY        	;FROM C
extern chooseNum  ; from C func

[section .data]
num1 dd 10
num2 dd 44


[section .text]
global _start
global myprint


_start:
  push num2
  push num1
  call chooseNum
  add esp, 4
  mov ebx, 0
  mov eax, 1
  int 0x80          ; sys_exit

myprint:
  mov edx, [esp + 8]
  mov ecx, [esp + 4]
  mov ebx, 1
  mov eax, 4
  int 0x80          ; sys_write
  ret
  
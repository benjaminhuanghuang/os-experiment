org 0x7c00  ;程序加载到0x7c00

;初始化寄存器
mov  ax, 0
mov  ss, ax
mov  ds, ax
mov  es, ax
mov  si, ax

; 使用 BIOS INT 0x13 读取1个扇区 到 ES:BX
load_kernel:
  mov DX, 0       ; DH:head, DL:driver
  mov CX, 2       ; CH: 磁道号的低8位数, CL:低5位放入所读起始扇区号，位7-6表示磁道号的高2位 注意Section Number从1开始
  mov AX, 0       ; read kernel to ES:BX (ES=0x, BX=0x9000)
  mov ES, AX
  mov BX, 0x9000
  mov AH, 0x02    ; read
  mov AL, 1       ; read 1 sections from the disk
  int 0x13

  jnc kernel_load_ok  ; check CF
  jmp load_kernel

kernel_load_ok:
  jmp 0x9000    ; execute the kernel


TIMES 510 - ($ - $$) DB 0
DB 0X55, 0XAA
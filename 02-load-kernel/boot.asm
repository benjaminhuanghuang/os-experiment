SECTION MBR VSTART=0X7C00    ;程序加载到0x7c00

;初始化寄存器
MOV AX, CS
MOV DS, AX
MOV ES, AX
MOV SS, AX
MOV FS, AX
MOV SP, 0X7C00
MOV AX, 0XB800            ;显存位置
MOV GS, AX

;-- BIOS 0x10
MOV AX, 0X0600            ;AH 功能 AL是内容，这里都是0
MOV BX, 0X0700            ;BH 上卷行的属性
MOV CX, 0                 ;(CL,CH)->(X0,Y0)左上角
MOV DX, 184FH             ;(DL,DH)->(X1,Y1) 右下角 (80,25)
INT 10H                   ;调用BIOS 0x10中断
;输出
MOV BYTE [GS: 0X00], '*'
MOV BYTE [GS: 0X01], 0XA4

MOV BYTE [GS: 0X02], '*'
MOV BYTE [GS: 0X03], 0XA4

MOV BYTE [GS: 0X04], 'M'
MOV BYTE [GS: 0X05], 0XA4

MOV BYTE [GS: 0X06], 'B'
MOV BYTE [GS: 0X07], 0XA4

MOV BYTE [GS: 0X08], 'R'
MOV BYTE [GS: 0X09], 0XA4

load_kernel:
  mov DX, 0       ; DH:head, DL:driver
  mov CX, 2       ; read section 2
  mov AX, 0       ; read kernel to ES:BX (0x900)
  mov ES, AX
  mov BX, 0x900
  mov AH, 0x02    ; read
  mov AL, 1       ; read 1 sections from the disk
  int 0x13

  jnc kernel_load_ok  ; check CF
  jmp load_kernel

kernel_load_ok:
  jmp 0x900    ; execute the kernel


TIMES 510 - ($ - $$) DB 0
DB 0X55, 0XAA
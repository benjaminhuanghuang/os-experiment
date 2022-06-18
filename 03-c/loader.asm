LOADER_BASE_ADDR EQU 0X900          	;加载第2个段的地址
KERNEL_BASE_ADDR EQU 0X1500

SECTION LOADER VSTART=LOADER_BASE_ADDR

  MOV AX, 0XB800        	;显存位置
  MOV ES, AX

  MOV BYTE[ES: 0X00], 'O'
  MOV BYTE[ES: 0X01], 0X07
  MOV BYTE[ES: 0X02], 'K'
  MOV BYTE[ES: 0X03], 0X06

load_kernel:
  mov DX, 0       ; DH:head, DL:driver
  mov CX, 2       ; read section 2
  mov AX, 0       ; read kernel to ES:BX (0x1500)
  mov ES, AX
  mov BX, 0x1500
  mov AH, 0x02    ; read
  mov AL, 1       ; read 1 sections from the disk
  int 0x13

  jnc kernel_load_ok  ; check CF
  jmp load_kernel

kernel_load_ok:
  jmp 0x1500   ; execute the kernel

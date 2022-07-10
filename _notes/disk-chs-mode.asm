
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
  jmp load_kernel     ; keep loading

kernel_load_ok:
  jmp 0x900    ; execute the kernel

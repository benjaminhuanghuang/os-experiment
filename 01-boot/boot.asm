org 0x7c00

  ; init registers
  mov ax, cs
  mov ds, ax
  mov es, ax

  call show
  jmp $  ; infinite loop, jmp to current address


show:
  mov ax, message
  mov bp, ax      ; ES:BP = string address
  mov cx, 7       ; CX= string length
  mov ax, 0x1301  ; AH= function number AL= write move 
  mov bx, 0xc     ; BH= page number, BL= color
  mov dl, 0       ; DL= column
  int 0x10   
  ret


message: 
  DB "Boot..."

times 510-($-$$) DB 0
DW 0xaa55

 
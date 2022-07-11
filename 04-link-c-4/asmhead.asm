%include "pm.inc"


jmp START

[section .gdt]
; GDT definition
;                           段基址     段界限               属性
GDT_ENTRY    :  Descriptor    0,       0,                  0
CODE32_DESC  :  Descriptor    0,       Code32SegLen  - 1,  DA_C + DA_32
; 显存地址 0xa0000
VRAM_DESC    :  Descriptor    0xa0000,  0xFFFF,            DA_DRW
; Stack for C language
STACK_DESC   :  Descriptor    0,       TopOfStack,         DA_DRWA + DA_32

; GDT end

GdtLen    equ   $ - GDT_ENTRY
GdtPtr:
  dw   GdtLen - 1
  dd   0  

; offset of the selectors
SelectorCode32  equ   CODE32_DESC -  GDT_ENTRY
SelectorVRAM    equ   VRAM_DESC  -  GDT_ENTRY
SelectorStack   equ   STACK_DESC  -  GDT_ENTRY

[section .s16]
[BITS  16]
START:
  mov   ax, cs
  mov   ds, ax
  mov   es, ax
  mov   ss, ax

; 打开 VGA 模式
  mov al, 0x13   ; 320*200*8 调色板 模式, 显存地址 0xa0000
  mov ah, 0
  int 0x10

; initialize GDT for 32 bits code segment
  mov eax, 0
  mov ax, cs
  shl eax, 4
  add eax, CODE32_SEGMENT
  mov word [CODE32_DESC + 2], ax
  shr eax, 16
  mov byte [CODE32_DESC + 4], al
  mov byte [CODE32_DESC + 7], ah


; initialize Stack for C language
  mov eax, 0
  mov ax, cs
  shl eax, 4
  add eax, LABEL_STACK
  mov word [STACK_DESC + 2], ax
  shr eax, 16
  mov byte [STACK_DESC + 4], al
  mov byte [STACK_DESC + 7], ah



; initialize GDT pointer struct
  mov eax, 0
  mov ax, ds
  shl eax, 4
  add eax, GDT_ENTRY
  mov dword [GdtPtr + 2], eax     ; 把GDT的地址放到GdtPtr + 2的位置

; 1. Load GDT
  lgdt  [GdtPtr]         ; set register

; 2. close interrupt 
  cli                    ; 关中断

; 3. open A20, 92 号端口 (8位)的最高位值1
  in    al,  92h
  or    al,  00000010b
  out   92h, al

; 4. Set CR0 register
  mov   eax, cr0
  or    eax , 1         ; set PE
  mov   cr0, eax

; 5. Jump to 32bit code space
  jmp   dword  SelectorCode32: 0      ; SelectorCode32 is the offset of code 32 selector


[SECTION .gs ]
ALIGN 32
[BITS 32]
LABEL_STACK:
  times 512 db 0
  TopOfStack equ $ - LABEL_STACK


[SECTION .s32]
[BITS  32]
CODE32_SEGMENT:
  mov   esp, TopOfStack

  mov  ax, SelectorVRAM
  mov  ds, ax


Code32SegLen   equ  0xffff






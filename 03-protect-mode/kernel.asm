%include "pm.inc"

org   0x9000

jmp   LABEL_BEGIN

[SECTION .gdt]
 ;                                  段基址          段界限                属性
LABEL_GDT:          Descriptor        0,            0,                   0  
LABEL_DESC_CODE32:  Descriptor        0,      SegCode32Len - 1,       DA_C + DA_32
LABEL_DESC_VIDEO:   Descriptor     0B8000h,         0ffffh,            DA_DRW

; length of GDT = current address - LABEL_GDT
GdtLen     equ    $ - LABEL_GDT
; 
GdtPtr     dw     GdtLen - 1  ; 2 bytes, the limit of GDT
           dd     0           ; 4 bytes, the start of GDT       

; address of the second selector
SelectorCode32    equ   LABEL_DESC_CODE32 -  LABEL_GDT
; address of the third selector
SelectorVideo     equ   LABEL_DESC_VIDEO  -  LABEL_GDT

[SECTION  .s16]
[BITS  16]
LABEL_BEGIN:
     mov   ax, cs
     mov   ds, ax
     mov   es, ax
     mov   ss, ax
     mov   sp, 0100h

     xor   eax, eax
     mov   ax,  cs
     shl   eax, 4
     add   eax, LABEL_SEG_CODE32
     mov   word [LABEL_DESC_CODE32 + 2], ax
     shr   eax, 16
     mov   byte [LABEL_DESC_CODE32 + 4], al
     mov   byte [LABEL_DESC_CODE32 + 7], ah

     xor   eax, eax
     mov   ax, ds
     shl   eax, 4
     add   eax,  LABEL_GDT
     mov   dword  [GdtPtr + 2], eax

     lgdt  [GdtPtr]

     cli   ;关中断

     ; 92 号端口 (8位)的最高位值1
     in    al,  92h
     or    al,  00000010b
     out   92h, al
     ; 
     mov   eax, cr0
     or    eax , 1
     mov   cr0, eax

     jmp   dword  SelectorCode32: 0

     [SECTION .s32]
     [BITS  32]
LABEL_SEG_CODE32:
    mov   ax, SelectorVideo
    mov   gs, ax
    mov   si, msg
    mov   ebx, 10
    mov   ecx, 2
showChar:
    mov   edi, (80*11)
    add   edi, ebx
    mov   eax, edi
    mul   ecx
    mov   edi, eax
    mov   ah, 0ch
    mov   al, [si]
    cmp   al, 0
    je    end
    add   ebx,1
    add   si, 1
    mov   [gs:edi], ax
    jmp    showChar
end: 
    jmp   $
msg:
    DB     "Protect Mode", 0

SegCode32Len   equ  $ - LABEL_SEG_CODE32


%include "pm.inc"

org 0x9000

jmp START

[section .gdt]
; GDT definition
;                           段基址     段界限               属性
GDT_ENTRY    :  Descriptor    0,       0,                  0
CODE32_DESC  :  Descriptor    0,       Code32SegLen  - 1,  DA_C + DA_32
; 实模式下, 文本模式的显存的地址范围映射为 [0xB8000，0xBFFFF],一屏幕可以显示25行，每行80个字符
VIDEO_DESC   :  Descriptor    0xB8000, 0x7FFF,             DA_DRW
; GDT end

GdtLen    equ   $ - GDT_ENTRY
GdtPtr:
  dw   GdtLen - 1
  dd   0

; offset of the code32 selector
SelectorCode32    equ   CODE32_DESC -  GDT_ENTRY
; offset of the vido selector
SelectorVideo     equ   VIDEO_DESC  -  GDT_ENTRY


[section .s16]
[BITS  16]
START:
  mov   ax, cs
  mov   ds, ax
  mov   es, ax
  mov   ss, ax
  mov sp, 0x900

; initialize GDT for 32 bits code segment
  mov eax, 0
  mov ax, cs
  shl eax, 4
  add eax, CODE32_SEGMENT
  mov word [CODE32_DESC + 2], ax
  shr eax, 16
  mov byte [CODE32_DESC + 4], al
  mov byte [CODE32_DESC + 7], ah

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
  and		eax, 0x7fffffff	; 使用bit31（禁用分页）
  or    eax , 1         ; set PE
  mov   cr0, eax

; 5. Jump to 32bit code space
  jmp   dword  SelectorCode32: 0      ; SelectorCode32 is the offset of code 32 selector

[SECTION .s32]
[BITS  32]
CODE32_SEGMENT:
  mov   ax, SelectorVideo
  mov   gs, ax   ; 此时段寄存器gs的内容是 段描述符在 GDT 的偏移

  mov   si, msg  
  mov   ebx, 10  
  mov   ecx, 2

showChar:
  mov   edi, (80*11)  ;  屏幕第11行
  add   edi, ebx
  mov   eax, edi
  mul   ecx
  mov   edi, eax
  mov   ah, 0x0c       ; 字符属性 0000 黑底, 1100: 红字 
  mov   al, [si]
  cmp   al, 0          ; 检查字符串结尾  \0
  je    end
  add   ebx,1
  add   si, 1
  ;mov   [gs:edi], ax
  mov byte [gs:160], 'P' 
  jmp   showChar

end: 
    jmp   $
msg:
    DB     "Protect Mode", 0

Code32SegLen   equ  $ - CODE32_SEGMENT


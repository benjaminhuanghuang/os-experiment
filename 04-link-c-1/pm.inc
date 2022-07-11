; 宏 Descriptor 接受 3个参数: 段基址, 段界限, 段属性
; usage: Descriptor Base, Limit, Attr
;        Base:  dd
;        Limit: dd (low 20 bits available)
;        Attr:  dw (lower 4 bits of higher byte are always 0)
%macro Descriptor 3
    dw    %2  &  0FFFFh       ; 段界限 15-0 位
    dw    %1  &  0FFFFh       ; 段基址 15-0 位 
    db   (%1>>16) & 0FFh      ; 段基址 23-16 位 
    dw   ((%2 >> 8) & 0F00h) | (%3 & 0F0FFh)  ; 段属性+段界限19-16位+段属性 
    db   (%1 >> 24) & 0FFh    ; 段基址 31-24 位         
%endmacro                     ; 共 8 bytes


; Segment Attribute
DA_32		EQU	4000h	; 32 位段
DA_C		EQU	98h	; 存在的只执行代码段属性值
DA_DRW	EQU	92h	; 存在的可读写数据段属性值
DA_DRWA  equ    0x93
DA_C     equ    0x98
DA_CR    equ    0x9A
DA_CCO   equ    0x9C
DA_CCOR  equ    0x9E

; Selector Attribute
SA_RPL0    equ    0
SA_RPL1    equ    1
SA_RPL2    equ    2
SA_RPL3    equ    3

SA_TIG    equ    0
SA_TIL    equ    4

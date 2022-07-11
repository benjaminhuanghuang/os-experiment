ENTRY( START )

SECTIONS
{
  .text 0x9000: { 
    *(.text) 
  }
  .data : { *(.data) }
}
section .multiboot_header
header_start:
; Magic Number 
dd 0xe85250d6 ; Multiboot2
; Artitecture
dd 0 ;Protected mode i386
;Header Length
dd header_end - header_start 
; CheckSum
dd 0x100000000 - (0xe85250d6 + 0 + (header_end - header_start)) 

;end Tag
dw 0
dw 0
dd 8
header_end:

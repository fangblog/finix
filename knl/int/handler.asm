[bits 32]
%define ERR nop
%define NERR push 0
extern puts
section .data
intp db "interrupt occur",0xa,0xd,0
global iet
iet:
%macro VECTOR 2
section .text
intr%1:
	%2
	push intp
	call puts
	push %1
	add esp,4
	mov al,0x20
	out 0xa0,al
	out 0x20,al
	add esp,8
	iret
section .data
	dd intr%1
%endmacro
VECTOR 0x00,NERR
VECTOR 0x01,NERR
VECTOR 0x02,NERR
VECTOR 0x03,NERR
VECTOR 0x04,NERR
VECTOR 0x05,NERR
VECTOR 0x06,NERR
VECTOR 0x07,NERR
VECTOR 0x08,NERR
VECTOR 0x09,NERR
VECTOR 0x0a,NERR
VECTOR 0x0b,NERR
VECTOR 0x0c,NERR
VECTOR 0x0d,NERR
VECTOR 0x0e,NERR
VECTOR 0x0f,NERR
VECTOR 0x10,NERR
VECTOR 0x11,NERR
VECTOR 0x12,NERR
VECTOR 0x13,NERR
VECTOR 0x14,NERR
VECTOR 0x15,NERR
VECTOR 0x16,NERR
VECTOR 0x17,NERR
VECTOR 0x18,NERR
VECTOR 0x19,NERR
VECTOR 0x1a,NERR
VECTOR 0x1b,NERR
VECTOR 0x1c,NERR
VECTOR 0x1d,NERR
VECTOR 0x1e,ERR
VECTOR 0x1f,NERR
VECTOR 0x20,NERR

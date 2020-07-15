org 0x7c00
read:
mov ah,0x02
mov al,40
mov ch,0
mov cl,2
mov dh,0
mov dl,0
mov bx,0x0000
mov es,bx
mov bx,0x0900
int 0x13
jc read
jmp 0x0900
times 510-($-$$) db 0
dw 0xaa55

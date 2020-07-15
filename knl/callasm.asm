global out8, in8, roll
out8:
	mov dx,[esp+4]
	mov al,[esp+8]
	out dx,al
	ret
in8:
	mov dx,[esp+4]
	in al,dx
	ret
roll:
	mov esi,0xc00b8000
	mov edi,0xc00b8000-160
	mov ecx,2000
	rep movsw
	ret

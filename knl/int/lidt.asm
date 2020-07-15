[bits 32]
global lidt
lidt:
	lidt [esp+4]
	ret

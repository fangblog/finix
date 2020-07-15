DD :=dd
NASM :=nasm
CAT :=cat
img: boot kernel Makefile
	$(DD) if=/dev/zero of=img count=1440
	$(DD) if=boot of=img conv=notrunc
	$(DD) if=kernel of=img conv=notrunc seek=1
boot: boot.asm Makefile
	$(NASM) boot.asm -o boot
kernel: loader.asm knl/ Makefile
	make -C knl/
	$(NASM) loader.asm -o kernel
	$(CAT) knl/finix>>kernel
PHONY :=clean
clean:
	-rm img
	-rm boot
	-rm kernel
	make -C knl/ clean


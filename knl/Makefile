CCFLAGS :=-m32 -g -Iinclude/
LDFLAGS :=-Ttext 0xc0003000 --strip-all -melf_i386 
NAFLAGS :=-g -Fdwarf -felf32
DD :=dd
NASM :=nasm
CAT :=cat
finix: finix.o callasm.o int/ Makefile
	make -C int/
	$(LD) $(LDFLAGS) finix.o int/int.o callasm.o -o finix -emain
finix.o: finix.c Makefile
	$(CC) $(CCFLAGS) finix.c -c -o finix.o
callasm.o: callasm.asm Makefile
	$(NASM) $(NAFLAGS) -o callasm.o callasm.asm
clean:
	make -C int/ clean
	rm *.o -r
	rm finix -r


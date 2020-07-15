CCFLAGS :=-m32 -I../include/
LDFLAGS :=-melf_i386 --relocatable
NAFLAGS :=-felf32
CC :=gcc
DD :=dd
NASM :=nasm
CAT :=cat
int.o: pic.o handler.o intc.o lidt.o Makefile
	$(LD) $(LDFLAGS) intc.o pic.o handler.o lidt.o -o int.o 
pic.o: pic.c Makefile
	$(CC) $(CCFLAGS) pic.c -c -o pic.o
intc.o: int.c Makefile
	$(CC) $(CCFLAGS) int.c -c -o intc.o
handler.o: handler.asm Makefile
	$(NASM) $(NAFLAGS) handler.asm -o handler.o
lidt.o: lidt.asm Makefile
	$(NASM) $(NAFLAGS) lidt.asm -o lidt.o
clean:
	rm -r *.o

org 0x900
jmp main
gdt:
dd 0,0
dd 0x0000ffff,0x00cf9800
dd 0x0000ffff,0x00cf9200
gdtsize equ $-gdt
gdtlimit equ gdtsize-1
PAGE_DIR_TABLE_POS equ 0x100000
PG_P equ 1b
PG_RW_R equ 00b
PG_RW_W equ 10b
PG_US_S equ 000b
PG_US_U equ 100b
sd equ 2<<3
gdt_ptr dw gdtlimit
dd gdt
main:
A20:
in al,0x92
or al,0x02
out 0x92,al
pm:
lgdt [gdt_ptr]
cli
mov eax,cr0
or eax,0x01
mov cr0,eax
jmp dword 0x0008:pmode;An exciting jump
pmode:
[bits 32]
mov ax,sd
mov ds,ax
mov es,ax
mov fs,ax
mov gs,ax
mov ss,ax
setup_page:
mov ecx, 4096
mov esi, 0
.clear_page_dir:
mov byte [PAGE_DIR_TABLE_POS + esi], 0
inc esi
loop .clear_page_dir
.create_pde: 
mov eax, PAGE_DIR_TABLE_POS
add eax, 0x1000 
mov ebx, eax 
or eax, PG_US_U | PG_RW_W | PG_P
mov [PAGE_DIR_TABLE_POS + 0x0], eax 
mov [PAGE_DIR_TABLE_POS + 0xc00], eax
sub eax, 0x1000
mov [PAGE_DIR_TABLE_POS + 4092], eax
mov ecx, 256 
mov esi, 0
mov edx, PG_US_U | PG_RW_W | PG_P 
.create_pte: 
mov [ebx+esi*4],edx
add edx,4096
inc esi
loop .create_pte
mov eax, PAGE_DIR_TABLE_POS
add eax, 0x2000 
or eax, PG_US_U | PG_RW_W | PG_P 
mov ebx, PAGE_DIR_TABLE_POS
mov ecx, 254 
mov esi, 769
.create_kernel_pde:
mov [ebx+esi*4], eax
inc esi
add eax, 0x1000
loop .create_kernel_pde
sgdt [gdt_ptr]
add dword [gdt_ptr+2],0xc0000000
add esp,0xc0000000
mov eax,PAGE_DIR_TABLE_POS
mov cr3,eax
mov eax,cr0
or eax,0x80000000
mov cr0,eax
lgdt [gdt_ptr]
mov byte [0xc00b8000],'V'
jmp loadknl+0xc0000000
loadknl:
mov ebx,[knl+28]
add ebx,knl
xor ecx,ecx
mov cx,[knl+44]
loadseg:
mov eax,[ebx]
cmp eax,1
jne lp
mov edi,[ebx+8]
mov eax,[ebx+4]
add eax,knl
mov esi,eax
push ecx
push eax
mov ecx,[ebx+16]
cpy:
mov eax,[esi]
mov [edi],eax
add esi,4
add edi,4
loop cpy
pop eax
pop ecx
lp:
add ebx,32
loop loadseg
mov eax,[knl+24];24=entry point offset of elf32
call eax
jmp $
knl:

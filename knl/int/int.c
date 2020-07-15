#include<stdint.h>
extern void* iet[0x21];
struct gd {
	uint16_t ol;
	uint16_t seg;
	uint8_t dc;
	uint8_t attr;
	uint16_t oh;
};
static void mid(struct gd* gdesc, uint8_t attr, void* offset);
static struct gd idt[0x21];
static void mid(struct gd* gdesc, uint8_t attr, void* offset)
{
	gdesc->ol = (uint32_t)offset&0xffff;
	gdesc->seg=0x8;
	gdesc->dc=0;
	gdesc->attr=attr;
	gdesc->oh=((uint32_t)offset&0xffff0000)>>16;
}
static void init_idt() {
	int i;
	for(i=0;i<0x21;i++){
		mid(&idt[i],0x8e,iet[i]);
	}
}
void init_all_int() {
	puts("init_int start\n");
	init_idt();
	init_pic();
	uint64_t idtr=((sizeof(idt)-1)|((uint64_t)((uint32_t)idt<<16)));
	lidt(idtr);
}


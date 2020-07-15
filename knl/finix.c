#include "callasm.h"
unsigned short getpos();
void setpos(unsigned char x, unsigned char y);
void init_all_int();
extern char* intr0x03;
int main()
{
	char *vram=0xc00b8000;
	short i;
	for(i=0;i<2000;i++)
	{
		*(vram+i*2)=0;
		*(vram+i*2+1)=7;
	}
	setpos(0,0);
	puts("12\t3\r\n456\t7\r\n\r\n\r\n\r\n\r\n");
	puts("12\t3\r\n456\t7");
	init_all_int();
	asm volatile("sti");
	return 0x0;
}
void puts(char *c){
	unsigned char x, y, tabsize;
	unsigned short xy;
	unsigned char i;
	xy=getpos();
	x=xy>>8;
	y=xy&0xff;
	while(*c)
	{
		if(*c=='\n')
		{
			x+=1;
		}else if(*c=='\t')
		{
			tabsize=8-(y%8);
			for(i=0;i<tabsize;i++){
				*((char*)0xc00b8000+((i+y)+x*80)*2)=0;
				*((char*)0xc00b8000+((i+y)+x*80)*2+1)=7;
			}
			y+=tabsize;
		}else if(*c=='\r')
		{
			y=0;
		}else
		{
			*((char*)0xc00b8000+(y+x*80)*2+1)=7;
			*((char*)0xc00b8000+(y+x*80)*2)=*c;
			y++;
			if(y>79)y=0,x++;
		}
		c++;
		if(y>79)x+=y%80;
		if(x>24){
			for(i=0;i<x-24;i++)roll();
				x=24;
		}
	}
	setpos(x,y);
}
void setpos(unsigned char x, unsigned char y)
{
	short linear=x*80+y;
	out8(0x03d4,14);
	out8(0x03d5,linear>>8);
	out8(0x03d4,15);
	out8(0x03d5,linear&0xff);
}
unsigned short getpos()
{
	unsigned char x,y;
	unsigned short linear,a;
	out8(0x03d4,14);
	linear=(unsigned short)(((unsigned char)in8(0x03d5))<<8);
	out8(0x03d4,15);
	a=(unsigned char)in8(0x03d5);
	linear+=a;
	x=linear/80;
	y=linear%80;
	return (unsigned short)(x<<8)+y;
}

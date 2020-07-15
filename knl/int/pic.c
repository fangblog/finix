#include "pic.h"
#include "callasm.h"
void init_pic()
{
	out8(0x0021, 0xff);
	out8(0x00a1, 0xff);
	out8(0x0020, 0x11);
	out8(0x0021, 0x20);
	out8(0x0021, 1<<2);
	out8(0x0021, 0x01);
	out8(0x00a0, 0x11);
	out8(0x00a1, 0x28);
	out8(0x00a1, 2);
	out8(0x00a1, 0x01);
	out8(0x0021, 0xfe);
	out8(0x00a1, 0xff);
}

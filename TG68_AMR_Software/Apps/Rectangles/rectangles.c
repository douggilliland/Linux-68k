#include "vga.h"
#include "interrupts.h"
#include "uart.h"
#include "board.h"

short *FrameBuffer;

extern short pen;
extern void DrawIteration();

static short framecount=0;

// vblank_int() - Vertical blank interrupt
// Scrolls screen up/down to limits in vblank

void vblank_int()
{
	int yoff;
	framecount++;
	if(framecount==959)
		framecount=0;
	if(framecount>=480)
		yoff=959-framecount;
	else
		yoff=framecount;
	HW_VGA_L(FRAMEBUFFERPTR)=(unsigned long)(&FrameBuffer[yoff*640]);
}

// main() - called by bootloader

int main(int argc,char **argv)
{
	unsigned char *fbptr;
	int c=0;	// color index

	VGA_SetSprite();

	FrameBuffer=(short *)0x10000;
	HW_VGA_L(FRAMEBUFFERPTR)=FrameBuffer;

	//EnableInterrupts();

	//SetIntHandler(VGA_INT_VBLANK,&vblank_int);
	
	// DGG - Hide the Bootloader text overlay window
	VGA_HideOverlay();
	c = 0xffff;
	HW_BOARD(REG_HEX)=c;
	DrawIteration();
	
	while(1);
//	{
		//++c;
		// HW_BOARD(REG_HEX)=c;
		// DrawIteration();
	// }
}


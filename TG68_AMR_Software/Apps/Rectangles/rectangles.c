#include "vga.h"
#include "interrupts.h"
#include "uart.h"
#include "board.h"

short *FrameBuffer;             // pointer to the frame buffer

extern short pen;               // 16 bit color
extern void DrawIteration();    // Draw boxes
extern void FillScreen();       // Fill the screen
extern void SingleRect();       // Draw a single rectangle
extern void VGA_HideOverlay();

static short framecount = 0;    // Scrolling count

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
// 
int main(int argc,char **argv)
{
	unsigned char *fbptr;   // frame buffer pointer

	pen = 0xf800;           // Set pen color

	// VGA_SetSprite();     //  Enable sprite

	FrameBuffer=(short *)0xf000;        // initialize frame buffer pointer
	HW_VGA_L(FRAMEBUFFERPTR)=(unsigned long)FrameBuffer;   // HW register for frame buffer

	//EnableInterrupts();       // initialize vertical interrupt
	//SetIntHandler(VGA_INT_VBLANK,&vblank_int);    // point to vblank rtn
	
	// DGG - Hide the Bootloader text overlay window
	// VGA_HideOverlay();
	// HW_BOARD(REG_HEX)=c // Hex Display not supported on EP4 card

	pen = 0x0000;           // Set pen color black
    FillScreen();       // Clear the screen
	DrawIteration();    // single draw
	pen = 0xf800;           // Set pen color red

	SingleRect();       // Draw  single rectangle
	
	pen = 0x0000;           // Set pen color black
	while(1);           // loop forever
	{
		// ++c;
		// HW_BOARD(REG_HEX)=c;
		DrawIteration();
	}
}


#ifndef MINISOC_VGA_H
#define MINISOC_VGA_H

#define VGABASE 0x80000000

#define FRAMEBUFFERPTR 0

#define SP0PTR 0x100
#define SP0XPOS 0x104
#define SP0YPOS 0x106

#define HW_VGA(x) *(volatile unsigned short *)(VGABASE+x)
#define HW_VGA_L(x) *(volatile unsigned long *)(VGABASE+x)
#define VGA_INT_VBLANK 1

#define REG_VGA_HTOTAL 0x08		// offset to register for total number of pixel clocks in a scanline 
#define REG_VGA_HSIZE 0x0a		// offset to register for number of horizontal pixels displayed
#define REG_VGA_HBSTART 0x0c	// offset to register for start of the horizontal blank
#define REG_VGA_HBSTOP 0x0e		// offset to register for end of the horizontal blanking period
#define REG_VGA_VTOTAL 0x10		// offset to register for number of scanlines in a frame
#define REG_VGA_VSIZE 0x12		// offset to register for number of displayed scanlines
#define REG_VGA_VBSTART 0x14	// offset to register for start of the vertical blanking period
#define REG_VGA_VBSTOP 0x16		// offset to register for end of the vertical blanking period
#define REG_VGA_CONTROL 0x18	// offset to register for 

#define BIT_VGA_CONTROL_OVERLAY 7
#define FLAG_VGA_CONTROL_OVERLAY (1<<BIT_VGA_CONTROL_OVERLAY)
#define BIT_VGA_CONTROL_VISIBLE 0
#define FLAG_VGA_CONTROL_VISIBLE (1<<BIT_VGA_CONTROL_VISIBLE)

#define MASK_VGA_CONTROL_PIXELCLOCK_2 2
#define MASK_VGA_CONTROL_PIXELCLOCK_3 4
#define MASK_VGA_CONTROL_PIXELCLOCK_4 6
#define MASK_VGA_CONTROL_PIXELCLOCK_5 8
#define MASK_VGA_CONTROL_PIXELCLOCK_6 0xa
#define MASK_VGA_CONTROL_PIXELCLOCK_7 0xc
#define MASK_VGA_CONTROL_PIXELCLOCK_8 0xe

#define VGACHARBUFFERBASE 0x80000800	// character overlay buffer
extern char *VGACharBuffer;

enum VGA_ScreenModes {
	MODE_640_400_70HZ,
	MODE_640_480_60HZ,
	MODE_320_480_60HZ,
	MODE_800_600_52HZ,
	MODE_800_600_72HZ,
	MODE_768_576_57HZ
};

void VGA_SetScreenMode(enum VGA_ScreenModes mode);

void SetSprite();

#endif


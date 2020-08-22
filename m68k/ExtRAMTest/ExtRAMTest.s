* Test External SRAM
* External SRAM on the RETRO-EP4CE15 card goes from 0x300000 to 0x3FFFFF (1 MB)
* External SRAM only supports 8-bit accesses
* TUTOR14 uses SRAM from 0x000000 to 0x000800

RAMSTART	= 0X300000
RAMEND		= 0X3FFFFF

* Code follows

	.ORG    0x001000

STARTTEST:
	MOVE.L  #0x00300000,%A0
	MOVE.B  #0x55,%D0
	MOVE.B	%D0,(%A0)
	RTS
	

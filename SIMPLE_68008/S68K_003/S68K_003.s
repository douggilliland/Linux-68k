| S68K_004.s - Assembly language example code
|	Uses S Record loader

CODE_START	= 0x001000	| Start of code
RAM_END		= 0x07FFFF	| 512KB SRAM

|||||||||||||||||||||||||||||||||
| 68681 Duart Register Addresses

DUART = 0x0F0000	  | Base Addr of DUART
OPC   = DUART+26      | Output port config        (W)
OPS   = DUART+28      | Output port Set           (W)
OPR   = DUART+30      | Output port Clear         (W)

	.ORG	CODE_START

	move.b	#0x00, OPC		| Output port configuration (all bit are outs)
	move.b	#0xFC, OPR		| Clear all outputs
	move.b	#0x04, OPS		| Turn off LED on DUART O2
loopLEDs:
	move.b	#0x04, OPR		| Turn on LED
	move.l 	#100000, %d0
wait1:
	sub.l 	#1, %d0
	bne		wait1
	move.b	#0x04, OPS		| Turn off LED
	move.l 	#100000, %d0
wait2:
	sub.l 	#1, %d0
	bne		wait2
	bra		loopLEDs

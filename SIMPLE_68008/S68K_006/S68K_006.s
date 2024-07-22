| S68K_002.s - Interrupt test code
| Interrupt on transmit empty
| Send out a character with every interrupt

CODE_START	= 0x001000	| Start of code
RAM_END		= 0x07FFFF	| 512KB SRAM

|||||||||||||||||||||||||||||||||
| 68681 Duart Register Addresses

DUART = 0x0F0000	  | Base Addr of DUART
MRA   = DUART+0		  | Mode Register A           (R/W)
SRA   = DUART+2       | Status Register A         (r)
CSRA  = DUART+2       | Clock Select Register A   (w)
CRA   = DUART+4       | Commands Register A       (w)
RBA   = DUART+6       | Receiver Buffer A         (r)
TBA   = DUART+6       | Transmitter Buffer A      (w)
ACR   = DUART+8       | Aux. Control Register     (R/W)
ISR   = DUART+10      | Interrupt Status Register (R)
IMR   = DUART+10      | Interrupt Mask Register   (W)
MRB   = DUART+16      | Mode Register B           (R/W)
SRB   = DUART+18      | Status Register B         (R)
CSRB  = DUART+18      | Clock Select Register B   (W)
CRB   = DUART+20      | Commands Register B       (W)
RBB   = DUART+22      | Reciever Buffer B         (R)
TBB   = DUART+22      | Transmitter Buffer B      (W)
IVR   = DUART+24      | Interrupt Vector Register (R/W)
OPC   = DUART+26      | Output port config        (W)
INU   = DUART+26      | Input port (unlatched)    (R)
OPS   = DUART+28      | Output port Set           (W)
OPR   = DUART+30      | Output port Clear         (W)

charTempPtr = 0x600
DUART_Vect = 0x100
DUART_VR = 0x40

	.ORG	CODE_START
    movem.l %d0/%a0-%a1, -(%SP)	| Save changed registers
	ori.w	#0x0700, %sr		| Disable interrupts
	| Set the start character (a '1')
	movea.l	#charTempPtr, %a0
	move.b	#'1', (%a0)			| Start character is a space
	| Fill the interrupt vector table entry for DUART interrupt
	movea.l	#DUART_Vect, %a0
	move.l	#0x1200, %d0
fillTable:
|	move.l	%d0, (%a0)+
|	cmp.l	#0x400,%a0
|	blt		fillTable
	move.b 	#DUART_VR, %d0
	| Set DUART interrupt vector
	movea.l	#DUART, %a0			| DUART base address
	move.b	%d0, 24(%a0)		| Interrupt Vector Register
	| Set DUART interrupt mask to enable Transmit Empty interrupt
	move.b	#0x01, 10(%a0)		| Interrupt Mask Register
    movem.l (%SP)+, %d0/%a0-%a1	| Restore registers
	rts

	.ORG	0x1100
enInts:
	andi.w	#0xF8FF, %sr		| Enable interrupts
	rts
	
	.ORG	0x1200
IntLev2:
    movem.l %d0/%a0-%a1, -(%SP)     | Save changed registers
	movea.l	#charTempPtr, %a0		| Get the character to write out
	movea.l	#DUART, %a1				| DUART base address
	move.b	(%a0), %d0				| Put char in d0
	move.b	%d0, 6(%a1)				| Write out the character
	add.b	#1, %d0					| Increment character
	cmp.b	#'z', %d0				| Go up to z
	ble		skipCRes
|	move.b	#'1', %d0				| Start character is a '1'
skipCRes:
|	move.b	%d0, (%a0)
|	move.b	#0x00, 10(%a1)			| Interrupt Mask Register
    movem.l (%SP)+, %d0/%a0-%a1     | Restore registers
	rte

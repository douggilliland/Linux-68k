| S68K_008.s - Timer Interrupt test code
| Interrupt on timer and increment counter in memory

CODE_START	= 0x001000	| Start of code
RAM_END		= 0x07FFFF	| 512KB SRAM

|||||||||||||||||||||||||||||||||
| 68681 Duart Register Addresses

DUART = 0x0F0000	  | Base Addr of DUART
MRA   = DUART+0		  | Mode Register A           (R/W)
SRA   = DUART+2       | Status Register A         (r)
CSRA  = DUART+2       | Clock Select Register A   (w)
CRA   = DUART+4       | Command Register A        (w)
RBA   = DUART+6       | Receiver Buffer A         (r)
TBA   = DUART+6       | Transmitter Buffer A      (w)
ACR   = DUART+8       | Aux. Control Register     (R/W)
ISR   = DUART+10      | Interrupt Status Register (R)
IMR   = DUART+10      | Interrupt Mask Register   (W)
CTU   = DUART+12	  | Counter Timer Upper		  (R/W)
CTL   = DUART+14	  | Counter Timer Lower		  (R/W)
MRB   = DUART+16      | Mode Register B           (R/W)
SRB   = DUART+18      | Status Register B         (R)
CSRB  = DUART+18      | Clock Select Register B   (W)
CRB   = DUART+20      | Command Register B        (W)
RBB   = DUART+22      | Reciever Buffer B         (R)
TBB   = DUART+22      | Transmitter Buffer B      (W)
IVR   = DUART+24      | Interrupt Vector Register (R/W)
OPC   = DUART+26      | Output port config        (W)
INU   = DUART+26      | Input port (unlatched)    (R)
OPS   = DUART+28      | Output port Set           (W)
OPS   = DUART+28      | Start Counter             (R)
OPR   = DUART+30      | Output port Clear         (W)
OPR   = DUART+30      | Stop Counter	          (R)

DUART_Vect = 0x100
DUART_VR = DUART_Vect / 4
BIG_CTR = 0x604

	.ORG	CODE_START
    movem.l %d0/%a0-%a1, -(%SP)	| Save changed registers
	ori.w	#0x0700, %sr		| Disable interrupts
	| Fill the interrupt vector table entry for DUART interrupt
	movea.l	#DUART_Vect, %a0
	move.l	#0x1200, %d0
	move.l	%d0, (%a0)
	move.b 	#DUART_VR, %d0
	| Set DUART interrupt vector
	movea.l	#DUART, %a0			| DUART base address
	move.b	%d0, 24(%a0)		| Interrupt Vector Register
	move.b	8(%a0), %d0			| Read ACR
	andi.b	#0x7f, %d0			| Mask ACR bits
	ori.b	#0x30, %d0			| XTAL X1, X2
	move.b	%d0, 8(%a0)			| Write back ACR
	move.b	#0x0F, 12(%a0)		| Write Counter Upper
	move.b	#0x00, 14(%a0)		| Write Counter Lower
	move.b	28(%a0),%d0			| Start Counter
	| Set DUART interrupt mask to enable Counter/Timer interrupt
	move.b	#0x08, 10(%a0)		| Interrupt Mask Register
	move.l	#0x0, BIG_CTR		| Clear the big counter
	andi.w	#0xF8FF, %sr		| Enable interrupts
    movem.l (%SP)+, %d0/%a0-%a1	| Restore registers
	rts
	
	.ORG	0x1200
IntLev2:
    movem.l %d0/%a0, -(%SP)     | Save changed registers
	movea.l	#DUART, %a0			| DUART base address
	move.b	#0x0F, 12(%a0)		| Write Counter Upper
	move.b	#0x00, 14(%a0)		| Write Counter Lower
	move.b	28(%a0), %d0		| Start Counter with read
	addi.l	#1, BIG_CTR			| Increment the big counter
    movem.l (%SP)+, %d0/%a0		| Restore registers
	rte

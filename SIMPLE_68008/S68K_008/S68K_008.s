| S68K_008.s - Timer Interrupt test code
| Interrupt on timer and increment counter in memory

CODE_START	= 0x001000	| Start of code
RAM_END		= 0x07FFFF	| 512KB SRAM

|||||||||||||||||||||||||||||||||
| 68681 Duart Register Addresses

DUART = 0x0F0000	  | Base Addr of DUART
MRA   = 0	| Mode Register A           (R/W)
SRA   = 2   | Status Register A         (r)
CSRA  = 2   | Clock Select Register A   (w)
CRA   = 4   | Command Register A        (w)
RBA   = 6   | Receiver Buffer A         (r)
TBA   = 6   | Transmitter Buffer A      (w)
ACR   = 8   | Aux. Control Register     (R/W)
ISR   = 10  | Interrupt Status Register (R)
IMR   = 10  | Interrupt Mask Register   (W)
CTU   = 12	| Counter Timer Upper		  (R/W)
CTL   = 14	| Counter Timer Lower		  (R/W)
MRB   = 16  | Mode Register B           (R/W)
SRB   = 18  | Status Register B         (R)
CSRB  = 18  | Clock Select Register B   (W)
CRB   = 20  | Command Register B        (W)
RBB   = 22  | Reciever Buffer B         (R)
TBB   = 22  | Transmitter Buffer B      (W)
IVR   = 24  | Interrupt Vector Register (R/W)
OPC   = 26  | Output port config        (W)
INU   = 26  | Input port (unlatched)    (R)
OPS   = 28  | Output port Set           (W)
STC   = 28  | Start Counter             (R)
OPR   = 30  | Output port Clear         (W)
SPC   = 30  | Stop Counter	            (R)

DUART_Vect = 0x100
DUART_VR = DUART_Vect / 4
BIG_CTR = 0x604
INTRTN = 0x1200

	.ORG	CODE_START
    movem.l %d0/%a0-%a1, -(%SP)	| Save changed registers
	ori.w	#0x0700, %sr		| Disable interrupts
	move.l	#0x0, BIG_CTR		| Clear the big counter
	| Fill the interrupt vector table entry for DUART interrupt
	movea.l	#DUART_Vect, %a0
	move.l	#INTRTN, %d0
	move.l	%d0, (%a0)
	move.b 	#DUART_VR, %d0
	| Set DUART interrupt vector
	movea.l	#DUART, %a0			| DUART base address
	move.b	%d0, IVR(%a0)		| Interrupt Vector Register
	move.b	ACR(%a0), %d0		| Read ACR
	andi.b	#0x8f, %d0			| Mask ACR bits
	ori.b	#0x70, %d0			| Timer mode using XTAL X1, X2 dive by 16
	move.b	%d0, ACR(%a0)		| Write back ACR
	move.b	#0x0F, CTU(%a0)		| Write Counter Upper
	move.b	#0x00, CTL(%a0)		| Write Counter Lower
	move.b	STC(%a0), %d0		| Start Counter
	| Set DUART interrupt mask to enable Counter/Timer interrupt
	move.b	#0x08, IMR(%a0)		| Interrupt Mask Register
	andi.w	#0xF8FF, %sr		| Enable interrupts
    movem.l (%SP)+, %d0/%a0-%a1	| Restore registers
	rts
	
	.ORG	INTRTN
IntLev2:
    movem.l %d0/%a0, -(%SP)     | Save changed registers
	move.b	SPC(%a0), %d0		| Stop Counter with dummy read clears int
	movea.l	#DUART, %a0			| DUART base address
	move.b	#0x0F, CTU(%a0)		| Write Counter Upper
	move.b	#0x00, CTL(%a0)		| Write Counter Lower
|	move.b	STC(%a0), %d0		| Start Counter with dummy read enables int
	addi.l	#1, BIG_CTR			| Increment the big counter
	move.b	#0x00, IMR(%a0)		| Interrupt Mask Register
    movem.l (%SP)+, %d0/%a0		| Restore registers
	rte

| Borrowed init code from 
|  https://raw.githubusercontent.com/ChartreuseK/68k-Monitor/master/Monitor-Simple.x68

RAM_START	= 0x00000	| Beginning of the SRAM
STACK_END	= 0x7FFFC	| Has to be on a word boundary
RAM_END		= 0x7FFFF	| 512KB SRAM
ROM_START	= 0x80000	| ROM start
ROM_CODE	= ROM_START+1024| Skip vector table
ROM_END		= 0x87FFF	| End of 32KB EPROM

|||||||||||||||||||||||||||||||||
| 68681 Duart Register Addresses
|
DUART = 0x0F0000			| Base Addr of DUART
MRA   = DUART+0				| Mode Register A           (R/W)
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

||||||||||||||||||||||||||||||||||
| ASCII Control Characters
|
BEL   = 0x07
BKSP  = 0x08       | CTRL-H
TAB   = 0x09
LF    = 0x0A
CR    = 0x0D
ESC   = 0x1B

CTRLC	=	0x03
CTRLX	=	0x18     | Line Clear

	.ORG	ROM_START

| FIRST 8 bytes loaded after reset |
    DC.l    STACK_END | Supervisor stack pointer
    DC.l    ROM_CODE	| Initial PC

        .ORG ROM_CODE
	nop
	lea			STACK_END,%sp
	move.b	#0xFF, 0x080000		| Set swap bit so SRAM works
	nop
|
| Test the first two SRAM location
|
	move.l	#0xDEADBEEF, %d0	| Test Pattern #1
	move		#0x00000000, %a0	| First address of SRAM
	move.l	%d0, (%a0)				| Write out test pattern to SRAM
	move.l	(%a0), %d2				| Read first SRAM pattern into d2
	cmp			%d2, %d0
	bne			FERVR2						
	move.l	#0x5555AAAA, %d1	| Test Pattern #2
	move		#0x00000004, %a1	| Second long address of SRAM
	move.l	%d1, (%a1)				| Write out test pattern to SRAM
	move.l	(%a1), %d3				| Read back
	cmp			%d3, %d1
	bne			FERVR2
	nop
| Test bits of first location (as bytes)
	move.l	#1, %d0
	move.l	#0, %a0
loop1stLoc:
	move.b	%d0, (%a0)
	move.b	(%a0), %d1
	cmp.b		%d0, %d1
	bne			failBitTest
	lsl			#1, %d0
	cmp.l		#0x00000100, %d0
	bne			loop1stLoc
|
| Test all address lines, 512KB SRAM
| Write incrementing pattern to data bits
|
	move.l	#1, %d0		| Fill pattern
	move.l	#1, %d2
	move.l	#1, %a0		| Start address 1 (already tested addr 0)
loopAdrFill:
	move.b	%d0,(%a0)	| Do the write
	addq		#1, %d0		| Increment the pattern
	move.l	%a0, %d2	| Copy a0 to d2 for shift
	lsl.l		#1, %d2		| Shift temp addr
	move.l	%d2, %a0	| Put back into addr reg
	cmp.l		#0x00080000,%d2
	bne			loopAdrFill
| Check
	move.l	#1, %d0
	move.l	#1, %d2
	move.l	#1, %a0
loopAdrCk:
	move.b	(%a0), %d1	| Do the read (as a byte)
	cmp.b		%d0, %d1
	bne			failAdrTest
	addq		#1, %d0
	move.l	%a0, %d2 
	lsl.l		#1, %d2
	move.l	%d2, %a0
	cmp.l		#0x00080000,%d2
	bne			loopAdrCk
|
| Done with address test of SRAM
|
	jsr     initDuart       | Setup the serial port
	move.b	#'+', d0
	jsr	outChar
FERVR:
	nop
	jmp	FERVR
|
FERVR2:
	nop
	jmp	FERVR2
failBitTest:
	nop
	jmp	failBitTest
failAdrTest:
	nop
	jmp	failAdrTest
|||||
| Writes a character to Port A, blocking if not ready (Full buffer)
|  - Takes a character in D0
outChar:
    btst    #2, SRA      | Check if transmitter ready bit is set
    beq     outChar     
    move.b  %d0, TBA      | Transmit Character
    rts

|||||
| Reads in a character from Port A, blocking if none available
|  - Returns character in D0
|    
inChar:
    btst    #0,  SRA     | Check if receiver ready bit is set
    beq     inChar
    move.b  RBA, %d0      | Read Character into D0
    rts

|||||
| Initializes the 68681 DUART port A as 9600 8N1 
initDuart:
    move.b  #0x30, CRA       | Reset Transmitter
    move.b  #0x20, CRA       | Reset Receiver
    move.b  #0x10, CRA       | Reset Mode Register Pointer
    
    move.b  #0x80, ACR       | Baud Rate Set #2
    move.b  #0xBB, CSRA      | Set Tx and Rx rates to 9600
    move.b  #0x93, MRA       | 7-bit, No Parity (0x93 for 8-bit, 0x92 for 7-bit)
    move.b  #0x07, MRA       | Normal Mode, Not CTS/RTS, 1 stop bit
    
    move.b  #0x05, CRA       | Enable Transmit/Recieve
    rts    



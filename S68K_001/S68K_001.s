| Borrowed init code from 
|  https://raw.githubusercontent.com/ChartreuseK/68k-Monitor/master/Monitor-Simple.x68

RAM_START	= 0x00100	| Leave room for vector table copy
RAM_END		= 0x7FFFF	| 512KB SRAM
ROM_START	= 0x80000	| ROM start
ROM_END		= 0x87FFF	| End of 32KB EPROM

|||||||||||||||||||||||||||||||||
| 68681 Duart Register Addresses
|
DUART = 0x0F0000       | Base Addr of DUART
MRA   = DUART+0       | Mode Register A           (R/W)
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

STACK_START         =     RAM_END

	.ORG	ROM_START

| FIRST 8 bytes loaded after reset |
    DC.l    STACK_START  | Supervisor stack pointer
    DC.l    ROM_START    | Initial PC    

ROM_START:
    jsr     initDuart           | Setup the serial port
FERVR:
	jmp FERVR

|||||
| Writes a character to Port A, blocking if not ready (Full buffer)
|  - Takes a character in D0
outChar:
    btst    #2, SRA      | Check if transmitter ready bit is set
    beq     outChar     
    move.b  d0, TBA      | Transmit Character
    rts

|||||
| Reads in a character from Port A, blocking if none available
|  - Returns character in D0
|    
inChar:
    btst    #0,  SRA     | Check if receiver ready bit is set
    beq     inChar
    move.b  RBA, d0      | Read Character into D0
    rts

|||||
| Initializes the 68681 DUART port A as 9600 8N1 
initDuart:
    move.b  #0x30, CRA       | Reset Transmitter
    move.b  #0x20, CRA       | Reset Reciever
    move.b  #0x10, CRA       | Reset Mode Register Pointer
    
    move.b  #0x80, ACR       | Baud Rate Set #2
    move.b  #0xBB, CSRA      | Set Tx and Rx rates to 9600
    move.b  #0x93, MRA       | 7-bit, No Parity (0x93 for 8-bit, 0x92 for 7-bit)
    move.b  #0x07, MRA       | Normal Mode, Not CTS/RTS, 1 stop bit
    
    move.b  #0x05, CRA       | Enable Transmit/Recieve
    rts    



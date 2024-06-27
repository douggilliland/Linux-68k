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
	
	lea		BANNER_MSG, %a0
	jsr		printString1
	lea		RAM_PASS_MSG, %a0
	jsr		printString1
|
|	jsr		inChar
|	jsr		outChar
|	jmp		FERVR
|
|	lea		READINLINE, %a0
|	jsr		printString1
interpLoop:
    lea     msgPrompt, %a0   | Prompt
    bsr.w   printString
	jsr		readLine
	jsr		lineToUpper
	move.b	#0x04, OPS		| Blink LED on DUART Out2
	jsr		parseLine
	jsr		delay1Sec
	move.b	#0x04, OPR
	bra		interpLoop
	
FERVR:
	nop
	move.b	#0x04, OPS		| Blink LED on DUART Out2
	jsr		delay1Sec
	move.b	#0x04, OPR
	jsr		delay1Sec
	jmp		FERVR
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
outChar1:
outChar:
    btst    #2, SRA      | Check if transmitter ready bit is set
    beq     outChar1     
    move.b  %d0, TBA      | Transmit Character
    rts

| Writes a character to Port A, blocking if not ready (Full buffer)
|  - Takes a character in D0
outChar2:
    btst    #2, SRB      | Check if transmitter ready bit is set
    beq     outChar2     
    move.b  %d0, TBB      | Transmit Character
    rts

******
* Print a null terminated string
*
printString1:
printString:
 PSloop:
    move.b  (%a0)+, %d0  | Read in character
    beq.s   PSend         | Check for the null
    
    bsr.s   outChar      | Otherwise write the character
    bra.s   PSloop        | And continue
PSend:
    rts


|||||
| Reads in a character from Port A, blocking if none available
|  - Returns character in D0
|    
inChar1:
inChar:
    btst    #0,  SRA	| Check if receiver ready bit is set
    beq     inChar1
    move.b  RBA, %d0	| Read Character into D0
    rts

inChar2:
    btst    #0,  SRB	| Check if receiver ready bit is set
    beq     inChar2
    move.b  RBB, %d0	| Read Character into D0
    rts

| Read in a line into the line buffer
readLine:
    movem.l %d2/%a2, -(%SP)     | Save changed registers
    lea     varLineBuf, %a2   	| Start of the lineBuffer
    eor.w   %d2, %d2           	| Clear the character counter
 RLloop:
    bsr.w   inChar           	| Read a character from the serial port
    cmp.b   #BKSP, %d0        	| Is it a backspace?
    beq.s   RLBS
    cmp.b   #CTRLX, %d0       	| Is it Ctrl-H (Line Clear)?
    beq.s   RLlineClr
    cmp.b   #CR, %d0          	| Is it a carriage return?
    beq.s   RLEndLn
    cmp.b   #LF, %d0          	| Is it anything else but a LF?
    beq.s   RLloop            	| Ignore LFs and get the next character
 .char:                      	| Normal character to be inserted into the buffer
    cmp.w   #MAX_LINE_LENGTH, %d2
    bge.s   RLloop            	| If the buffer is full ignore the character
    move.b  %d0, (%a2)+        	| Otherwise store the character
    addq.w  #1, %d2           	| Increment character count
    bsr.w   outChar          	| Echo the character
    bra.s   RLloop            	| And get the next one
 RLBS:
    tst.w   %d2               	| Are we at the beginning of the line?
    beq.s   RLloop            	| Then ignore it
    bsr.w   outChar          	| Backspace
    move.b  #' ', %d0
    bsr.w   outChar          	| Space
    move.b  #BKSP, %d0
    bsr.w   outChar          	| Backspace
    subq.l  #1, %a2           	| Move back in the buffer
    subq.l  #1, %d2           	| And current character count
    bra.s   RLloop            	| And goto the next character
 RLlineClr:
    tst     %d2               	| Anything to clear?
    beq.s   RLloop            	| If not, fetch the next character
    suba.l  %d2, %a2           	| Return to the start of the buffer
 RLlineClrloop:
    move.b  #BKSP, %d0
    bsr.w   outChar          	| Backspace
    move.b  #' ', %d0
    bsr.w   outChar          	| Space
    move.b  #BKSP, %d0
    bsr.w   outChar          	| Backspace
    subq.w  #1, %d2          
    bne.s   RLlineClrloop   	| Go till the start of the line
    bra.s   RLloop   
 RLEndLn:
    bsr.w   outChar          	| Echo the CR
    move.b  #LF, %d0
    bsr.w   outChar          	| Line feed to be safe
    move.b  #0, (%a2)         	| Terminate the line (Buffer is longer than max to allow this at full length)
    movea.l %a2, %a0           	| Ready the pointer to return (if needed)
    movem.l (%SP)+, %d2/%a2     | Restore registers
    rts                      	| And return


| Convert line buffer to upper case
lineToUpper:
    lea     varLineBuf, %a0   | Get the start of the line buffer
 LUloop:
    move.b  (%a0), %d0        | Read in a character
    cmp.b   #'a', %d0         
    blt.s   LUnext            | Is it less than lower-case 'a', then move on
    cmp.b   #'z', %d0
    bgt.s   LUnext            | Is it greater than lower-case 'z', then move on
    sub.b   #0x20, %d0         | Then convert a to A, b to B, etc.
 LUnext:
    move.b  %d0, (%a0)+       | Store the character back into a0, and move to the next
    bne.s   LUloop             | Keep going till we hit a null terminator
    rts

|
| Parse Line
|
parseLine:
    movem.l %a2-%a3, -(%SP)     | Save registers
    lea     varLineBuf, %a0
 PLfindCommand:
    move.b  (%a0)+, %d0
    cmp.b   #' ', %d0           | Ignore spaces
    beq.w   PLfindCommand    
    cmp.b   #'E', %d0           | Examine command
    beq.w   .examine
    cmp.b   #'D', %d0           | Deposit command
    beq.w   .deposit
    cmp.b   #'R', %d0           | Run command
    beq.w   .run
    cmp.b   #'H', %d0           | Help command
    beq.w   .help
    cmp.b   #0, %d0             | Ignore blank lines
    beq.s   .exit               
 .invalid:   
    lea     msgInvalidCommand, %a0
    bsr.w   printString
 .exit:
    movem.l (%SP)+, %a2-%a3     | Restore registers
    rts

 .help:
    lea     msgHelp, %a0
    bsr.w   printString
    bra.w   .exit
 .invalidAddr:
    lea     msgInvalidAddress, %a0
    bsr.w   printString
    bra.w   .exit
 .invalidVal:
    lea     msgInvalidValue, %a0
    bsr.w   printString
    bra.w   .exit

.examine:
.deposit:
.run:
	bra	.exit
	
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

    move.b  #0x30, CRB       | Reset Transmitter
    move.b  #0x20, CRB       | Reset Receiver
    move.b  #0x10, CRB       | Reset Mode Register Pointer
    
    move.b  #0xBB, CSRB      | Set Tx and Rx rates to 9600
    move.b  #0x93, MRB       | 7-bit, No Parity (0x93 for 8-bit, 0x92 for 7-bit)
    move.b  #0x07, MRB       | Normal Mode, Not CTS/RTS, 1 stop bit
    
    move.b  #0x05, CRB       | Enable Transmit/Recieve
	
	move.b	#0x00, OPC		 | Output port configuration (all bit are outs)
	move.b	#0xFC, OPR		 | Clear all outputs
    rts    

delay1Sec:
	move.l	#200000, %d0	| rough count
delay1Loop:
	sub.l	#1, %d0			
	bne		delay1Loop
	rts

READINLINE:	  
	.ascii  "Reading in line"
	dc.b CR,LF,EOT
L_TO_UPPER_MSG:  
	.ascii  "Convert line to upper case"
	dc.b CR,LF,EOT
WRITEOUTLINE:	  
	.ascii  "Writing out line"
	dc.b CR,LF,EOT
RAM_PASS_MSG:  
	.ascii  "RAM Test Passed"
	dc.b CR,LF,EOT
BANNER_MSG:	
	.ascii  "SIMPLE-68008 CPU"
	dc.b CR,LF,EOT
msgInvalidCommand:
    .ascii "Invalid Command"
	dc.b CR,LF,EOT
CRLF_MSG:	
	dc.b CR,LF,EOT
msgHelp:
    .ascii	"Available Commands: "
	dc.b	CR,LF
    .ascii	" (E)xamine    (D)eposit    (R)un     (H)elp"
	dc.b	CR,LF,EOT
msgInvalidAddress:
    dc.b	"Invalid Address"
	dc.b 	CR,LF,EOT
msgInvalidValue:
    .ascii	"Invalid Value"
	dc.b	CR,LF,EOT
msgPrompt:
	.ascii "> "
    dc.b EOT
	
MAX_LINE_LENGTH = 80
varLineBuf = RAM_END+1-1024-MAX_LINE_LENGTH-2

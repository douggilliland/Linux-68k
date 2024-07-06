| S68K_002.s - 68K Monitor with extensions
|	Adds S Record loader
| Borrowed init code from 
|  https://raw.githubusercontent.com/ChartreuseK/68k-Monitor/master/Monitor-Simple.x68

RAM_START	= 0x00000	| Beginning of the SRAM
STACK_END	= 0x7FFFC	| Has to be on a word boundary
RAM_END		= 0x7FFFF	| 512KB SRAM
ROM_START	= 0x80000	| ROM start
ROM_CODE	= ROM_START+1024| Skip vector table
*ROM_END	= 0x87FFF	| End of 32KB EPROM
ROM_END		= 0x8FFFF	| End of 64KB EPROM

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
EOT	  = 0x00

CTRLC	=	0x03
CTRLX	=	0x18     | Line Clear

	.ORG    0x000400
srecType:	ds.b	1		| S1-S9 stored as binary 1-9
srecByCt:	ds.b	1		| Byte Count
srecData:	ds.b	1 		| Data
srecCSum:	ds.b	1 		| S-Record Checksum
srecAddr:	ds.l	1		| S Record current byte address

	.ORG	ROM_START

| FIRST 8 bytes loaded after reset |
    DC.l    STACK_END | Supervisor stack pointer
    DC.l    ROM_CODE	| Initial PC

        .ORG ROM_CODE
	nop
	lea			STACK_END,%sp
	move.b	#0xFF, 0x080000		| Set swap bit so SRAM works
	nop
| LEDs
	move.b	#0x00, OPC		| Output port configuration (all bit are outs)
	move.b	#0xFC, OPR		| Clear all outputs
	move.b	#0x04, OPS		| Turn off LED on DUART O2
|
| Test the first two SRAM location
|
	move.l	#0xDEADBEEF, %d0		| Test Pattern #1
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
| Fill SRAM with 0x00 values
| 512KB fill takes about 2.5 seconds at 10 MHz CPU speed
|
fillSRAM:
	lea		RAM_START, %a0		| Start at base RAM address
	lea		RAM_END, %a1		| End when reach end RAM space
	move.l	#0x00, %d0			| Fill with zeros
fillSRAMLoop:
	move.l	%d0, (%a0)+			| Long fills are faster
	cmpa.l	%a0, %a1
	bgt		fillSRAMLoop

|
| Done with address test of SRAM
|
	jsr     initDuart       	| Setup the serial port
monitorStart:					| Warm start
	lea		BANNER_MSG, %a0
	jsr		printString1
	lea		RAM_PASS_MSG, %a0
	jsr		printString1
|
| Interpreter Loop
|
interpLoop:
    lea     msgPrompt, %a0	| Prompt
    bsr.w   printString
	move.b	#0x04, OPR		| Turn on LED
	jsr		readLine		| Blocking read of line
	move.b	#0x04, OPS		| Turn off LED
	jsr		lineToUpper
	jsr		parseLine
	bra.s	interpLoop
	
failBitTest:
failAdrTest:
FERVR2:
	nop
	jmp	FERVR2

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
    cmp.b   #'L', %d0           | Help command
    beq.w   loadSRec
    cmp.b   #0, %d0             | Ignore blank lines
    beq.s   .exit               
 .invalid:   
    lea     msgInvalidCommand, %a0
    bsr.w   printString
 .exit:
    movem.l (%SP)+, %a2-%a3     | Restore registers
    rts

|||||||||||||||||||||||||||||||
|| HELP command
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
	
|||||||||||||||||||||||||||||||
| Examines memory addresses
| Valid modes:
|   e ADDR                  Displays a single byte
|   e ADDR-ADDR             Dispalys all bytes between the two addresses
|   e ADDR+LEN              Dispays LEN bytes after ADDR
|   e ADDR;                 Interactive mode, space shows 16 lines, enter shows 1.
|   e ADDR.                 Quick line, displays one line 
.examine:
    bsr.w   parseNumber         | Read in the start address
    tst.b   %d1                 | Make sure it's valid (parseNumber returns non-zero in d1 for failure)
    bne.w   .invalidAddr        
    move.l  %d0, %a3            | Save the start address
 .exloop:
    move.b  (%a0)+, %d0
    cmp.b   #' ', %d0           | Ignore spaces
    beq.s   .exloop
    cmp.b   #'-', %d0           | Check if it's a range specifier
    beq.s   .exrange
    cmp.b   #'+', %d0           | Check if it's a length specifier
    beq.s   .exlength
    cmp.b   #';', %d0           | Check if we're going interactive
    beq.s   .exinter
    cmp.b   #'.', %d0           | Check if quick 16 
    beq.s   .exquick
    move.l  #1, %d0             | Otherwise read in a single byte
    bra.s   .exend              
 .exrange:
    bsr.w   parseNumber         | Find the end address
    tst.b   %d1                 | Check if we found a valid address
    bne.w   .invalidAddr
    sub.l   %a3, %d0            | Get the length
    bra.s   .exend
 .exquick:                      | Quick mode means show one line of 16 bytes
    move.l  #0x10, %d0
    bra.s   .exend
 .exlength:                     | Length mode means a length is specified
    bsr.w   parseNumber         | Find the length
    tst.b   %d1
    bne.w   .invalidAddr
 .exend:                        | Done parsing, give the parameters to dumpRAM and exit
    move.l  %a3, %a0
    bsr.w   dumpRAM
    bra.s   .exit
 .exinter:                      | Interactive mode, Space shows 16 lines, enter shows 1.
    move.l  %a3, %a0            | Current Address
    move.l  #0x10, %d0          | 16 bytes
    bsr.w   dumpRAM             | Dump this line
    add.l   #0x10, %a3          | Move up the current address 16 bytes
 .exinterend:
    bsr.w   inChar
    cmp.b   #CR, %d0            | Display another line
    beq.s   .exinter
    cmp.b   #' ', %d0           | Display a page (256 bytes at a time)
    beq.s   .exinterpage
    bra	   .exit               | Otherwise exit
 .exinterpage:
    move.l  %a3, %a0
    move.l  #0x100, %d0         | 256 bytes
    bsr.w   dumpRAM             | Dump 16 lines of RAM
    add.l   #0x100, %a3         | Move up the current address by 256
    bra.s   .exinterend

|||||||||||||||||||||||||||||
|| Load S Record
|	srecType:	ds.b	1		| S1-S9 stored as binary 1-9
|	srecByCt:	ds.b	1		| Byte Count
|	srecData:	ds.b	1 		| Data
|	srecCSum:	ds.b	1 		| S-Record Checksum
|	srecAddr:	ds.l	1		| S Record current byte address
|
| Supports 3 S record types (matches gcc m68k output)
|	S00F00005336384B5F3030322E746D7074
|	S2240800000007FFFC00080400000000000000000000000000000000000000000000000000C5
|	S503005BA1

loadSRec:
    lea     ldSRecMsg, %a0
    bsr.w   printString
	bsr		getRecType
	bsr		getBytCt
	move.b 	#0, srecCSum
	bsr		getAddr
	lea		debug_Srec_LDData_Msg, %a0
	bsr		printString
loopSData:
	cmp.b 	#1, srecByCt
	beq		sRecDataDone
	jsr		getLdData
	bra		loopSData
sRecDataDone:
	jsr		getChksum
	bra.w   .exit

getLdData:
	jsr		getHexPair
	cmp.b	#2, srecType
	bne		skipLdData
	lea 	srecAddr, %a0
	move.b	%d0, (%a0)
	add.l	#1, srecAddr
skipLdData:
	add.b	%d0, srecCSum
	sub.b	#1, srecByCt
	rts

getChksum:
	lea		debug_Srec_CSum_Msg, %a0
    bsr.w   printString
	jsr		getHexPair
	add.b	%d0, srecCSum
	move.b	srecCSum, %d0
	jsr		printHexByte
	lea		CRLF_MSG, %a0
    bsr.w   printString
failCSUM:
	rts

getRecType:
	jsr		inChar
	cmp.b	#'S', %d0
	bne		getRecType
	jsr		inChar
	andi.b	#0x0f, %d0
	move.b	%d0, srecType
| Debug messages follow
	lea		debug_Srec_Typ_Msg, %a0		| Debug message
    bsr.w   printString
	move.b	srecType, %d0
	add.b	#'0', %d0
	jsr		outChar
	lea		CRLF_MSG, %a0
    bsr.w   printString
| Debug messages end
	rts
	
getBytCt:
	jsr		getHexPair
	move.b 	%d0, srecCSum
	move.b	%d0, srecByCt
| Debug messages follow
	lea		debug_Srec_BytCt_Msg, %a0
    bsr.w   printString
	move.b	srecByCt, %d0
	jsr		printHexByte
	lea		CRLF_MSG, %a0
    bsr.w   printString
| Debug messages end
	sub.b	#1, srecByCt
	rts

getHexPair:
	movem.l %d2, -(%SP)		| Save registers
	jsr		inChar
	jsr		toNibble
	asl.b	#4, %d0
	move.b	%d0, %d2
	jsr		inChar
	jsr		toNibble
	or.b	%d2, %d0
	movem.l (%SP)+, %d2		| Restore registers
	rts

toNibble:
	cmp.b	#'A', %d0
	bge		doHexLetter
	sub.b	#'0', %d0
	rts
doHexLetter:
	sub.b	#'A'+10, %d0
	rts

getAddr:
	movem.l %d2, -(%SP)		| Save registers
	move.b	srecType, %d0
	cmp.b	#'2', %d0
	bne		adrLen16
	lea		debug_S2rec_Addr_Msg, %a0
	bsr		printString
	move.l	#0, %d2			| d2 stores address for accumulation of bytes
	| Get the upper 8-bits of 24-bits
	jsr		getHexPair
	add.b 	%d0, srecCSum
	or.l	%d0, %d2
	asl.l	#8, %d2
	move.l	%d2, %d0
	bsr		printHexLong
	lea		CRLF_MSG, %a0
    bsr.w   printString
	| Get the middle 8-bits of 24-bits
	jsr		getHexPair
	add.b 	%d0, srecCSum
	or.l	%d0, %d2
	asl.l	#8, %d2
	move.l	%d2, %d0
	bsr		printHexLong
	lea		CRLF_MSG, %a0
    bsr.w   printString
	| Get the lower 8-bits of 24-bits
	jsr		getHexPair
	add.b 	%d0, srecCSum
	or.l	%d0, %d2
	move.l	%d2, srecAddr		| Save the S record address
	sub.b	#3, srecByCt
	move.l	%d2, %d0
	bsr		printHexLong
	lea		CRLF_MSG, %a0
    bsr.w   printString
	bra		past16
adrLen16:
	lea		debug_SXrec_Addr_Msg, %a0
	bsr		printString
|	move.l	#0, %d2
	jsr		getHexPair
	sub.b	#3, srecByCt
	bsr		printHexLong
	lea		CRLF_MSG, %a0
    bsr.w   printString
|	or.l	%d0, %d2
|	asl.l	#8, %d2
	jsr		getHexPair
	sub.b	#3, srecByCt
	bsr		printHexLong
	lea		CRLF_MSG, %a0
    bsr.w   printString
|	or.l	%d0, %d2
|	move.l	%d2, srecAddr
	sub.b	#2, srecByCt
past16:
	movem.l (%SP)+, %d2		| Restore registers
	rts
		
|||||||||||||||||||||||||||||
| Find and parse a hex number
|  Starting address in A0
|  Number returned in D0
|  Status in D1   (0 success, 1 fail)
|  TODO: Try and merge first digit code with remaining digit code
parseNumber:
    eor.l   %d0, %d0		| Zero out d0
    move.b  (%a0)+, %d0
    cmp.b   #' ', %d0		|  Ignore all leading spaces
    beq.s   parseNumber
    cmp.b   #'0', %d0       | Look for hex digits 0-9
    blt.s	PNinvalid
    cmp.b   #'9', %d0
    ble.s   PNfirstdigit1

    cmp.b   #'A', %d0      	| Look for hex digits A-F
    blt   .invalid    
    cmp.b   #'F', %d0
    ble.s   PNfirstdigit2
PNinvalid:
    move.l  #1, %d1			| Invalid character, mark failure and return
    rts
PNfirstdigit2:
    sub.b   #'7', %d0       | Turn 'A' to 10
    bra.s   PNloop
PNfirstdigit1:
    sub.b   #'0', %d0       | Turn '0' to 0
 PNloop:
    move.b  (%a0)+, %d1      | Read in a digit
    cmp.b   #'0', %d1       | Look for hex digits 0-9
    blt.s   PNend         	| Any other characters mean we're done reading
    cmp.b   #'9', %d1
    ble.s   PNdigit1
    cmp.b   #'A', %d1      	| Look for hex digits A-F
    blt.s   PNend
    cmp.b   #'F', %d1
    ble.s   PNdigit2

PNend:                       | We hit a non-hex digit character, we're done parsing
    subq.l  #1, %a0         | Move the pointer back before the end character we read
    move.l  #0, %d1
    rts
PNdigit2:
    sub.b   #'7', %d1		| Turn 'A' to 10
    bra.s   PNdigit3
PNdigit1:
    sub.b   #'0', %d1       | Turn '0' to 0
PNdigit3:
    lsl.l   #4, %d0        	| Shift over to the next nybble
    add.b   %d1, %d0       	| Place in our current nybble (could be or.b instead)
    bra.s   PNloop
    

|||||||||||||||||||||||||||||
| Dumps a section of RAM to the screen
| Displays both hex values and ASCII characters
| d0 - Number of bytes to dump
| a0 - Start Address
dumpRAM:
    movem.l %d2-%d4/%a2, -(%SP) | Save registers
    move.l  %a0, %a2           	| Save the start address
    move.l  %d0, %d2           	| And the number of bytes
 .line:
    move.l  %a2, %d0          
    bsr.w   printHexAddr     	| Starting address of this line
    lea     msgColonSpace, %a0
    bsr.w   printString
    move.l  #16, %d3         	| 16 Bytes can be printed on a line
    move.l  %d3, %d4       		| Save number of bytes on this line
 .hexbyte:
    tst.l   %d2               	| Check if we're out of bytes
    beq.s   .endbytesShort
    tst.b   %d3               	| Check if we're done this line
    beq.s   .endbytes    
    move.b  (%a2)+, %d0        	| Read a byte in from RAM
    bsr.w   printHexByte     	| Display it
    move.b  #' ', %d0
    bsr.w   outChar          	| Space out bytes
    subq.l  #1, %d3    
    subq.l  #1, %d2        
    bra.s   .hexbyte
 .endbytesShort:
    sub.b   %d3, %d4           	| Make d4 the actual number of bytes on this line
    move.b  #' ', %d0
 .endbytesShortLoop:
    tst.b   %d3               	| Check if we ended the line
    beq.s   .endbytes
    move.b  #' ', %d0
    bsr.w   outChar          	| Three spaces to pad out
    move.b  #' ', %d0
    bsr.w   outChar
    move.b  #' ', %d0
    bsr.w   outChar
    
    subq.b  #1, %d3
    bra.s   .endbytesShortLoop
 .endbytes:
    suba.l  %d4, %a2        	| Return to the start address of this line
 .endbytesLoop:
    tst.b   %d4               	| Check if we are done printing ascii
    beq     .endline    
    subq.b  #1, %d4
    move.b  (%a2)+, %d0        	| Read the byte again
    cmp.b   #' ', %d0         	| Lowest printable character
    blt.s   .unprintable
    cmp.b   #'~', %d0         	| Highest printable character
    bgt.s   .unprintable
    bsr.w   outChar
    bra.s   .endbytesLoop
 .unprintable:
    move.b  #'.', %d0
    bsr.w   outChar
    bra.s   .endbytesLoop
 .endline:
    lea     msgNewline, %a0
    bsr.w   printString
    tst.l   %d2
    ble.s   .end
    bra.w   .line
 .end:
    movem.l (%SP)+, %d2-%d4/%a2		| Restore registers
    rts

|||||||||||||||||||||||
| Deposit values into RAM
| d ADDR VAL VAL            Deposit value(s) into RAM
| d ADDR VAL VAL;           Deposit values, continue with values on next line
|  VAL VAL VAL;              - Continuing with further continue
| d: VAL VAL                Continue depositing values after the last address written to
|||||||||||||||||||||||
.deposit:
    move.b  (%a0), %d0
    cmp.b   #':', %d0       	| Check if we want to continue from last
    beq.s   DepCont
    
    bsr.w   parseNumber         | Otherwise read the address
    tst.b   %d1
    bne		.invalidAddr
    move.l  %d0, %a3           	| Save the start address
 DepLoop:
    move.b  (%a0), %d0            
    cmp.b   #';', %d0          	| Check for continue
    beq.s   DepMLine
    tst     %d0              	| Check for the end of line
    beq     DepEnd
    
    bsr		parseNumber         | Otherwise read a value
    tst.b   %d1
    bne		.invalidVal
    cmp.w   #255, %d0          	| Make sure it's a byte
    bgt		.invalidVal
    
    move.b  %d0, (%a3)+        	| Store the value into memory
    bra.s   DepLoop
    
 DepCont:
    move.l  varCurAddr, %a3   	| Read in the last address 
    addq.l  #1, %a0           	| Skip over the ':'
    bra.s   DepLoop
    
 DepMLine:
    lea     msgDepositPrompt, %a0
    bsr.w   printString
    bsr.w   readLine          	| Read in the next line to be parsed
    bsr.w   lineToUpper         | Convert to uppercase
    lea     varLineBuf, %a0    	| Reset our buffer pointer
    bra.s   DepLoop            	| And jump back to decoding
 DepEnd:
    move.l  %a3, varCurAddr
    bra.w   .exit

|||||||||||||||||||||||
| run code
 .run:
    bsr.w   parseNumber        	| Otherwise read the address
    tst.b   %d1
    bne		.invalidAddr
    move.l  %d0, %a0
    jsr     (%a0)             	| Jump to the code! 
                                | Go as subroutine to allow code to return to us
    jsr     monitorStart        | Warm start after returning so everything is in
                                | a known state.


|||||||||||||||||||||||
|| KEEP All printHex functions together ||
|||||||||||||||||||||||
| Print a hex word
printHexWord:
    move.l  %d2, -(%SP)		| Save D2
    move.l  %d0, %d2		| Save the address in d2
    
    rol.l   #0x8, %d2       | 4321 -> 3214
    rol.l   #0x8, %d2       | 3214 -> 2143 
    bra.s   printHex_wordentry  | Print out the last 16 bits
|||||||||||||||||||||||
| Print a hex 24-bit address
printHexAddr:
    move.l %d2, -(%SP)   	| Save D2
    move.l %d0, %d2      	| Save the address in d2
    
    rol.l   #0x8, %d2     	| 4321 -> 3214
    bra.s   printHex_addrentry  | Print out the last 24 bits
|||||||||||||||||||||||
* Print a hex long
printHexLong:
    move.l  %d2, -(%SP)     | Save D2
    move.l  %d0, %d2        | Save the address in d2
    
    rol.l   #0x8, %d2        | 4321 -> 3214 high byte in low
    move.l  %d2, %d0
    bsr.s   printHexByte  	| Print the high byte (24-31)
printHex_addrentry:     
    rol.l   #0x8, %d2        	| 3214 -> 2143 middle-high byte in low
    move.l  %d2, %d0              
    bsr.s   printHexByte  	| Print the high-middle byte (16-23)
printHex_wordentry:    
    rol.l   #0x8, %d2        	| 2143 -> 1432 Middle byte in low
    move.l  %d2, %d0
    bsr.s   printHexByte  	| Print the middle byte (8-15)
    rol.l   #0x8, %d2
    move.l  %d2, %d0
    bsr.s   printHexByte  	| Print the low byte (0-7)
    
    move.l (%SP)+, %d2      | Restore D2
    RTS
    
|||||||||||||||||||||||
| Print a hex byte
|  - Takes byte in D0
printHexByte:
    move.l  %D2, -(%SP)
	move.l	#0, %d2
    move.b  %d0, %d2
    lsr.b   #0x4, %d0		| Shift down upper nibble
	andi.b	#0xf, %d0
    add.b   #'0', %d0
    cmp.b   #'9', %d0		| Check if the hex number was from 0-9
    ble.s   PHBsecond
    add.b   #0x7, %d0			| Shift 0xA-0xF from ':' to 'A'
PHBsecond:
    bsr   outChar			| Print the digit
    andi.b  #0x0F, %d2		| Now we want the lower digit Mask only the lower digit
    add.b   #'0', %d2
    cmp.b   #'9', %d2     	| Same as before    
    ble.s   PHBend
    add.b   #0x7, %D2
PHBend:
    move.b  %D2, %D0
    bsr	   outChar      	| Print the lower digit
    move.l  (%SP)+, %D2
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
msgDepositPrompt:
    .ascii	": "
	dc.b 	EOT
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
    .ascii	" (E)xamine    (D)eposit    (R)un     (L)oad     (H)elp"
	dc.b	CR,LF,EOT
ldSRecMsg:
    .ascii	"Load S-Record"
	dc.b	CR,LF,EOT
msgInvalidAddress:
    .ascii	"Invalid Address"
	dc.b 	CR,LF,EOT
msgInvalidValue:
    .ascii	"Invalid Value"
	dc.b	CR,LF,EOT
msgPrompt:
	.ascii "> "
    dc.b EOT
msgColonSpace:
    .ascii ": "
    dc.b EOT
msgNewline:
    dc.b CR,LF,EOT
debug_Srec_Typ_Msg:
	.ascii	"S Record Type="
    dc.b EOT
debug_Srec_BytCt_Msg:
	.ascii	"S Record Byte Count="
    dc.b EOT
debug_Srec_CSum_Msg:
	.ascii	"S Record Checksum="
    dc.b EOT
debug_S2rec_Addr_Msg:
	.ascii	"S2 Record Address="
    dc.b EOT
debug_SXrec_Addr_Msg:
	.ascii	"S (not 2) Record Address="
    dc.b EOT
debug_Srec_LDData_Msg:
    .ascii	"Load Data Loop start"
	dc.b 	CR,LF,EOT


MAX_LINE_LENGTH = 80
varLineBuf = RAM_END+1-1024-MAX_LINE_LENGTH-2
varCurAddr = varLineBuf-4

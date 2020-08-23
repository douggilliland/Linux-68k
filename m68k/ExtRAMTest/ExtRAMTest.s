* =======================================================================
* Test the External SRAM on the RETRO-EP4CE15 card
* The RETRO-EP4CE15 card has 1MB of External SRAM
* External SRAM only supports 8-bit accesses
* External SRAM goes from 0x300000 to 0x3FFFFF (1 MB)
* Test checks the physical connections to the SRAM
* Test does not exhaustively check the SRAM itself
* Test takes several seconds with a 25 MHz 68000 CPU
* TUTOR14 uses SRAM from 0x000000 to 0x000800
* =======================================================================

RAMSTART	= 0x300000
RAMEND		= 0x3FFFFF
ACIASTAT	= 0x010041
ACIADATA	= 0x010043

* Code follows

	.ORG    0x001000
* CHECK FIRST LOCATION BY WRITING/READING 0x55/0xAA
* VERY ROUGH CHECK OF DATA LINES
* DATA LINES COULD STILL HAVE SHORTS BUT LESS LIKELY SINCE PINS ARE ADJACENT
STARTTEST:
	MOVE.L  #RAMSTART,%A0
	MOVE.B  #0x55,%D0
	MOVE.B	%D0,(%A0)
    MOVE.B	(%A0),%D1
    CMP.B   %D0,%D1
    BNE     FAIL
	MOVE.B  #0xAA,%D0
	MOVE.B	%D0,(%A0)
    NOP
    MOVE.B	(%A0),%D1
    CMP.B   %D0,%D1
    BNE     FAIL

* BOUNCE A 1 ACROSS THE DATA LINES
* THIS VERIFIES THERE ARE NO SHORTED DATA LINES
* ADDRESS LINES COULD STILL HAVE SHORTS/OPENS
BOUNCE1S:
	MOVE.L  #RAMSTART,%A0
	MOVE.B  #0x01,%D0
NEXTONE:
	MOVE.B	%D0,(%A0)
    MOVE.B  (%A0),%D1
    CMP.B   %D0,%D1
    BNE     FAIL
    ASL.L   #1,%D0
    CMP.B   #0,%D0
    BNE     NEXTONE

* BOUNCE A 0 ACROSS THE DATA LINES
BOUNCE0S:
	MOVE.L  #RAMSTART,%A0
	MOVE.B  #0xFE,%D0
NEXTZERO:
	MOVE.B	%D0,(%A0)
    MOVE.B  (%A0),%D1
    CMP.B   %D0,%D1
    BNE     FAIL
    ASL.L   #0x01,%D0
    ORI.B   #0x01,%D0
    CMP.B   #0XFF,%D0
    BNE     NEXTZERO

* CHECK THE UPPER 8 SRAM ADDRESS LINES (A12..A19 ON SRAM)
* SINCE THERE ARE ONLY 8 DATA LINES THERE CAN ONLY BE 256 UNIQUE DATA PATTERNS
* WRITE AN INCREMENTING VALUE EVERY 4096 BYTES AND VERIFY
    MOVE.B  #0X00,%D0
	MOVE.L  #RAMSTART,%A0
	MOVE.L  #RAMEND+1,%A1
FILL4K:
    MOVE.B  %D0,(%A0)
    ADDI.L  #4096,A0
    CMP.L   %A0,%A1
    BGE.S   DONE4KFL
    ADDI.B  #0x01,%D0
    BRA     FILL4K
DONE4KFL:
    MOVE.B  #0X00,%D0
	MOVE.L  #RAMSTART,%A0
	MOVE.L  #RAMEND+1,%A1
CHK4K:
    MOVE.B  (%A0),%D1
    CMP.B   %D0,%D1
    BNE     FAIL
    ADDI.B  #0x01,%D0
    ADDI.L  #4096,A0
    CMP.L   %A0,%A1
    BGE.S   DONE4K
    BRA     CHK4K
DONE4K:

* CHECK NEXT 4 SRAM ADDRESS LINES (A8..A11 ON SRAM)
* A12-A19 = 0
* WRITE AN INCREMENTING VALUE EVERY 256 BYTES AND VERIFY
* ONLY NEED 16 UNIQUE PATTERNS FOR 4 BITS
    MOVE.B  #0X00,%D0
	MOVE.L  #RAMSTART,%A0
	MOVE.L  #RAMSTART+0x1000,%A1
FILL256:
    MOVE.B  %D0,(%A0)
    ADDI.L  #256,A0
    CMP.L   %A0,%A1
    BGE.S   DONE256F
    ADDI.B  #0x01,%D0
    BRA     FILL256
DONE256F:
    MOVE.B  #0X00,%D0
	MOVE.L  #RAMSTART,%A0
	MOVE.L  #RAMSTART+0x1000,%A1
CHK256:
    MOVE.B  (%A0),%D1
    CMP.B   %D0,%D1
    BNE     FAIL
    ADDI.B  #0x01,%D0
    ADDI.L  #256,A0
    CMP.L   %A0,%A1
    BGE.S   DONE256
    BRA     CHK256
DONE256:

* WRITE INCREMENTING PATTERN TO ALL THE SRAM
* CHECKS THE REMAINING BOTTOM ADDRESSES LINES
* TOKEN EFFORT TO TOUCH ALL LOCATIONS
* MAY NOT DETECT INDIVIDUAL STUCK AT HIGH OR LOW BITS INSIDE SRAM
    MOVE.B  #0X00,%D0
	MOVE.L  #RAMSTART,%A0
	MOVE.L  #RAMEND+1,%A1
CHKALL:
    MOVE.B  %D0,(%A0)+
    CMP.L   %A0,%A1
    BEQ.S   DONEFILL
    ADDI.B  #0x01,%D0
    BRA.S   CHKALL
DONEFILL:
* READ BACK INCREMENTING PATTERN 
    MOVE.B  #0X00,%D0
	MOVE.L  #RAMSTART,%A0
	MOVE.L  #RAMEND+1,%A1
LOOPCHK:
    MOVE.B  (%A0)+,%D1
    CMP.B   %D0,%D1
    BNE     FAIL
    CMP.L   %A0,%A1
    BEQ.S   DONECHK
    ADDI.B  #0x01,%D0
    BRA.S   LOOPCHK
DONECHK:

* PRINT 'Pass'
	MOVE.B	#0x0A,%D0
	JSR     OUTCHAR
	MOVE.B	#0x0D,%D0
	JSR     OUTCHAR
	MOVE.B	#'P',%D0
	JSR     OUTCHAR
	MOVE.B	#'a',%D0
	JSR     OUTCHAR
	MOVE.B	#'s',%D0
	JSR     OUTCHAR
	MOVE.B	#'s',%D0
	JSR     OUTCHAR
    RTS
FAIL:
* PRINT 'Fail'
	MOVE.B	#0x0A,%D0
	JSR     OUTCHAR
	MOVE.B	#0x0D,%D0
	JSR     OUTCHAR
	MOVE.B	#'F',%D0
	JSR     OUTCHAR
	MOVE.B	#'a',%D0
	JSR     OUTCHAR
	MOVE.B	#'i',%D0
	JSR     OUTCHAR
	MOVE.B	#'l',%D0
	JSR     OUTCHAR
	RTS

* OUTPUT A CHARACTER IN D0 TO THE ACIA
OUTCHAR:
    BSR.S   WAITRDY
    LEA     ACIADATA,%A1
	MOVE.B	%D0,(%A1)
    RTS

* WAIT FOR THE SERIAL PORT TO BE READY
WAITRDY:
	LEA     ACIASTAT,%A1
LOOPRDY:
	MOVE.B	(%A1),%D1
	ANDI.B	#0x2,%D1
	BEQ.S   LOOPRDY
    RTS


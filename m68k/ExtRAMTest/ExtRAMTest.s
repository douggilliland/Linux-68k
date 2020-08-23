* Test External SRAM
* External SRAM on the RETRO-EP4CE15 card goes from 0x300000 to 0x3FFFFF (1 MB)
* External SRAM only supports 8-bit accesses
* TUTOR14 uses SRAM from 0x000000 to 0x000800

RAMSTART	= 0X300000
RAMEND		= 0X3FFFFF
ACIASTAT	= 0x010041
ACIADATA	= 0x010043

* Code follows

	.ORG    0x001000
* CHECK FIRST LOCATION BY WRITING/READING 0x55/0xAA
STARTTEST:
	MOVE.L  #0x00300000,%A0
	MOVE.B  #0x55,%D0
	MOVE.B	%D0,(%A0)
    NOP
    MOVE.B	(%A0),%D1
    CMP.B   %D0,%D1
    BNE     FAIL
	MOVE.B  #0xAA,%D0
	MOVE.B	%D0,(%A0)
    NOP
    MOVE.B	(%A0),%D1
    CMP.B   %D0,%D1
    BNE     FAIL
    MOVE.B  #0X01,%D0
	MOVE.L  #0x00300000,%A0
* WRITE INCREMENTING PATTERN TO FIRST BYTE OF EVERY 64K 
CHKBLKS:
    MOVE.B  %D0,(%A0)
    ADD.L   #0x00000001,%A0
    CMP.L   #0x00400000,%A0
    BEQ     DONEFILL
    ADDI.B  #0x01,%D0
    BRA     CHKBLKS
DONEFILL:
* READ BACK INCREMENTING PATTERN FROM FIRST BYTE OF EVERY 64K 
    MOVE.B  #0X01,%D0
	MOVE.L  #0x00300000,%A0
LOOPCHK:
    MOVE.B  (%A0),%D1
    CMP.B   %D0,%D1
    BNE     FAIL
    ADD.L   #0x00000001,%A0
    CMP.L   #0x00400000,%A0
    BEQ     DONECHK
    ADDI.B  #0x01,%D0
    BRA     LOOPCHK
DONECHK:
* PRINT 'OK'
    JSR     WAITRDY
	MOVE.B	#'O',%D0
	JSR     OUTCHAR
	MOVE.B	#'K',%D0
	JSR     OUTCHAR
    RTS
FAIL:
* PRINT 'F'
    JSR     WAITRDY
	MOVE.B	#'F',%D0
	JSR     OUTCHAR
	RTS

* WAIT FOR THE SERIAL PORT TO BE READY
WAITRDY:
	LEA     ACIASTAT,%A1
LOOPRDY:
	MOVE.B	(%A1),%D1
	ANDI.B	#0x2,%D1
	BEQ		LOOPRDY
    RTS

* OUTPUT A CHARACTER IN D0 TO THE ACIA
OUTCHAR:
	LEA     ACIADATA,%A1
	MOVE.B	%D0,(%A1)
    RTS


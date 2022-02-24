// SDCard.c

#define ACIASTAT	(volatile unsigned char *) 0x010041
#define ACIADATA	(volatile unsigned char *) 0x010043
#define VDUSTAT		(volatile unsigned char *) 0x010040
#define VDUDATA		(volatile unsigned char *) 0x010042
#define ACIA_TXRDYBIT 0x2

// SD Card
#define SD_SDDATA_REG	(volatile unsigned char *) 0x010051
#define SD_STATUS_REG	(volatile unsigned char *) 0x010053
#define SD_CMD_REG		(volatile unsigned char *) 0x010053
#define SD_LBA0_REG		(volatile unsigned char *) 0x010055
#define SD_LBA1_REG		(volatile unsigned char *) 0x010057
#define SD_LBA2_REG		(volatile unsigned char *) 0x010059
// SD Card Status Reg
#define SD_WR_RDY		0X80
#define SD_RD_RDY		0X40
#define SD_BLK_BUSY		0X20
#define SD_INIT_BUSY	0X10
// SD Card Control values
#define SD_RD_BLK	0x00
#define SD_WR_BLK	0x01
#define BUFFER_START 0XE000

/*
-- To read a 512-byte block from the SDCARD:
-- Wait until SDSTATUS=0x80 (ensures previous cmd has completed)
-- Write SDLBA0, SDLBA1 SDLBA2 to select block index to read from
-- Write 0 to SDCONTROL to issue read command
-- Loop 512 times:
--	 Wait until SDSTATUS=0xE0 (read byte ready, block busy)
--	 Read byte from SDDATA
--
-- To write a 512-byte block to the SDCARD:
-- Wait until SDSTATUS=0x80 (ensures previous cmd has completed)
-- Write SDLBA0, SDLBA1 SDLBA2 to select block index to write to
-- Write 1 to SDCONTROL to issue write command
-- Loop 512 times:
--	 Wait until SDSTATUS=0xA0 (block busy)
--	 Write byte to SDDATA
*/

// Prototypes
void printCharToACIA(unsigned char);
void printStringToACIA(const char *);
void printCharToVDU(unsigned char);
void printStringToVDU(const char *);
void waitLoop(unsigned int waitTime);
void wait_Until_SD_CMD_Done(void);
void write_SD_LBA(unsigned long);
void readSDBlockToBuffer(void);
void wait_Until_SD_Char_RD_Rdy(void);

// main() - Read first block from the SD card
int main(void)
{
	asm("move.l #0x1000,%sp"); // Set up initial stack pointer

	printStringToVDU("Waiting on SD Card ready\n\r");
	wait_Until_SD_CMD_Done();
	printStringToVDU("SD Card is ready\n\r");
	printStringToVDU("Writing LBA = 0\n\r");
	write_SD_LBA(0);
	printStringToVDU("Reading block\n\r");
	readSDBlockToBuffer();
	printStringToVDU("Block was read to 0xE000\n\r");
	asm("move.b #228,%d7\n\t"
		"trap #14");
	return(0);
}

// readSDBlockToBuffer() - Read a block to a buffer
void readSDBlockToBuffer(void)
{
	unsigned short loopCount = 512;
	unsigned char readSDChar;
	unsigned char * destAddr;
	destAddr = (unsigned long) BUFFER_START;
	* SD_CMD_REG = SD_RD_BLK;
	while (loopCount > 0)
	{
		wait_Until_SD_Char_RD_Rdy();
		readSDChar = *SD_SDDATA_REG;
		*destAddr++ = readSDChar;
		loopCount--;
	}
}

// write_SD_LBA(unsigned long lba)
// lba - Logical Block Address
// Set the Logical Block Address (LBA)
void write_SD_LBA(unsigned long lba)
{
	unsigned char lba0, lba1, lba2;
	lba0 = lba & 0xff;
	lba1 = (lba >> 8) & 0xff;
	lba2 = (lba >> 16) & 0xff;
	* SD_LBA0_REG = lba0;
	* SD_LBA1_REG = lba1;
	* SD_LBA2_REG = lba2;
}

// wait_Until_SD_Char_RD_Rdy()
// Wait until the SD Card read data is present
void wait_Until_SD_Char_RD_Rdy(void)
{
	unsigned char charStat;
	charStat = * SD_STATUS_REG;
	while (charStat != 0xE0)
	{
		charStat = *SD_STATUS_REG;
	}
}

// wait_Until_SD_CMD_Done()
// Wait for card ready before doing any reading
void wait_Until_SD_CMD_Done(void)
{
	unsigned char charStat;
	charStat = * SD_STATUS_REG;
	while (charStat != 0x80)
	{
		charStat = *SD_STATUS_REG;
	}
}


void waitLoop(unsigned int waitTime)
{
	volatile unsigned int timeCount = 0;
	for (timeCount = 0; timeCount < waitTime; timeCount++);
}

void printCharToACIA(unsigned char charToPrint)
{
	while ((*ACIASTAT & ACIA_TXRDYBIT) != ACIA_TXRDYBIT);
	* ACIADATA = charToPrint;
}

void printStringToACIA(const char * strToPrint)
{
	int strOff = 0;
	while(strToPrint[strOff] != 0)
		printCharToACIA(strToPrint[strOff++]);
}

void printCharToVDU(unsigned char charToPrint)
{
	while ((*VDUSTAT & ACIA_TXRDYBIT) != ACIA_TXRDYBIT);
	* VDUDATA = charToPrint;
}

void printStringToVDU(const char * strToPrint)
{
	int strOff = 0;
	while(strToPrint[strOff] != 0)
		printCharToVDU(strToPrint[strOff++]);
}

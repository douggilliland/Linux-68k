// testser.c

#define ACIASTAT	(volatile unsigned char *) 0x010041
#define ACIADATA	(volatile unsigned char *) 0x010043
#define VDUSTAT		(volatile unsigned char *) 0x010040
#define VDUDATA		(volatile unsigned char *) 0x010042
#define TXRDYBIT	0x2
#define RXFULLBIT	0x1

// Prototypes
void printCharToACIA(unsigned char);
void printStringToACIA(const char *);
unsigned char getCharACIA(void);
void printCharToVDU(unsigned char);
void printStringToVDU(const char *);
unsigned char getCharVDU(void);
void wait(unsigned int waitTime);

int main(void)
{
    asm("move.l #0x1000,%sp"); // Set up initial stack pointer

	printStringToACIA("Test String to serial\n\r");
	printStringToVDU("Test String to VDU\n\r");
    wait(10000);
    asm("move.b #228,%d7\n\t"
        "trap #14");
    return(0);
}

unsigned char getCharVDU(void)
{
	while ((*VDUSTAT & RXFULLBIT) != RXFULLBIT);
	return(* ACIADATA);
}

unsigned char getCharACIA(void)
{
	while ((*ACIASTAT & RXFULLBIT) != RXFULLBIT);
	return(* VDUDATA);
}

void wait(unsigned int waitTime)
{
    volatile unsigned int timeCount = 0;
    for (timeCount = 0; timeCount < waitTime; timeCount++);
}

void printCharToACIA(unsigned char charToPrint)
{
	while ((*ACIASTAT & TXRDYBIT) != TXRDYBIT);
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
	while ((*VDUSTAT & TXRDYBIT) != TXRDYBIT);
	* VDUDATA = charToPrint;
}

void printStringToVDU(const char * strToPrint)
{
    int strOff = 0;
    while(strToPrint[strOff] != 0)
        printCharToVDU(strToPrint[strOff++]);
}

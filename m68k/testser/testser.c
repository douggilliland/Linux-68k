// testser.c

#define ACIASTAT	(volatile unsigned char *) 0x010041
#define ACIADATA	(volatile unsigned char *) 0x010043
#define VDUSTAT		(volatile unsigned char *) 0x010040
#define VDUDATA		(volatile unsigned char *) 0x010042
#define TXRDYBIT 0x2

// Prototypes
void printCharToACIA(unsigned char);
void printStringToACIA(const char *);

void _start(void)
{
	printStringToACIA("Test String");
}

void printCharToACIA(unsigned char charToPrint)
{
	while ((*ACIASTAT & TXRDYBIT) == 0x0);
	* ACIADATA = charToPrint;
}

void printStringToACIA(const char * strToPrint)
{
    int strOff = 0;
    while(strToPrint[strOff] != 0)
        printCharToACIA(strToPrint[strOff]);
}

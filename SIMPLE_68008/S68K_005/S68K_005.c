/* S68K_005 */

#include "SIMPLE_68008.h"

/* Function Prototypes go here for compiler warning purposes */

void wait1Sec(void);
void setLED(unsigned char LEDVal);
char getCharA(void);
char getCharB(void);
void putCharA(char);
void putCharB(char);
void printString(char * pStr);
int strlen(char *);
int getString(char *);

int main(void)
{
	unsigned int lenStr;
	char rxChar;
	char inStr[80];
	unsigned char * DUART_OPC = (unsigned char *) DUART_OPC_ADR;	/* Output port config (W)	*/
	*DUART_OPC = (char) 0x0;
	
	printString("Turn on LED for a second\n\r");
	setLED(1);
	lenStr = getString(inStr);
	printString("\n\r");
	wait1Sec();
	setLED(0);
	if (lenStr > 0)
		printString("String non-zero length\n\r");
	else
		printString("String was zero length\n\r");
	printString(inStr);
	printString("\n\r");
	while (1)
	{
		rxChar = getCharA();
		putCharA(rxChar);
	}
}

int getString(char * strPtr)
{
	int strLen = 0;
	char rxChar;
	int endFlag = 0;
	while (endFlag == 0)
	{
		rxChar = getCharA();
		*strPtr = rxChar;
		strPtr += 1;
		strLen += 1;
		endFlag = 0;
		if (strLen > 78)
			endFlag = 1;
		else if (rxChar == '\n')
			endFlag = 1;
		else if (rxChar == '\r')
			endFlag = 1;
		putCharA(rxChar);
	}
	*strPtr = 0;
	return strLen;
}

void printString(char * pStr)
{
	for (unsigned int cc = 0; cc < strlen(pStr); cc++)
		putCharA(pStr[cc]);
}

int strlen(char * strToMeasure)
{
	int ct = 0;
	while (strToMeasure[ct] != 0)
		ct += 1;
	return ct;
}

void setLED(unsigned char LEDVal)
{
	unsigned char * DUART_OPS = (unsigned char *) DUART_OPS_ADR;	/* Output port Set (W)		*/
	unsigned char * DUART_OPR = (unsigned char *) DUART_OPR_ADR;	/* Output port Clear (W)	*/
	if (LEDVal == 0)
		*DUART_OPS = 0x04;
	else
		*DUART_OPR = 0x04;
}

void wait1Sec(void)
{
	unsigned long loopCt = 50000;
	while (loopCt > 0)
		loopCt -= 1;
}

char getCharA(void)
{
	unsigned char * DUART_SRA = (unsigned char *) DUART_SRA_ADR;
	unsigned char * DUART_RBA = (unsigned char *) DUART_RBA_ADR;
	unsigned char stat = 0;
	while (stat == 0)
	{
		stat = *DUART_SRA;
		stat &= 1;
	}
	return (*DUART_RBA);
}

char getCharB(void)
{
	unsigned char * DUART_SRB = (unsigned char *) DUART_SRB_ADR;
	unsigned char * DUART_RBB = (unsigned char *) DUART_RBB_ADR;
	unsigned char stat = 0;
	while (stat == 0)
	{
		stat = *DUART_SRB;
		stat &= 1;
	}
	return (*DUART_RBB);
}

void putCharA(char outChar)
{
	unsigned char * DUART_SRA = (unsigned char *) DUART_SRA_ADR;
	unsigned char * DUART_TBA = (unsigned char *) DUART_TBA_ADR;
	char stat = 0;
	while (stat == 0)
	{
		stat = *DUART_SRA;
		stat &= 4;
	}
	*DUART_TBA = outChar;
}

void putCharB(char outChar)
{
	unsigned char * DUART_SRB = (unsigned char *) DUART_SRB_ADR;
	unsigned char * DUART_TBB = (unsigned char *) DUART_TBB_ADR;
	char stat = 0;
	while (stat == 0)
	{
		stat = *DUART_SRB;
		stat &= 4;
	}
	*DUART_TBB = outChar;
}

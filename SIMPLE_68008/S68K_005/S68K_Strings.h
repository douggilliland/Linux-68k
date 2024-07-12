/* S68K_Strings.h	*/

#include "SIMPLE_68008.h"

#ifndef S68K_STRINGS_h

#include "SIMPLE_68008.h"

/* Function Prototypes go here for compiler warning purposes */

void wait1Sec(void);
void setLED(unsigned char LEDVal);
int strlen(char *);
int getString(char *);
void printString(char * pStr);
int isStrNum(char *);
int strToNum(char *);
void intToStr(int, char*);
char getCharA(void);
char getCharB(void);
void putCharA(char);
void putCharB(char);

int main(void)
{
	int lenStr;
	char rxChar;
	char inStr[80];
	int iRtn;
	unsigned char * DUART_OPC = (unsigned char *) DUART_OPC_ADR;	/* Output port config (W)	*/
	*DUART_OPC = 0x0;
	
	printString("Turn on LED for a second\n\r");
	setLED(1);
	printString("Type a string\n\r");
	lenStr = getString(inStr);
	printString("\n\r");
	setLED(0);
	if (lenStr > 0)
		printString("String non-zero length\n\r");
	else
		printString("String was zero length\n\r");
	printString(inStr);
	printString("\n\r");
	wait1Sec();
	printString("Test String to number\n\r");
	iRtn = strToNum("12345");
	if (iRtn == 12345)
		printString("string to number = OK\n\r");
	else
		printString("str to num BAD\n\r");
	intToStr(123456, inStr);
	printString(inStr);
	while (1)
	{
		rxChar = getCharA();
		putCharA(rxChar);
	}
}

void intToStr(int num, char* str)
{
    int i = 0;
    int is_negative = 0;
    
    if (num < 0)
	{
        is_negative = 1;
        num = -num;
    }
    
    do 
	{
        str[i++] = num % 10 + '0';
        num /= 10;
    } while (num > 0);
    
    if (is_negative) 
	{
        str[i++] = '-';
    }
    str[i] = '\0';
    
    int j = 0;
    while (j < i/2) 
	{
        char temp = str[j];
        str[j] = str[i-j-1];
        str[i-j-1] = temp;
        j++;
    }
}

int strToNum(char * pStr)
{
	int numRtn = 0;
	int offset;
	if (isStrNum(pStr) == 0)
		return numRtn;
	for (offset = 0; offset < strlen(pStr); offset++)
	{
		numRtn = numRtn * 10;
		numRtn += (pStr[offset] - '0');
	}
	return numRtn;
}

int isStrNum(char * strPtr)
{
	int offset;
	int len;
	len = strlen(strPtr);
	for (offset=0; offset<len; offset++)
	{
		if (strPtr[offset] > '9')
			return 0;
		if (strPtr[offset] < '0')
			return 0;
	}
	return 1;
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

#else
#define S68K_STRINGS_h
#endif

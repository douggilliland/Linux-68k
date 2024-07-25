/* S68K_Strings.h	*/

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
void printInt(int);

void printInt(int num)
{
	char inStr[80];
	intToStr(num, inStr);
	printString(inStr);
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
		strLen += 1;
		endFlag = 0;
		if (strLen > 78)
			endFlag = 1;
		else if (rxChar == '\n')
		{
			*strPtr = 0;
			endFlag = 1;
		}
		else if (rxChar == '\r')
		{
			*strPtr = 0;
			endFlag = 1;
		}
		else
		{
			putCharA(rxChar);
			strPtr += 1;
		}
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

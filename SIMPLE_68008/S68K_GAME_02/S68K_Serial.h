/* S68K_Serial.h */
#ifndef S68K_SERIAL_h

#include "SIMPLE_68008.h"

/* Function Prototypes go here for compiler warning purposes */

char getCharA(void);
char getCharB(void);
void putCharA(char);
void putCharB(char);
int makeSeedFromKeyWait(void);

int makeSeedFromKeyWait(void)
{
	unsigned char * DUART_SRA = (unsigned char *) DUART_SRA_ADR;
	int seedCount = 0;
	unsigned char stat = 0;
	while (stat == 0)
	{
		stat = *DUART_SRA;
		stat &= 1;
		seedCount += 1;
	}
	seedCount += *DUART_RBA;
	return(seedCount);
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

#else
#define S68K_SERIAL_h
#endif

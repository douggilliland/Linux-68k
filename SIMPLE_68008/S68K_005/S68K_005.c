/* S68K_005 */

#include "SIMPLE_68008.h"

void wait1Sec(void);
void setLED(unsigned char LEDVal);
unsigned char getCharA(void);
unsigned char getCharB(void);
unsigned char putCharA(void);
unsigned char putCharB(void);

int main(void)
{
	unsigned char rxChar;
	unsigned char * DUART_SRA = (unsigned char *) DUART_SRA_ADR;
	unsigned char * DUART_SRB = (unsigned char *) DUART_SRB_ADR;
	unsigned char * DUART_RBA = (unsigned char *) DUART_RBA_ADR;
	unsigned char * DUART_RBB = (unsigned char *) DUART_RBB_ADR;
	unsigned char * DUART_TBA = (unsigned char *) DUART_TBA_ADR;
	unsigned char * DUART_TBB = (unsigned char *) DUART_TBB_ADR;
	unsigned char * DUART_OPC = (unsigned char *) DUART_OPC_ADR;	/* Output port config (W)	*/
	*DUART_OPC = (char) 0x0;

	while (1)
	{
		setLED(1);
		rxChar = getCharA();
		setLED(0);
		wait1Sec();
		putCharA(rxChar);
	}
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

unsigned char getCharA(void)
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

unsigned char getCharB(void)
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

unsigned char putCharA(unsigned char outChar)
{
	unsigned char * DUART_SRA = (unsigned char *) DUART_SRA_ADR;
	unsigned char * DUART_TBA = (unsigned char *) DUART_TBA_ADR;
	unsigned char stat = 0;
	while (stat == 0)
	{
		stat = *DUART_SRA;
		stat &= 4;
	}
	*DUART_TBA = outChar;
}

unsigned char putCharB(unsigned char outChar)
{
	unsigned char * DUART_SRB = (unsigned char *) DUART_SRB_ADR;
	unsigned char * DUART_TBB = (unsigned char *) DUART_TBB_ADR;
	unsigned char stat = 0;
	while (stat == 0)
	{
		stat = *DUART_SRB;
		stat &= 4;
	}
	*DUART_TBB = outChar;
}

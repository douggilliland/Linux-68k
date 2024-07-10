/* S68K_005 */

#include "SIMPLE_68008.h"

void wait1Sec(void);

int main(void)
{
	unsigned char * DUART_OPC = (unsigned char *) DUART_OPC_ADR;	/* Output port config (W)	*/
	unsigned char * DUART_OPS = (unsigned char *) DUART_OPS_ADR;	/* Output port Set (W)		*/
	unsigned char * DUART_OPR = (unsigned char *) DUART_OPR_ADR;	/* Output port Clear (W)	*/
	
	*DUART_OPC = (char) 0x00;
	*DUART_OPR = (char) 0xFC;
	
	while (1)
	{
		wait1Sec();
		*DUART_OPS = (char) 0x04;
		wait1Sec();
		*DUART_OPR = (char) 0x04;
	}
}

void wait1Sec(void)
{
	unsigned long loopCt = 50000;
	while (loopCt > 0)
		loopCt -= 1;
}

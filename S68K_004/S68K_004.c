/* */

void wait1Sec(void);

int main(void)
{
	unsigned char * DUART_BASE;
	unsigned char * DUART_OPC;
	unsigned char * DUART_OPS;
	unsigned char * DUART_OPR;
	DUART_BASE = (unsigned char *) 0x0F0000; 	/* Base Addr of DUART		*/
	DUART_OPC  = (unsigned char *) 0x0F0026;	/* Output port config (W)	*/
	DUART_OPS  = (unsigned char *) 0x0F0028;  /* Output port Set (W)		*/
	DUART_OPR  = (unsigned char *) 0x0F0030;  /* Output port Clear (W)	*/
	
	*DUART_OPC = (char) 0x00;
	*DUART_OPR = (char) 0xFC;
	*DUART_OPS = (char) 0x04;
	
	while (1)
	{
		wait1Sec();
		*DUART_OPR = (char) 0xFC;
		wait1Sec();
		*DUART_OPS = (char) 0xFC;
	}
}

void wait1Sec(void)
{
	unsigned long loopCt;
	loopCt = 0x100000;
	while (loopCt > 0)
		loopCt--;
}

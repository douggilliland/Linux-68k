/* */

void wait1Sec(void);

int main(void)
{
	unsigned char * DUART_OPC;
	unsigned char * DUART_OPS;
	unsigned char * DUART_OPR;
	DUART_OPC  = (unsigned char *) 0x0F001A;	/* Output port config (W)	*/
	DUART_OPS  = (unsigned char *) 0x0F001C;	/* Output port Set (W)		*/
	DUART_OPR  = (unsigned char *) 0x0F001E;	/* Output port Clear (W)	*/
	
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
	unsigned long loopCt = 1000;
	while (loopCt > 0)
		loopCt -= 1;
}

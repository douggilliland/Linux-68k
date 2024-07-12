/* S68K_005 */
/* My weird way of using the #includes at the end of the file	*/

#include "SIMPLE_68008.h"
#include "main.h"

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

#include "S68K_Serial.h"
#include "S68K_Strings.h"

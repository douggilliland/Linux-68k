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
	
	printString("Guess a number from 1 to 99\n\r");
	lenStr = getString(inStr);
	iRtn = strToNum(inStr);
	if (iRtn > 500)
		printString("Number is too high\n\r");
	else if (iRtn < 500)
		printString("Number is too low\n\r");
	else
		printString("Good job, you got it\n\r");
}

#include "S68K_Serial.h"
#include "S68K_Strings.h"

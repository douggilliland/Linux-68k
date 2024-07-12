/* S68K_005 */
/* My weird way of using the #includes at the end of the file	*/

#include "SIMPLE_68008.h"
#include "main.h"

int main(void)
{
	char inStr[80];
	int iRtn;	
	printString("Guess a number from 1 to 99\n\r");
	while (1)
	{
		getString(inStr);
		iRtn = strToNum(inStr);
		if (iRtn > 50)
			printString("Number is too high\n\r");
		else if (iRtn == 0)
			{
			printString("Zero is bad\n\r");
			return 0;
			}
		else if (iRtn < 50)
			printString("Number is too low\n\r");
		else
		{
			printString("Good job, you got it\n\r");
			return 0;
		}
	}
}


#include "S68K_Serial.h"
#include "S68K_Strings.h"

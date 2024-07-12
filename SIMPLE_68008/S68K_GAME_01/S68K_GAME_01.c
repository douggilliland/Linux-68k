/* S68K_005 */
/* My weird way of using the #includes at the end of the file	*/

#include "SIMPLE_68008.h"
#include "main.h"

int main(void)
{
	char inStr[80];
	int iRtn;
	int guessCt = 0;
	printString("Guess a number from 1 to 99\n\r");
	while (1)
	{
		getString(inStr);
		printString("You entered ");
		printString(inStr);
		printString(" as a string\n\r");
		iRtn = strToNum(inStr);
		if (iRtn > 50)
			printString("Number is too high\n\r");
		else if (iRtn < 50)
			printString("Number is too low\n\r");
		else
		{
			printString("Good job, you got it\n\r");
			return 0;
		}
		guessCt += 1;
		printString("Guess #");
		intToStr(guessCt, inStr);
		printString(inStr);
	}
}


#include "S68K_Serial.h"
#include "S68K_Strings.h"

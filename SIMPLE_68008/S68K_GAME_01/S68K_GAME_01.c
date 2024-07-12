/* S68K_GAME_01.c */
/* My weird way of using the #includes at the end of the file	*/

#include "SIMPLE_68008.h"

#include "main.h"

int main(void)
{
	return(playGame());
}

#include "S68K_Serial.h"
#include "S68K_Strings.h"

int playGame(void)
{
	char inStr[80];
	int iRtn;
	int guessCt = 1;
	printString("Guess a number from 1 to 99\n\r");
	while (1)
	{
		printString("Guess #");
		intToStr(guessCt, inStr);
		printString(inStr);
		printString("\n\r");
		getString(inStr);
		printString("\n\r");
		iRtn = strToNum(inStr);
		if (iRtn > 50)
			printString("Number is too high\n\r");
		else if (iRtn < 50)
			printString("Number is too low\n\r");
		else
		{
			printString("Good job, you got it in ");
			intToStr(guessCt, inStr);
			printString(inStr);
			printString(" tries\n\r");
			return 0;
		}
		guessCt += 1;
	}
}

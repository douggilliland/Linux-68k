/* S68K_GAME_01.c 									*/
/* First Game for the SIMPLE-68008					*/
/* Number guessing game								*/

#include "SIMPLE_68008.h"
#include "main.h"

/* Putting main() here before defines 
to make sure we know that main() is at first address */

int main(void)
{
	return(playGame());
}

/* These includes have card specific code			*/
/* Make some standardized library calls				*/
#include "S68K_Serial.h"
#include "S68K_Strings.h"

int playGame(void)
{
	char inStr[80];
	int iRtn;
	int guessCt = 1;
	printString("Guess a number from 1 to 99\n\r");
	int randomSeed;
	int randomNumber;
	printString("Hit a key to create random number\n\r");
	randomSeed = makeSeedFromKeyWait();
	randomNumber = randomSeed % 100;
	printString("\n\r");
	while (1)
	{
		printString("Guess #");
		intToStr(guessCt, inStr);
		printString(inStr);
		printString("\n\r");
		getString(inStr);
		printString("\n\r");
		iRtn = strToNum(inStr);
		if (iRtn > randomNumber)
			printString("Number is too high\n\r");
		else if (iRtn < randomNumber)
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

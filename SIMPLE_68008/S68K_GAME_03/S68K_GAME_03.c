/* S68K_GAME_03.c 									*/
/* First Game for the SIMPLE-68008					*/
/* Number guessing game								*/

#include "../S68K_clibs/SIMPLE_68008.h"
#include "main.h"

/* Putting main() here before defines 
to make sure we know that main() is at first address */

/* Function prototypes		*/

int playGame(void);

int main(void)
{
	return(playGame());
}

/* These includes have card specific code			*/
/* Make some standardized library calls				*/
#include "../S68K_clibs/S68K_Serial.h"
#include "../S68K_clibs/S68K_Strings.h"
#include "../S68K_clibs/S68K_nncurses.h"

/*
char screenBuffer[128][32];
char fromBuffer[128][32];
*/

int playGame(void)
{
	int xCurr, yCurr;
	char charCurr;
	init_nncurses();
	for (xCurr = 1; xCurr <= 80; xCurr++)
		for (yCurr = 1; yCurr <= 25; yCurr++)
			for (charCurr = 'A'; charCurr <= 'Z'; charCurr++)
			{
				fromBuffer[xCurr][yCurr] = charCurr;
				copy_ScreenBuffer_Deltas_to_Screen();
			}
	getCharA();
	return 1;
}

/* S68K_GAME_03.c 									*/

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
/* YBD = Make some standardized library calls		*/
#include "../S68K_clibs/S68K_Serial.h"
#include "../S68K_clibs/S68K_Strings.h"
#include "../S68K_clibs/S68K_nncurses.h"

/*
char screenBuffer[32][128];
char fromBuffer[32][128];
*/

int playGame(void)
{
	int xCurr, yCurr;
	char charCurr;
	init_nncurses();
	for (yCurr = 1; yCurr <= 25; yCurr++)
		for (xCurr = 1; xCurr <= 80; xCurr++)
			for (charCurr = 'A'; charCurr <= 'Z'; charCurr++)
			{
				fromBuffer[yCurr][xCurr] = charCurr;
				copy_ScreenBuffer_Deltas_to_Screen();
			}
	while (rxStatPortA() == 0);
	getCharA();
	return 1;
}

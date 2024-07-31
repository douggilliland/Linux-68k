/* S68K_GAME_04.c 									*/

#include "../S68K_clibs/SIMPLE_68008.h"
#include "main.h"

/* Putting main() here before defines 
to make sure we know that main() is at first address */

/* Function prototypes		*/

int playGame(void);
int getKeyboard(void);

int main(void)
{
	return(playGame());
}

/* These includes have card specific code			*/
/* TBD = Make some standardized library calls		*/
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
	char gotKBVal;
	int exitCode = 0;
	init_nncurses();
	
	xCurr = 40;
	yCurr = 12;
	fromBuffer[yCurr][xCurr] = '*';
	copy_ScreenBuffer_Deltas_to_Screen();
	
	while (exitCode == 0)
	{
		gotKBVal = getKeyboard();
		if (gotKBVal == 0)
		{
			exitCode = 1;
		}
		else if (gotKBVal == 1)		/* UP	*/
		{
			fromBuffer[yCurr][xCurr] = ' ';
			yCurr -= 1;
			if (yCurr == 0)
				yCurr = 1;
			fromBuffer[yCurr][xCurr] = '*';
			copy_ScreenBuffer_Deltas_to_Screen();
		}
		else if (gotKBVal == 2)		/* DN	*/
		{
			fromBuffer[yCurr][xCurr] = ' ';
			yCurr += 1;
			if (yCurr > 25)
				yCurr = 25;
			fromBuffer[yCurr][xCurr] = '*';
			copy_ScreenBuffer_Deltas_to_Screen();
		}
		else if (gotKBVal == 3)		/* RT	*/
		{
			fromBuffer[yCurr][xCurr] = ' ';
			xCurr += 1;
			if (xCurr == 81)
				xCurr = 80;
			fromBuffer[yCurr][xCurr] = '*';
			copy_ScreenBuffer_Deltas_to_Screen();
		}
		else if (gotKBVal == 4)		/* LT	*/
		{
			fromBuffer[yCurr][xCurr] = ' ';
			xCurr -= 1;
			if (xCurr == 0)
				xCurr = 1;
			fromBuffer[yCurr][xCurr] = '*';
			copy_ScreenBuffer_Deltas_to_Screen();
		}
	}
	return 1;
}

int getKeyboard(void)
{
	char kbChar;
	int gotEsc = 0;
	kbChar = getCharA();
	if (kbChar == 'q')
		return 0;
	if (kbChar == 'Q')
		return 0;
	if (kbChar == 0x1B)
	{
		kbChar = getCharA();
		if (kbChar == '[')
		{
			kbChar = getCharA();
			if (kbChar == 'A')		/* UP		*/
				return 1;
			if (kbChar == 'B')		/* DN		*/
				return 2;
			if (kbChar == 'C')		/* RT		*/
				return 3;
			if (kbChar == 'D')		/* LT		*/
				return 4;
		}
	}
	return 5;
}

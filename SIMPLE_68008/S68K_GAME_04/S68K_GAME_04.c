/* S68K_GAME_04.c 									*/

#include "../S68K_clibs/SIMPLE_68008.h"
#include "main.h"

/* Putting main() here before defines 
to make sure we know that main() is at first address */

/* Write to fromBuffer[yCurr][xCurr]
When done writing, use copy_ScreenBuffer_Deltas_to_Screen() to update the screen */

/* Function prototypes		*/

int playGame(void);
int getKeyboard(void);
int randomNum(int, int);
int readTimer(void);
void drawFrame(void);

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
	int rv;
	char randoStr[9];
//	char charCurr;
	char gotKBVal;
	int exitCode = 0;
	init_nncurses();
	drawFrame();
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
			if (yCurr == 1)
				yCurr = 2;
			fromBuffer[yCurr][xCurr] = '*';
			copy_ScreenBuffer_Deltas_to_Screen();
		}
		else if (gotKBVal == 2)		/* DN	*/
		{
			fromBuffer[yCurr][xCurr] = ' ';
			yCurr += 1;
			if (yCurr > 23)
				yCurr = 23;
			fromBuffer[yCurr][xCurr] = '*';
			copy_ScreenBuffer_Deltas_to_Screen();
		}
		else if (gotKBVal == 3)		/* RT	*/
		{
			fromBuffer[yCurr][xCurr] = ' ';
			xCurr += 1;
			if (xCurr == 80)
				xCurr = 79;
			fromBuffer[yCurr][xCurr] = '*';
			copy_ScreenBuffer_Deltas_to_Screen();
		}
		else if (gotKBVal == 4)		/* LT	*/
		{
			fromBuffer[yCurr][xCurr] = ' ';
			xCurr -= 1;
			if (xCurr == 1)
				xCurr = 2;
			fromBuffer[yCurr][xCurr] = '*';
			copy_ScreenBuffer_Deltas_to_Screen();
		}
	rv = randomNum(2,79);
	intToStr(rv,randoStr);
	stringToScreen(40,25,randoStr);
		
	}
	cls();
	return 1;
}

void drawFrame(void)
{
	int xCurr, yCurr;
	yCurr = 1;
	for (xCurr = 1; xCurr <= 80; xCurr++)
		fromBuffer[yCurr][xCurr] =  '#';
	yCurr = 24;
	for (xCurr = 1; xCurr <= 80; xCurr++)
		fromBuffer[yCurr][xCurr] =  '#';
	xCurr = 1;
	for (yCurr = 2; yCurr < 25; yCurr++)
		fromBuffer[yCurr][xCurr] =  '#';
	xCurr = 80;
	for (yCurr = 2; yCurr < 25; yCurr++)
		fromBuffer[yCurr][xCurr] =  '#';
	stringToScreen(1,25,"Arrow keys to move, Q to quit");
}

int getKeyboard(void)
{
	char kbChar;
//	int gotEsc = 0;
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

int randomNum(int rangeLow, int rangeHigh)
{
	unsigned long timerVal;
	int retVal;
	timerVal = readTimer();
	retVal = timerVal % (rangeHigh - rangeLow);
	retVal += rangeLow;
	return (retVal);
}

int readTimer(void)
{
	unsigned long * longPtr;
	unsigned long timerVal;
	longPtr = (unsigned long *) 0x408;
	timerVal = *longPtr;
	return ((int)timerVal);
}

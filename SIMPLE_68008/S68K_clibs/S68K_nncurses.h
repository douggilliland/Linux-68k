/* S68K_nncurses.h
Not ncurses but similar
https://raw.githubusercontent.com/mirror/ncurses/master/doc/ncurses-intro.doc */

/* Assumption - Performance is Serial I/O bound
*/

/* Always need to call init_nncurses()		*/

#ifndef S68K_NNCURSES_h
#include "SIMPLE_68008.h"

/* Function Prototypes go here for compiler warning suppression purposes */

void cls(void);
void cursorOnOff(int);
void init_nncurses(void);
void cursorOnOff(int curFlag);
void positionCursorScreen(int x, int y);
void copy_ScreenBuffer_Deltas_to_Screen(void);
void stringToScreen(int , int, char *);
void charToScreen(int, int, char);
char getCharAtXY(int, int);

#define ESC 0x1B

/* Globals go here */

char screenBuffer[32+1][128+1]; /* [row][col]	*/
char fromBuffer[32+1][128+1];

int screenWidth;
int screenHeight;

/* Functions go here */

void init_nncurses(void)
{
	/* TBD - add code to interrogate screen size	*/
	/* For now just assume 80x25					*/
	screenWidth = 80;
	screenHeight = 25;
	int xPos, yPos;
	/* Fill the buffers with spaces					*/
	for (yPos = 0; yPos <= screenHeight; yPos++)
		for (xPos = 0; xPos <= screenWidth; xPos++)
		{
			screenBuffer[yPos][xPos] = ' ';
			fromBuffer[yPos][xPos] = ' ';
		}
	cls();
	/* cursorOnOff(0); */
}

/*	Get the value at a location */
char getCharAtXY(int xPos, int yPos)
{
	return (screenBuffer[yPos][xPos]);
}

/* Screen access functions follow	*/

/* \033[2J - clear the entire screen	*/
void cls(void)
{
		putCharA(ESC);
		putCharA('[');
		putCharA('2');
		putCharA('J');
}

void stringToScreen(int xStart, int yStart, char * strToPrint)
{
	int strOff = 0;
	positionCursorScreen(xStart, yStart);
	while (strToPrint[strOff] != 0)
	{
		putCharA(strToPrint[strOff]);
		strOff += 1;
	}
}
/* 
Hide the cursor: 0x9B 0x3F 0x32 0x35 0x6C
Show the cursor: 0x9B 0x3F 0x32 0x35 0x68
*/
void cursorOnOff(int curFlag)
{
	if (curFlag == 0)
	{
		putCharA(0x9B);
		putCharA(0x3F);
		putCharA(0x32);
		putCharA(0x35);
		putCharA(0x6C);
	}
	else
	{
		putCharA(0x9B);
		putCharA(0x3F);
		putCharA(0x32);
		putCharA(0x35);
		putCharA(0x6B);
	}
}

/* \033[row;colH position cursor */
void positionCursorScreen(int x, int y)
{
	char buff[4];
	putCharA(ESC);
	putCharA('[');
	intToStr(y, buff);
	printString(buff);
	putCharA(';');
	intToStr(x, buff);
	printString(buff);
	putCharA('H');
}

/* copy_ScreenBuffer_Deltas_to_Screen() 
Iterate over the screen buffers.
Compare the fromBuffer to the screenBuffer
If the characters are different send the character to the terminal 
	and update the screenBuffer
*/
void copy_ScreenBuffer_Deltas_to_Screen(void)
{
	int xPos;
	int yPos;
	for (yPos = 1; yPos <= screenHeight; yPos++)
		for (xPos = 1; xPos <= screenWidth; xPos++)
		{
			if (fromBuffer[yPos][xPos] != screenBuffer[yPos][xPos])
			{
				charToScreen(xPos, yPos, fromBuffer[yPos][xPos]);
				screenBuffer[yPos][xPos] = fromBuffer[yPos][xPos];
			}
		}
}

void charToScreen(int x, int y, char sendChar)
{
	positionCursorScreen(x, y);
	putCharA(sendChar);
}

#else
#define S68K_NNCURSES_h
#endif

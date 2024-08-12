/* S68K_GAME_06.c 									*/

#include "../S68K_clibs/SIMPLE_68008.h"
#include "main.h"

/* Putting main() here before defines 
to make sure we know that main() is at first address */

/* Write to fromBuffer[yCurr][xCurr]
When done writing, use copy_ScreenBuffer_Deltas_to_Screen() to update the screen */

enum KBVALS
{
	QUIT,UP,DOWN,RIGHT,LEFT,FIRE,UNKN_KEY
} ;

/* Function prototypes		*/

int playGame(void);
enum KBVALS getKeyboard(void);
int randomNum(int, int);
int readTimer(void);
void drawFrame(void);
void explosion(int, int);

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
	int xShooter = 5;
	int	yShooter = 12;
	int xShooterMin = 2;
	int xShooterMax = 10;
	int yShooterMin = 2;
	int yShooterMax = 23;
	int xTarget = 60;
	int yTarget = 12;
	int xTargetMin = 30;
	int xTargetMax = 78;
	int yTargetMin = 2;
	int yTargetMax = 23;
	int bulletX = 6;
	int bulletY = 12;
	int bulletActive = 0;
	int exitCode = 0;
	enum KBVALS gotKBVal;
	init_nncurses();
	drawFrame();
	positionCursorScreen(xShooter, yShooter);
	putCharA('}');
	positionCursorScreen(xTarget, yTarget);
	putCharA('@');
	positionCursorScreen(40, 25);
	copy_ScreenBuffer_Deltas_to_Screen();
	
	while (exitCode == 0)
	{
		if (rxStatPortA() == 1)
		{
			gotKBVal = getKeyboard();
			if (gotKBVal == QUIT)
			{
				exitCode = 1;
			}
			else if (gotKBVal == UP)
			{
				positionCursorScreen(xShooter, yShooter);
				putCharA(' ');
				yShooter -= 1;
				if (yShooter < yShooterMin)
					yShooter = yShooterMin;
				positionCursorScreen(xShooter, yShooter);
				putCharA('}');
				copy_ScreenBuffer_Deltas_to_Screen();
			}
			else if (gotKBVal == DOWN)
			{
				positionCursorScreen(xShooter, yShooter);
				putCharA(' ');
				yShooter += 1;
				if (yShooter > yShooterMax)
					yShooter = yShooterMax;
				positionCursorScreen(xShooter, yShooter);
				putCharA('}');
				copy_ScreenBuffer_Deltas_to_Screen();
			}
			else if (gotKBVal == RIGHT)
			{
				positionCursorScreen(xShooter, yShooter);
				putCharA(' ');
				xShooter += 1;
				if (xShooter > xShooterMax)
					xShooter = xShooterMax;
				positionCursorScreen(xShooter, yShooter);
				putCharA('}');
				copy_ScreenBuffer_Deltas_to_Screen();
			}
			else if (gotKBVal == LEFT)
			{
				positionCursorScreen(xShooter, yShooter);
				putCharA(' ');
				xShooter -= 1;
				if (xShooter < xShooterMin)
					xShooter = xShooterMin;
				positionCursorScreen(xShooter, yShooter);
				putCharA('}');
				copy_ScreenBuffer_Deltas_to_Screen();
			}
			else if ((gotKBVal == FIRE) && (bulletActive == 0))
			{
				bulletX = xShooter+1;
				bulletY = yShooter;
				positionCursorScreen(bulletX, bulletY);
				putCharA('-');
				copy_ScreenBuffer_Deltas_to_Screen();
				bulletActive = 1;
			}
		}
		// Animate target
/* 		positionCursorScreen(xTarget, yTarget);
		putCharA(' ');
		xTarget += randomNum(-1,1);
		if (xTarget < xTargetMin)
			xTarget = xTargetMin;
		else if (xTarget > xTargetMax)
			xTarget = xTargetMax;
		yTarget += randomNum(-1,1);
		if (yTarget < yTargetMin)
			yTarget = yTargetMin;
		else if (yTarget > yTargetMax)
			yTarget = yTargetMax;
		positionCursorScreen(xTarget, yTarget);
		putCharA('@'); */
		if (bulletActive == 1)
		{
			positionCursorScreen(bulletX, bulletY);
			putCharA(' ');
			bulletX += 1;
			if (bulletX<80)
			{
				if ((bulletX == xTarget) && (bulletY == yTarget))
				{
					bulletActive = 0;
					stringToScreen(40,25,"HIT!!!   ");
					explosion(bulletX, bulletY);
				}
				else
				{
					positionCursorScreen(bulletX, bulletY);
					putCharA('-');				
				}
			}
			else
			{
				bulletActive = 0;
				stringToScreen(40,25,"Miss (:   ");
			}			
		}
		// Move cursor off playfield
		positionCursorScreen(75, 25);
		copy_ScreenBuffer_Deltas_to_Screen();
	}
	cls();
	positionCursorScreen(1, 1);
	copy_ScreenBuffer_Deltas_to_Screen();
	return 1;
}

void explosion(int bulletX, int bulletY)
{
	char expl = '!';
	while (expl <= '.')
	{
		positionCursorScreen(bulletX, bulletY);
		putCharA(expl);
		positionCursorScreen(79,25);
		copy_ScreenBuffer_Deltas_to_Screen();
		expl += 1;
	}
	positionCursorScreen(bulletX, bulletY);
	putCharA(' ');
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
	stringToScreen(1,25,"Arrows=move, Space=fire, (Q)uit");
}

enum KBVALS getKeyboard(void)
{
	char kbChar;
	kbChar = getCharA();
	if (kbChar == 'q')
		return QUIT;
	if (kbChar == 'Q')
		return QUIT;
	if (kbChar == ' ')
		return FIRE;
	if (kbChar == 0x1B)
	{
		kbChar = getCharA();
		if (kbChar == '[')
		{
			kbChar = getCharA();
			if (kbChar == 'A')		/* UP		*/
				return UP;
			if (kbChar == 'B')		/* DN		*/
				return DOWN;
			if (kbChar == 'C')		/* RT		*/
				return RIGHT;
			if (kbChar == 'D')		/* LT		*/
				return LEFT;
		}
	}
	return UNKN_KEY;
}

int randomNum(int rangeLow, int rangeHigh)
{
	unsigned long timerVal;
	int retVal;
	timerVal = readTimer();
	retVal = timerVal % (rangeHigh - rangeLow + 1);
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

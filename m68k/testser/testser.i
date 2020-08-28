# 1 "testser.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "testser.c"
# 10 "testser.c"
void printCharToACIA(unsigned char);
void printStringToACIA(const char *);
void printCharToVDU(unsigned char);
void printStringToVDU(const char *);

void _start(void)
{
 printStringToACIA("Test String 1");
 printStringToVDU("Test String 2");
}

void printCharToACIA(unsigned char charToPrint)
{
 while ((*(volatile unsigned char *) 0x010041 & 0x2) == 0x0);
 * (volatile unsigned char *) 0x010043 = charToPrint;
}

void printStringToACIA(const char * strToPrint)
{
    int strOff = 0;
    while(strToPrint[strOff] != 0)
        printCharToACIA(strToPrint[strOff]);
}

void printCharToVDU(unsigned char charToPrint)
{
 while ((*(volatile unsigned char *) 0x010040 & 0x2) == 0x0);
 * (volatile unsigned char *) 0x010042 = charToPrint;
}

void printStringToVDU(const char * strToPrint)
{
    int strOff = 0;
    while(strToPrint[strOff] != 0)
        printCharToVDU(strToPrint[strOff]);
}

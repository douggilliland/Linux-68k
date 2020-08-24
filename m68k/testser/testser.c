// testser.c

#define ACIASTAT (unsigned char *) 0x010041
#define ACIADATA (unsigned char *) 0x010043
#define TXRDYBIT 0x2

void _start(void)
{
	while ((*ACIASTAT & TXRDYBIT) == 0x0);
	* ACIADATA = 'X';
}

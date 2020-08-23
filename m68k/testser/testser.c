// testser.c

#define ACIASTAT 0x010041
#define ACIADATA 0x010043

void main(void)
{
	unsigned char aciaStat;
	do
		aciaStat = *(unsigned char *) ACIASTAT;
	while ((aciaStat & 0x2) == 0x2);
	*(unsigned char *) ACIADATA = 'X';
}

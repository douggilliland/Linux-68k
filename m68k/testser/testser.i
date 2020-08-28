# 1 "testser.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "testser.c"





void _start(void)
{
 unsigned char aciaStat;
 do
  aciaStat = *(unsigned char *) 0x010041;
 while ((aciaStat & 0x2) == 0x2);
 *(unsigned char *) 0x010043 = 'X';
}

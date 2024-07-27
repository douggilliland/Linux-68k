ARCH	= 68000
BASE	= /opt/m68k-elf/bin/m68k-elf
CC      = $(BASE)-gcc
LD      = $(BASE)-ld
AS      = $(BASE)-as
CP      = $(BASE)-objcopy
DUMP    = $(BASE)-objdump
VASM	= ../../../vasm/vasmm68k_mot

all:	S68K_GAME_03.run S68K_GAME_03.s

S68K_GAME_03.run: S68K_GAME_03.c
#	/opt/m68k-elf/bin/m68k-elf-gcc -Wall -m68000 -msoft-float -c S68K_GAME_03.c
	$(CC) -Wall -m68000 -msoft-float -c S68K_GAME_03.c
#	/opt/m68k-elf/bin/m68k-elf-ld --defsym=_start=main -Ttext=0x2000 -Tdata=0x8000 -Tbss=0x9000 --section-start=.rodata=0x5000 S68K_GAME_03.o `/opt/m68k-elf/bin/m68k-elf-gcc -m68000 -print-libgcc-file-name`
	$(LD) --defsym=_start=main -Ttext=0x2000 -Tdata=0x8000 -Tbss=0x9000 --section-start=.rodata=0x5000 S68K_GAME_03.o `/opt/m68k-elf/bin/m68k-elf-gcc -m68000 -print-libgcc-file-name`
#	/opt/m68k-elf/bin/m68k-elf-objcopy -O srec a.out S68K_GAME_03.run
	$(CP) -O srec a.out S68K_GAME_03.run

S68K_GAME_03.s: S68K_GAME_03.c
#	/opt/m68k-elf/bin/m68k-elf-gcc -Wall -nostdlib -nodefaultlibs -m68000 -S S68K_GAME_03.c
	$(CC) -Wall -nostdlib -nodefaultlibs -m68000 -S S68K_GAME_03.c

clean:
	$(RM) a.out S68K_GAME_03.o S68K_GAME_03.run S68K_GAME_03.s

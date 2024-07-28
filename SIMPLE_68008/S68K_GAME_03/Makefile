ARCH	= 68000
BASE	= /opt/m68k-elf/bin/m68k-elf
CC      = $(BASE)-gcc
LD      = $(BASE)-ld
AS      = $(BASE)-as
CP      = $(BASE)-objcopy
DUMP    = $(BASE)-objdump
VASM	= ../../../vasm/vasmm68k_mot

# gcc man page = https://www.man7.org/linux/man-pages/man1/gcc.1.html
# -Wall = print all warnings
# -msoft-float = Selects software floating-point implementation
CFLAGS  = -m$(ARCH) -Wall -msoft-float

# -nostartfiles = no startup files
# -nostdlib = No standard library
# -Wl,--relax = Relax linker stub generation
LFLAGS  = --defsym=_start=main -Ttext=0x2000 -Tdata=0x8000 -Tbss=0x9000 --section-start=.rodata=0x5000

all:	S68K_GAME_03.run S68K_GAME_03.s

S68K_GAME_03.run: S68K_GAME_03.c
	$(CC) $(CFLAGS) -c S68K_GAME_03.c
	$(LD) $(LFLAGS) S68K_GAME_03.o `/opt/m68k-elf/bin/m68k-elf-gcc -m68000 -print-libgcc-file-name`
	$(CP) -O srec a.out S68K_GAME_03.run

S68K_GAME_03.s: S68K_GAME_03.c
	$(CC) -m$(ARCH) -Wall -nostdlib -nodefaultlibs -S S68K_GAME_03.c

clean:
	$(RM) a.out S68K_GAME_03.o S68K_GAME_03.run S68K_GAME_03.s

all:	SDCard.run SDCard.s

SDCard.run: SDCard.c
	/opt/m68k-elf/bin/m68k-elf-gcc -Wall -m68000 -msoft-float -c SDCard.c
	/opt/m68k-elf/bin/m68k-elf-ld --defsym=_start=main -Ttext=0x2000 -Tdata=0x3000 -Tbss=0x4000 --section-start=.rodata=0x5000 SDCard.o `/opt/m68k-elf/bin/m68k-elf-gcc -m68000 -print-libgcc-file-name`
	/opt/m68k-elf/bin/m68k-elf-objcopy -O srec a.out SDCard.run

SDCard.s: SDCard.c
	/opt/m68k-elf/bin/m68k-elf-gcc -Wall -nostdlib -nodefaultlibs -m68000 -S SDCard.c

clean:
	$(RM) a.out SDCard.o SDCard.run SDCard.s


all:	S68K_005.run S68K_005.s

S68K_005.run: S68K_005.c
	/opt/m68k-elf/bin/m68k-elf-gcc -Wall -m68000 -msoft-float -c S68K_005.c
	/opt/m68k-elf/bin/m68k-elf-ld --defsym=_start=main -Ttext=0x2000 -Tdata=0x3000 -Tbss=0x4000 --section-start=.rodata=0x5000 S68K_005.o `/opt/m68k-elf/bin/m68k-elf-gcc -m68000 -print-libgcc-file-name`
	/opt/m68k-elf/bin/m68k-elf-objcopy -O srec a.out S68K_005.run

S68K_005.s: S68K_005.c
	/opt/m68k-elf/bin/m68k-elf-gcc -Wall -nostdlib -nodefaultlibs -m68000 -S S68K_005.c

clean:
	$(RM) a.out S68K_005.o S68K_005.run S68K_005.s

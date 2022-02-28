all:	kk_srec.run kk_srec.s

kk_srec.run: kk_srec.c
	/opt/m68k-elf/bin/m68k-elf-gcc -Wall -m68000 -msoft-float -c kk_srec.c
	/opt/m68k-elf/bin/m68k-elf-ld --defsym=_start=main -Ttext=0x2000 -Tdata=0x3000 -Tbss=0x4000 --section-start=.rodata=0x5000 kk_srec.o `/opt/m68k-elf/bin/m68k-elf-gcc -m68000 -print-libgcc-file-name`
	/opt/m68k-elf/bin/m68k-elf-objcopy -O srec a.out kk_srec.run

kk_srec.s: kk_srec.c
	/opt/m68k-elf/bin/m68k-elf-gcc -Wall -nostdlib -nodefaultlibs -m68000 -S kk_srec.c

clean:
	$(RM) a.out kk_srec.o kk_srec.run kk_srec.s


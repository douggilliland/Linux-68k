all:	tutor13.hex tutor13.bin

tutor13.o: tutor13.s
	/opt/m68k-elf/bin/m68k-elf-as -m68000 -alms -a=tutor13.lst -o tutor13.o tutor13.s

tutor13.bin: tutor13.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O binary tutor13.o tutor13.bin

tutor13.hex: tutor13.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O srec tutor13.o tutor13.tmp
	srec_cat tutor13.tmp --crop 0x80000 0x80fff -o tutor13.sre
	srec_cat tutor13.tmp --crop 0x80000 0x80fff -o tutor13.hex -Intel
#	rm tutor13.tmp

clean:
	$(RM) tutor13.lst tutor13.o tutor13.bin tutor13.sre tutor13.hex tutor13.tmp
#	$(RM) tutor13.tmp

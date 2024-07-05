all:	S68K_002.hex S68K_002.bin

S68K_002.o: S68K_002.s
	/opt/m68k-elf/bin/m68k-elf-as -m68000 -alms -a=S68K_002.lst -o S68K_002.o S68K_002.s

S68K_002.bin: S68K_002.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O binary S68K_002.o S68K_002.bin

S68K_002.hex: S68K_002.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O srec S68K_002.o S68K_002.tmp
	srec_cat S68K_002.tmp --crop 0x80000 0x8ffff -o S68K_002.sre
	srec_cat S68K_002.tmp --crop 0x80000 0x8ffff -o S68K_002.hex -Intel
#	rm S68K_002.tmp

clean:
	$(RM) S68K_002.lst S68K_002.o S68K_002.bin S68K_002.sre S68K_002.hex S68K_002.tmp
#	$(RM) S68K_002.tmp

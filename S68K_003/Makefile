all:	S68K_003.hex S68K_003.bin

S68K_003.o: S68K_003.s
	/opt/m68k-elf/bin/m68k-elf-as -m68000 -alms -a=S68K_003.lst -o S68K_003.o S68K_003.s

S68K_003.bin: S68K_003.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O binary S68K_003.o S68K_003.bin

S68K_003.hex: S68K_003.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O srec S68K_003.o S68K_003.tmp
	srec_cat S68K_003.tmp --crop 0x001000 0x001fff -o S68K_003.sre
	rm S68K_003.tmp

clean:
	$(RM) S68K_003.lst S68K_003.o S68K_003.bin S68K_003.sre S68K_003.hex S68K_003.tmp
	$(RM) S68K_003.tmp

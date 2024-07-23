all:	S68K_008.hex S68K_008.bin

S68K_008.o: S68K_008.s
	/opt/m68k-elf/bin/m68k-elf-as -m68000 -alms -a=S68K_008.lst -o S68K_008.o S68K_008.s

S68K_008.bin: S68K_008.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O binary S68K_008.o S68K_008.bin

S68K_008.hex: S68K_008.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O srec S68K_008.o S68K_008.tmp
	srec_cat S68K_008.tmp --crop 0x001000 0x001fff -o S68K_008.sre
	rm S68K_008.tmp

clean:
	$(RM) S68K_008.lst S68K_008.o S68K_008.bin S68K_008.sre S68K_008.hex S68K_008.tmp
	$(RM) S68K_008.tmp

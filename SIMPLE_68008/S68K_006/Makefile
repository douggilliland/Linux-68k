all:	S68K_006.hex S68K_006.bin

S68K_006.o: S68K_006.s
	/opt/m68k-elf/bin/m68k-elf-as -m68000 -alms -a=S68K_006.lst -o S68K_006.o S68K_006.s

S68K_006.bin: S68K_006.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O binary S68K_006.o S68K_006.bin

S68K_006.hex: S68K_006.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O srec S68K_006.o S68K_006.tmp
	srec_cat S68K_006.tmp --crop 0x001000 0x001fff -o S68K_006.sre
	rm S68K_006.tmp

clean:
	$(RM) S68K_006.lst S68K_006.o S68K_006.bin S68K_006.sre S68K_006.hex S68K_006.tmp
	$(RM) S68K_006.tmp

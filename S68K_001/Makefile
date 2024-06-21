all:	S68K_001.hex S68K_001.bin

S68K_001.o: S68K_001.s
	/opt/m68k-elf/bin/m68k-elf-as -m68000 -alms -a=S68K_001.lst -o S68K_001.o S68K_001.s

S68K_001.bin: S68K_001.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O binary S68K_001.o S68K_001.bin

S68K_001.hex: S68K_001.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O srec S68K_001.o S68K_001.tmp
	srec_cat S68K_001.tmp --crop 0x80000 0x80fff -o S68K_001.sre
	srec_cat S68K_001.tmp --crop 0x80000 0x80fff -o S68K_001.hex -Intel_HeX_16
#	rm S68K_001.tmp

clean:
	$(RM) S68K_001.lst S68K_001.o S68K_001.bin S68K_001.sre S68K_001.hex S68K_001.tmp
#	$(RM) S68K_001.tmp

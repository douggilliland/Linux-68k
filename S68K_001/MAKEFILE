all:	S68K_001.rec S68K_001.bin

S68K_001.o: S68K_001.s
	/opt/m68k-elf/bin/m68k-elf-as -m68000 -alms -a=S68K_001.lst -o S68K_001.o S68K_001.s

S68K_001.bin: S68K_001.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O binary S68K_001.o S68K_001.bin

S68K_001.rec: S68K_001.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O srec S68K_001.o S68K_001.tmp
	srec_cat S68K_001.tmp --crop 0x1000 0x1fff -o S68K_001.rec
#	rm S68K_001.tmp

clean:
	$(RM) S68K_001.lst S68K_001.o S68K_001.bin S68K_001.rec
#	$(RM) S68K_001.tmp

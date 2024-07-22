all:	S68K_007.hex S68K_007.bin

S68K_007.o: S68K_007.s
	/opt/m68k-elf/bin/m68k-elf-as -m68000 -alms -a=S68K_007.lst -o S68K_007.o S68K_007.s

S68K_007.bin: S68K_007.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O binary S68K_007.o S68K_007.bin

S68K_007.hex: S68K_007.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O srec S68K_007.o S68K_007.tmp
	srec_cat S68K_007.tmp --crop 0x001000 0x001fff -o S68K_007.sre
	rm S68K_007.tmp

clean:
	$(RM) S68K_007.lst S68K_007.o S68K_007.bin S68K_007.sre S68K_007.hex S68K_007.tmp
	$(RM) S68K_007.tmp

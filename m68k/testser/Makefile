all: testser.rec testser.bin

testser.o: testser.c
	/opt/m68k-elf/bin/m68k-elf-gcc -save-temps -m68000 -o testser.o testser.c

testser.bin: testser.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O binary testser.o testser.bin

testser.rec: testser.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O srec testser.o testser.tmp
	srec_cat testser.tmp --crop 0x1000 0x1fff -o testser.rec
#	rm testser.tmp

clean:
	$(RM) testser.o testser.bin testser.rec
	$(RM) testser.tmp


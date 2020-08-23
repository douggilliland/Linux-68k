all:	testser.rec testser.bin

testser.o: testser.s
	/opt/m68k-elf/bin/m68k-elf-gcc -m68000 -alms -a=testser.lst -o testser.o testser.s

testser.bin: testser.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O binary testser.o testser.bin

testser.rec: testser.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O srec testser.o testser.tmp
	srec_cat testser.tmp --crop 0x1000 0x1fff -o testser.rec
#	rm testser.tmp

clean:
	$(RM) testser.lst testser.o testser.bin testser.rec
#	$(RM) testser.tmp


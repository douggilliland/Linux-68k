all:	ExtRAMTest.rec ExtRAMTest.bin

ExtRAMTest.o: ExtRAMTest.s
	/opt/m68k-elf/bin/m68k-elf-as -m68000 -alms -a=ExtRAMTest.lst -o ExtRAMTest.o ExtRAMTest.s

ExtRAMTest.bin: ExtRAMTest.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O binary ExtRAMTest.o ExtRAMTest.bin

ExtRAMTest.rec: ExtRAMTest.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O srec ExtRAMTest.o ExtRAMTest.tmp
	srec_cat ExtRAMTest.tmp --crop 0x1000 0x1fff -o ExtRAMTest.rec
#	rm ExtRAMTest.tmp

clean:
	$(RM) ExtRAMTest.lst ExtRAMTest.o ExtRAMTest.bin ExtRAMTest.rec
#	$(RM) ExtRAMTest.tmp


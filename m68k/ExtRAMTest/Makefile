all:	ExtRAMTest.run ExtRAMTest.bin ExtRAMTest.srk

ExtRAMTest.o: ExtRAMTest.s
	/opt/m68k-elf/bin/m68k-elf-as -m68000 -alms -a=ExtRAMTest.lst -o ExtRAMTest.o ExtRAMTest.s

ExtRAMTest.bin: ExtRAMTest.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O binary ExtRAMTest.o ExtRAMTest.bin

ExtRAMTest.run: ExtRAMTest.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O srec ExtRAMTest.o ExtRAMTest.rec
#	srec_cat ExtRAMTest.rec -fill 0x1000 0x8000 0xc000 --crop 0x8000 0xc000 -Output_Block_Size 16 -o ExtRAMTest.run
	srec_cat ExtRAMTest.rec --crop 0x0000 0x0fff -o ExtRAMTest.run
#	$(RM) ExtRAMTest.rec
#	srec_cat ExtRAMTest.run -offset - -minimum-addr ExtRAMTest.run -o ExtRAMTest.hex -Intel

ExtRAMTest.srk: ExtRAMTest.run
	srec_cat ExtRAMTest.run -Motorola -output ExtRAMTest.srk

clean:
	$(RM) ExtRAMTest.lst ExtRAMTest.o ExtRAMTest.run ExtRAMTest.bin ExtRAMTest.srk
	$(RM) ExtRAMTest.rec


all:	ExtRAMTest.run ExtRAMTest.bin ExtRAMTest.hex

ExtRAMTest.o: ExtRAMTest.s
	/opt/m68k-elf/bin/m68k-elf-as -m68000 -alms -a=ExtRAMTest.lst -o ExtRAMTest.o ExtRAMTest.s

ExtRAMTest.run: ExtRAMTest.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O srec ExtRAMTest.o temp
#	srec_cat temp -fill 0x1000 0x8000 0xc000 --crop 0x8000 0xc000 -Output_Block_Size 16 -o ExtRAMTest.run
	srec_cat temp -o ExtRAMTest.run
	$(RM) temp
	srec_cat ExtRAMTest.run -offset - -minimum-addr ExtRAMTest.run -o ExtRAMTest.sre -Intel

ExtRAMTest.bin: ExtRAMTest.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -O binary ExtRAMTest.o ExtRAMTest.bin

ExtRAMTest.hex: ExtRAMTest.run
	srec_cat ExtRAMTest.run -Motorola -output ExtRAMTest.hex -Intel

clean:
	$(RM) ExtRAMTest.lst ExtRAMTest.o ExtRAMTest.run ExtRAMTest.bin ExtRAMTest.sre ExtRAMTest.hex
	$(RM) temp


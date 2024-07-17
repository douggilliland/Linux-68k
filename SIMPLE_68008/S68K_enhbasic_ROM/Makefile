all: basic68k.hex

basic68k.hex: basic68k.run
	srec_cat basic68k.run -Motorola -output basic68k.hex -Intel

basic68k.run: basic68k.inc basic68k.asm
	../../vasm/vasmm68k_mot -quiet -m68000 -Fsrec -s28 -L basic68k.lst -o basic68k.run basic68k.asm
	# Building for ROM
	srec_cat basic68k.run -fill 0x00 0x84000 0x87fff --crop 0x84000 0x87fff -address-length=3 -Output_Block_Size 16 -o temp
	mv temp basic68k.run
	srec_cat ../S68K_002/S68K_002.sre basic68k.run -Output combined.hex -Intel

clean:
	$(RM) basic68k.run basic68k_even.run basic68k_odd.run basic68k.lst basic68k.hex combined.hex

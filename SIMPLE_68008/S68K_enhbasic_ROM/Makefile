basic68k.hex: basic68k.run
	srec_cat basic68k.run -Motorola -output basic68k.hex -Intel

basic68k.run: basic68k.inc basic68k.asm
#	../../vasm/vasmm68k_mot -quiet -m68000 -Fsrec -s19 -L basic68k.lst -o basic68k.run basic68k.asm
	../../vasm/vasmm68k_mot -quiet -m68000 -Fsrec -s28 -L basic68k.lst -o basic68k.run basic68k.asm
	# Use lines below when building for ROM
	srec_cat basic68k.run -fill 0x00 0xc0000 0xc3fff --crop 0xc0000 0xc3fff -Output_Block_Size 16 -o temp
	mv temp basic68k.run
# Use lines below when building for RAM
#	srec_cat basic68k.run -fill 0x00 0x800 0x3fff --crop 0x0800 0x3fff -Output_Block_Size 16 -o temp
#	mv temp basic68k.run

upload: basic68k.run
	ascii-xfr -s -l 50 basic68k.run | sed  's/S5/S9/' > /dev/ttyUSB0

clean:
	$(RM) basic68k.run basic68k_even.run basic68k_odd.run basic68k.lst basic68k.hex

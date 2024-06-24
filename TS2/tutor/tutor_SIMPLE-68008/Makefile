all:	tutor13.run tutor13.bin tutor13.hex

tutor13.o: tutor13.s
	/opt/m68k-elf/bin/m68k-elf-as -m68000 -alms -a=tutor13.lst -o tutor13.o tutor13.s

tutor13.run: tutor13.o
	/opt/m68k-elf/bin/m68k-elf-objcopy -I coff-m68k -O srec tutor13.o temp
	srec_cat temp -fill 0x00 0x8000 0xc000 --crop 0x8000 0xc000 -Output_Block_Size 16 -o tutor13.run
	$(RM) temp

tutor13.bin: tutor13.o
	/opt/m68k-elf/bin/asm68k-elf-objcopy -I coff-m68k -O binary tutor13.o tutor13.bin

tutor13.hex: tutor13.run
	srec_cat tutor13.run -Motorola -output tutor13.hex -Intel

clean:
	$(RM) tutor13.lst tutor13.o tutor13.run tutor13.bin tutor13.hex


#
#	makefile for d8tape
#
#	(C) Copyright 2001, 2003, 2007, by Robert Krten, all rights reserved.
#	Please see the LICENSE file for more information.
#
#	I collect PDP systems of almost all shapes and sizes; send me an
#	email to "rk@parse.com" if you have one to give away, sell,
#	or trade, or visit the museum at http://www.parse.com/~museum/
#
#	2001 01 07	R. Krten		created
#	2007 10 25	R. Krten		added flow module
#
#	The "bm" utility in the "core:" target simply increments
#	the version number -- you can comment out that line with
#	no ill effects, or simply "ln /bin/true /usr/local/bin/bm"
#	(or similar) to nullify its effects.
#

DEBUG = -g2
OBJECTS = main.o dasm.o flow.o

CFLAGS = $(DEBUG) -Wall
LDFLAGS = $(DEBUG)

Common = Makefile

core: $(OBJECTS)
	bm -h version.c
	cc $(CFLAGS) -o core $(OBJECTS) version.c $(LDFLAGS)

main.o: main.c $(Common)

install:
	make
	cp core /usr/local/bin/d8tape

release:
	make clean
	tar cvf d8tape.tar Makefile *.c *.h LICENSE
	gzip -9v d8tape.tar

test:
	pal -t4 test.pal
	d8tape test.bin >test.list
	cp test.list verify.pal
	pal -t4 verify.pal
	d8tape verify.bin >verify.list
	-diff test.list verify.list

clean:
	rm -f *.o core

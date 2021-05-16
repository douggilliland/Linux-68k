# bin2mif.py - Convert PDP-8 binary file to MIF file
#	Read in the binary file creates by macro8x assembler
# DEC bin file format
#	http://www.bitsavers.org/www.computer.museum.uq.edu.au/pdf/DEC-08-LBAA-D%20Binary%20Loader.pdf
# Write out the Altera formatted Memory Initialization (.MIF) file to the command prompt window
# Run from windows with python ../bin2mif.py iset.bin > iset.mif
# Run from Linux with python3 ../bin2mif.py iset.bin > iset.mif

import sys

# print('argv',sys.argv)
# print('count',len(sys.argv))
inFileName = sys.argv[1]

binList = []
with open(inFileName, "rb") as f:
	binList = f.read()
# print(binList)

# Ignore header
pairOffset = 0
while binList[pairOffset] == 0x80:
	pairOffset += 1
# Ignore data sections
while binList[pairOffset] != 0x42:
	pairOffset += 2
# Grab code section
theList = []
# Fill data section with zeros
# Could probably fix this to use actual data values, but OK for now
dataCount = 0
while dataCount < 128:
	theList.append('000')
	dataCount += 1
pairOffset += 2
while pairOffset < len(binList)-3:
	val1 = int(binList[pairOffset]) & 0x3f;
	val2 = int(binList[pairOffset+1]) & 0x3f;
	val = (val1 << 6) | val2;
	txt = '{0:o}'
	theList.append(txt.format(val))
	pairOffset += 2

print('-- Generated by bin2mif.py')
print('-- ')
print('DEPTH = '+ str(len(theList))  +';')
print('WIDTH = 12;')
print('ADDRESS_RADIX = DECIMAL;')
print('DATA_RADIX = OCTAL;')
print('CONTENT BEGIN')
lineCount = 0
addrCount = 0
for cell in theList:
	if lineCount == 0:
		if len(str(addrCount)) == 4:
			outVal = str(addrCount) + ':'
		elif len(str(addrCount)) == 3:
			outVal = '0' + str(addrCount) + ':'
		elif len(str(addrCount)) == 2:
			outVal = '00' + str(addrCount) + ':'
		elif len(str(addrCount)) == 1:
			outVal = '000' + str(addrCount) + ':'
		print(outVal,end='')
	lineCount += 1
	addrCount += 1	
	newCell	= ''
	if len(cell) == 4:
		newCell = cell
	elif len(cell) == 3:
		newCell = '0' + cell
	elif len(cell) == 2:
		newCell = '00' + cell
	elif len(cell) == 1:
		newCell = '000' + cell
	print(' ' + newCell,end='')
	if lineCount == 8:
		lineCount = 0
		print(';')
print(';\nEND;')


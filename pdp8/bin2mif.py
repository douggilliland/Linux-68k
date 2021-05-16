# bin2mif.py - Convert PDP-8 binary file to MIF file
#	Read in the binary file creates by macro8x assembler
# DEC bin file format
#	http://www.bitsavers.org/www.computer.museum.uq.edu.au/pdf/DEC-08-LBAA-D%20Binary%20Loader.pdf
# Write out the Altera formatted Memory Initialization (.MIF) file to the command prompt window
# Redirect with > 
# Run from windows with python ../bin2mif.py easy.bin > easy.mif
# Run from Linux with python3 ../bin2mif.py easy.bin > easy.mif

import sys

def readBinaryFile(inFileName):
	""" 
	"""
	# inBinList = []
	with open(inFileName, "rb") as f:
		inBinList = f.read()
	print('input file len', len(inBinList))
	return inBinList

def fillOutArray():
	""" 
	"""
	oArray = []
	for count in range(4096):
		oArray.append('0000')
		# print('oArray',oArray)
	return oArray

def getAddrVal(val1, val2):
	"""
	"""
	nval1 = int(val1) & 0x3f;
	nval2 = int(val2) & 0x3f;
	val = (nval1 << 6) | nval2;
	return val
	
def getDataVal(val1, val2):
	"""
	"""
	nval1 = int(val1) & 0x3f;
	nval2 = int(val2) & 0x3f;
	val = (nval1 << 6) | nval2;
	txt = '{0:o}'
	return txt.format(val)

# print('argv',sys.argv)
# print('count',len(sys.argv))

inFileName = sys.argv[1]
binList = readBinaryFile(inFileName)
outArray = fillOutArray()

# Ignore header
pairOffset = 0
addressOffset = 0
while pairOffset < len(binList):
	if binList[pairOffset] & 0x80:
		pairOffset += 1
	elif binList[pairOffset] & 0x40:
		addressOffset = getAddrVal(binList[pairOffset],binList[pairOffset+1])
		pairOffset += 2
	else:
		outArray[addressOffset] = getDataVal(binList[pairOffset],binList[pairOffset+1])
		addressOffset += 1
		pairOffset += 2

print('-- File:',inFileName[0:-4]+'.mif')
print('-- Generated by bin2mif.py')
print('-- ')
print('DEPTH = '+ str(len(outArray))  +';')
print('WIDTH = 12;')
print('ADDRESS_RADIX = DECIMAL;')
print('DATA_RADIX = OCTAL;')
print('CONTENT BEGIN')
lineCount = 0
addrCount = 0
for cell in outArray:
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
print('END;')



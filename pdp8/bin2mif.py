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
	# print('input file len', len(inBinList))
	# print(inBinList)
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

if len(sys.argv) == 1:
	assert False,'Usage: python ..\\bin2mif.py echo.bin'
inFileName = sys.argv[1]
print('Input file:',inFileName)
if inFileName.upper()[-4:] != '.BIN':
	assert False,'file name should end in .bin'
outFileName = inFileName[:-4] + '.mif'
print('Output file:',outFileName)
binList = readBinaryFile(inFileName)
if binList[0] != 0x80:
	assert False,'Expected 0x80 leader at the start of the file'
if binList[-1] != 0x80:
	assert False,'Expected 0x80 leader at the end of the file'
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
		outVal = getDataVal(binList[pairOffset],binList[pairOffset+1])
		if addressOffset > 4095:
			errStr = 'Output address error, address = ' + str(addressOffset) + ' probably the checksum?'
			print(errStr)
		else:
			outArray[addressOffset] = outVal
		# print('wrote',outVal,'to address',addressOffset)
		addressOffset += 1
		pairOffset += 2

outList = []
outStr = '-- File: ' + inFileName[0:-4] + '.mif'
outList.append(outStr)
outList.append('-- Generated by bin2mif.py')
outList.append('-- ')
outStr = 'DEPTH = '+ str(len(outArray)) + ';'
outList.append(outStr)
outStr = ''
outList.append('WIDTH = 12;')
outList.append('ADDRESS_RADIX = OCTAL;')
outList.append('DATA_RADIX = OCTAL;')
outList.append('CONTENT BEGIN')
lineCount = 0
addrCount = 0
for cell in outArray:
	if lineCount == 0:
		# if len(str(addrCount)) == 4:
			# outVal = str(addrCount) + ':'
		# elif len(str(addrCount)) == 3:
			# outVal = '0' + str(addrCount) + ':'
		# elif len(str(addrCount)) == 2:
			# outVal = '00' + str(addrCount) + ':'
		# elif len(str(addrCount)) == 1:
			# outVal = '000' + str(addrCount) + ':'
		# outStr += outVal
		outStr += str((addrCount >> 9) & 7)
		outStr += str((addrCount >> 6) & 7)
		outStr += str((addrCount >> 3) & 7)
		outStr += str(addrCount & 7)
		outStr += ':'
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
	outStr += ' ' + newCell
	if lineCount == 8:
		lineCount = 0
		outStr += ';'
		outList.append(outStr)
		outStr = ''
outList.append('END;')
# for line in outList:
	# print(line)

F = open(outFileName, 'w')
for row in outList:
	F.writelines(row+'\n')
F.close()

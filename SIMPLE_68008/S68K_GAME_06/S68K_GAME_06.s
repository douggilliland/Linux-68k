#NO_APP
	.file	"S68K_GAME_06.c"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	link.w %fp,#0
	jsr playGame
	unlk %fp
	rts
	.size	main, .-main
	.align	2
	.globl	makeSeedFromKeyWait
	.type	makeSeedFromKeyWait, @function
makeSeedFromKeyWait:
	link.w %fp,#-16
	move.l #983042,-10(%fp)
	move.l #983046,-14(%fp)
	clr.l -4(%fp)
	clr.b -5(%fp)
	jra .L4
.L5:
	move.l -10(%fp),%a0
	move.b (%a0),-5(%fp)
	and.b #1,-5(%fp)
	addq.l #1,-4(%fp)
.L4:
	tst.b -5(%fp)
	jeq .L5
	move.l -14(%fp),%a0
	move.b (%a0),%d0
	move.b %d0,%d0
	and.l #255,%d0
	add.l %d0,-4(%fp)
	move.l -4(%fp),%d0
	unlk %fp
	rts
	.size	makeSeedFromKeyWait, .-makeSeedFromKeyWait
	.align	2
	.globl	rxStatPortA
	.type	rxStatPortA, @function
rxStatPortA:
	link.w %fp,#-8
	move.l #983042,-4(%fp)
	move.l -4(%fp),%a0
	move.b (%a0),-5(%fp)
	and.b #1,-5(%fp)
	move.b -5(%fp),%d0
	unlk %fp
	rts
	.size	rxStatPortA, .-rxStatPortA
	.align	2
	.globl	rxStatPortB
	.type	rxStatPortB, @function
rxStatPortB:
	link.w %fp,#-8
	move.l #983058,-4(%fp)
	move.l -4(%fp),%a0
	move.b (%a0),-5(%fp)
	and.b #1,-5(%fp)
	move.b -5(%fp),%d0
	unlk %fp
	rts
	.size	rxStatPortB, .-rxStatPortB
	.align	2
	.globl	getCharA
	.type	getCharA, @function
getCharA:
	link.w %fp,#-12
	move.l #983042,-6(%fp)
	move.l #983046,-10(%fp)
	clr.b -1(%fp)
	jra .L12
.L13:
	move.l -6(%fp),%a0
	move.b (%a0),-1(%fp)
	and.b #1,-1(%fp)
.L12:
	tst.b -1(%fp)
	jeq .L13
	move.l -10(%fp),%a0
	move.b (%a0),%d0
	unlk %fp
	rts
	.size	getCharA, .-getCharA
	.align	2
	.globl	getCharB
	.type	getCharB, @function
getCharB:
	link.w %fp,#-12
	move.l #983058,-6(%fp)
	move.l #983062,-10(%fp)
	clr.b -1(%fp)
	jra .L16
.L17:
	move.l -6(%fp),%a0
	move.b (%a0),-1(%fp)
	and.b #1,-1(%fp)
.L16:
	tst.b -1(%fp)
	jeq .L17
	move.l -10(%fp),%a0
	move.b (%a0),%d0
	unlk %fp
	rts
	.size	getCharB, .-getCharB
	.align	2
	.globl	putCharA
	.type	putCharA, @function
putCharA:
	link.w %fp,#-12
	move.l 8(%fp),%d0
	move.b %d0,%d0
	move.b %d0,-12(%fp)
	move.l #983042,-6(%fp)
	move.l #983046,-10(%fp)
	clr.b -1(%fp)
	jra .L20
.L21:
	move.l -6(%fp),%a0
	move.b (%a0),%d0
	move.b %d0,-1(%fp)
	and.b #4,-1(%fp)
.L20:
	tst.b -1(%fp)
	jeq .L21
	move.b -12(%fp),%d0
	move.l -10(%fp),%a0
	move.b %d0,(%a0)
	nop
	unlk %fp
	rts
	.size	putCharA, .-putCharA
	.align	2
	.globl	putCharB
	.type	putCharB, @function
putCharB:
	link.w %fp,#-12
	move.l 8(%fp),%d0
	move.b %d0,%d0
	move.b %d0,-12(%fp)
	move.l #983058,-6(%fp)
	move.l #983062,-10(%fp)
	clr.b -1(%fp)
	jra .L23
.L24:
	move.l -6(%fp),%a0
	move.b (%a0),%d0
	move.b %d0,-1(%fp)
	and.b #4,-1(%fp)
.L23:
	tst.b -1(%fp)
	jeq .L24
	move.b -12(%fp),%d0
	move.l -10(%fp),%a0
	move.b %d0,(%a0)
	nop
	unlk %fp
	rts
	.size	putCharB, .-putCharB
	.align	2
	.globl	printInt
	.type	printInt, @function
printInt:
	link.w %fp,#-80
	lea (-80,%fp),%a0
	move.l %a0,-(%sp)
	move.l 8(%fp),-(%sp)
	jsr intToStr
	addq.l #8,%sp
	lea (-80,%fp),%a0
	move.l %a0,-(%sp)
	jsr printString
	addq.l #4,%sp
	nop
	unlk %fp
	rts
	.size	printInt, .-printInt
	.globl	__modsi3
	.globl	__divsi3
	.align	2
	.globl	intToStr
	.type	intToStr, @function
intToStr:
	link.w %fp,#-16
	move.l %d2,-(%sp)
	clr.l -4(%fp)
	clr.l -8(%fp)
	tst.l 8(%fp)
	jge .L28
	moveq #1,%d0
	move.l %d0,-8(%fp)
	neg.l 8(%fp)
.L28:
	move.l 8(%fp),%d0
	pea 10.w
	move.l %d0,-(%sp)
	jsr __modsi3
	addq.l #8,%sp
	move.l %d0,%d0
	move.b %d0,%d1
	add.b #48,%d1
	move.l -4(%fp),%d0
	move.l %d0,%d2
	addq.l #1,%d2
	move.l %d2,-4(%fp)
	move.l 12(%fp),%a0
	add.l %d0,%a0
	move.b %d1,%d0
	move.b %d0,(%a0)
	move.l 8(%fp),%d0
	pea 10.w
	move.l %d0,-(%sp)
	jsr __divsi3
	addq.l #8,%sp
	move.l %d0,8(%fp)
	tst.l 8(%fp)
	jgt .L28
	tst.l -8(%fp)
	jeq .L29
	move.l -4(%fp),%d0
	move.l %d0,%d1
	addq.l #1,%d1
	move.l %d1,-4(%fp)
	move.l 12(%fp),%a0
	add.l %d0,%a0
	move.b #45,(%a0)
.L29:
	move.l -4(%fp),%d0
	move.l 12(%fp),%a0
	add.l %d0,%a0
	clr.b (%a0)
	clr.l -12(%fp)
	jra .L30
.L31:
	move.l -12(%fp),%d0
	move.l 12(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),-13(%fp)
	move.l -4(%fp),%d0
	sub.l -12(%fp),%d0
	subq.l #1,%d0
	move.l 12(%fp),%a1
	add.l %d0,%a1
	move.l -12(%fp),%d0
	move.l 12(%fp),%a0
	add.l %d0,%a0
	move.b (%a1),%d0
	move.b %d0,(%a0)
	move.l -4(%fp),%d0
	sub.l -12(%fp),%d0
	subq.l #1,%d0
	move.l 12(%fp),%a0
	add.l %d0,%a0
	move.b -13(%fp),(%a0)
	addq.l #1,-12(%fp)
.L30:
	move.l -4(%fp),%d0
	move.l %d0,%d1
	add.l %d1,%d1
	subx.l %d1,%d1
	neg.l %d1
	add.l %d1,%d0
	asr.l #1,%d0
	cmp.l -12(%fp),%d0
	jgt .L31
	nop
	nop
	move.l -20(%fp),%d2
	unlk %fp
	rts
	.size	intToStr, .-intToStr
	.align	2
	.globl	strToNum
	.type	strToNum, @function
strToNum:
	link.w %fp,#-8
	clr.l -4(%fp)
	move.l 8(%fp),-(%sp)
	jsr isStrNum
	addq.l #4,%sp
	tst.l %d0
	jne .L33
	move.l -4(%fp),%d0
	jra .L34
.L33:
	clr.l -8(%fp)
	jra .L35
.L36:
	move.l -4(%fp),%d1
	move.l %d1,%d0
	add.l %d0,%d0
	add.l %d0,%d0
	add.l %d1,%d0
	add.l %d0,%d0
	move.l %d0,-4(%fp)
	move.l -8(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	ext.w %d0
	move.w %d0,%a0
	moveq #-48,%d0
	add.l %a0,%d0
	add.l %d0,-4(%fp)
	addq.l #1,-8(%fp)
.L35:
	move.l 8(%fp),-(%sp)
	jsr strlen
	addq.l #4,%sp
	cmp.l -8(%fp),%d0
	jgt .L36
	move.l -4(%fp),%d0
.L34:
	unlk %fp
	rts
	.size	strToNum, .-strToNum
	.align	2
	.globl	isStrNum
	.type	isStrNum, @function
isStrNum:
	link.w %fp,#-8
	move.l 8(%fp),-(%sp)
	jsr strlen
	addq.l #4,%sp
	move.l %d0,-8(%fp)
	clr.l -4(%fp)
	jra .L38
.L42:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	cmp.b #57,%d0
	jle .L39
	moveq #0,%d0
	jra .L40
.L39:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	cmp.b #47,%d0
	jgt .L41
	moveq #0,%d0
	jra .L40
.L41:
	addq.l #1,-4(%fp)
.L38:
	move.l -4(%fp),%d0
	cmp.l -8(%fp),%d0
	jlt .L42
	moveq #1,%d0
.L40:
	unlk %fp
	rts
	.size	isStrNum, .-isStrNum
	.align	2
	.globl	getString
	.type	getString, @function
getString:
	link.w %fp,#-12
	clr.l -4(%fp)
	clr.l -8(%fp)
	jra .L44
.L48:
	jsr getCharA
	move.b %d0,-9(%fp)
	move.l 8(%fp),%a0
	move.b -9(%fp),(%a0)
	addq.l #1,-4(%fp)
	clr.l -8(%fp)
	moveq #78,%d0
	cmp.l -4(%fp),%d0
	jge .L45
	moveq #1,%d0
	move.l %d0,-8(%fp)
	jra .L44
.L45:
	cmp.b #10,-9(%fp)
	jne .L46
	move.l 8(%fp),%a0
	clr.b (%a0)
	moveq #1,%d0
	move.l %d0,-8(%fp)
	jra .L44
.L46:
	cmp.b #13,-9(%fp)
	jne .L47
	move.l 8(%fp),%a0
	clr.b (%a0)
	moveq #1,%d0
	move.l %d0,-8(%fp)
	jra .L44
.L47:
	move.b -9(%fp),%d0
	ext.w %d0
	move.w %d0,%a0
	move.l %a0,-(%sp)
	jsr putCharA
	addq.l #4,%sp
	addq.l #1,8(%fp)
.L44:
	tst.l -8(%fp)
	jeq .L48
	move.l 8(%fp),%a0
	clr.b (%a0)
	move.l -4(%fp),%d0
	unlk %fp
	rts
	.size	getString, .-getString
	.align	2
	.globl	printString
	.type	printString, @function
printString:
	link.w %fp,#-4
	clr.l -4(%fp)
	jra .L51
.L52:
	move.l 8(%fp),%a0
	add.l -4(%fp),%a0
	move.b (%a0),%d0
	ext.w %d0
	move.w %d0,%a0
	move.l %a0,-(%sp)
	jsr putCharA
	addq.l #4,%sp
	addq.l #1,-4(%fp)
.L51:
	move.l 8(%fp),-(%sp)
	jsr strlen
	addq.l #4,%sp
	cmp.l -4(%fp),%d0
	jhi .L52
	nop
	nop
	unlk %fp
	rts
	.size	printString, .-printString
	.align	2
	.globl	strlen
	.type	strlen, @function
strlen:
	link.w %fp,#-4
	clr.l -4(%fp)
	jra .L54
.L55:
	addq.l #1,-4(%fp)
.L54:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	tst.b %d0
	jne .L55
	move.l -4(%fp),%d0
	unlk %fp
	rts
	.size	strlen, .-strlen
	.comm	screenBuffer,4257,1
	.comm	fromBuffer,4257,1
	.comm	screenWidth,4,2
	.comm	screenHeight,4,2
	.align	2
	.globl	init_nncurses
	.type	init_nncurses, @function
init_nncurses:
	link.w %fp,#-8
	moveq #80,%d0
	move.l %d0,screenWidth
	moveq #25,%d0
	move.l %d0,screenHeight
	clr.l -8(%fp)
	jra .L58
.L61:
	clr.l -4(%fp)
	jra .L59
.L60:
	move.l -8(%fp),%d1
	move.l %d1,%d0
	lsl.l #7,%d0
	add.l %d1,%d0
	add.l -4(%fp),%d0
	move.l %d0,%a0
	add.l #screenBuffer,%a0
	move.b #32,(%a0)
	move.l -8(%fp),%d1
	move.l %d1,%d0
	lsl.l #7,%d0
	add.l %d1,%d0
	add.l -4(%fp),%d0
	move.l %d0,%a0
	add.l #fromBuffer,%a0
	move.b #32,(%a0)
	addq.l #1,-4(%fp)
.L59:
	move.l screenWidth,%d0
	cmp.l -4(%fp),%d0
	jge .L60
	addq.l #1,-8(%fp)
.L58:
	move.l screenHeight,%d0
	cmp.l -8(%fp),%d0
	jge .L61
	jsr cls
	nop
	unlk %fp
	rts
	.size	init_nncurses, .-init_nncurses
	.align	2
	.globl	getCharAtXY
	.type	getCharAtXY, @function
getCharAtXY:
	link.w %fp,#0
	move.l 12(%fp),%d1
	move.l %d1,%d0
	lsl.l #7,%d0
	add.l %d1,%d0
	add.l 8(%fp),%d0
	move.l %d0,%a0
	add.l #screenBuffer,%a0
	move.b (%a0),%d0
	unlk %fp
	rts
	.size	getCharAtXY, .-getCharAtXY
	.align	2
	.globl	cls
	.type	cls, @function
cls:
	link.w %fp,#0
	pea 27.w
	jsr putCharA
	addq.l #4,%sp
	pea 91.w
	jsr putCharA
	addq.l #4,%sp
	pea 50.w
	jsr putCharA
	addq.l #4,%sp
	pea 74.w
	jsr putCharA
	addq.l #4,%sp
	nop
	unlk %fp
	rts
	.size	cls, .-cls
	.align	2
	.globl	stringToScreen
	.type	stringToScreen, @function
stringToScreen:
	link.w %fp,#-4
	clr.l -4(%fp)
	move.l 12(%fp),-(%sp)
	move.l 8(%fp),-(%sp)
	jsr positionCursorScreen
	addq.l #8,%sp
	jra .L66
.L67:
	move.l -4(%fp),%d0
	move.l 16(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	ext.w %d0
	move.w %d0,%a0
	move.l %a0,-(%sp)
	jsr putCharA
	addq.l #4,%sp
	addq.l #1,-4(%fp)
.L66:
	move.l -4(%fp),%d0
	move.l 16(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	tst.b %d0
	jne .L67
	nop
	nop
	unlk %fp
	rts
	.size	stringToScreen, .-stringToScreen
	.align	2
	.globl	cursorOnOff
	.type	cursorOnOff, @function
cursorOnOff:
	link.w %fp,#0
	tst.l 8(%fp)
	jne .L69
	pea -101.w
	jsr putCharA
	addq.l #4,%sp
	pea 63.w
	jsr putCharA
	addq.l #4,%sp
	pea 50.w
	jsr putCharA
	addq.l #4,%sp
	pea 53.w
	jsr putCharA
	addq.l #4,%sp
	pea 108.w
	jsr putCharA
	addq.l #4,%sp
	jra .L71
.L69:
	pea -101.w
	jsr putCharA
	addq.l #4,%sp
	pea 63.w
	jsr putCharA
	addq.l #4,%sp
	pea 50.w
	jsr putCharA
	addq.l #4,%sp
	pea 53.w
	jsr putCharA
	addq.l #4,%sp
	pea 107.w
	jsr putCharA
	addq.l #4,%sp
.L71:
	nop
	unlk %fp
	rts
	.size	cursorOnOff, .-cursorOnOff
	.align	2
	.globl	positionCursorScreen
	.type	positionCursorScreen, @function
positionCursorScreen:
	link.w %fp,#-4
	pea 27.w
	jsr putCharA
	addq.l #4,%sp
	pea 91.w
	jsr putCharA
	addq.l #4,%sp
	move.l %fp,%d0
	subq.l #4,%d0
	move.l %d0,-(%sp)
	move.l 12(%fp),-(%sp)
	jsr intToStr
	addq.l #8,%sp
	move.l %fp,%d0
	subq.l #4,%d0
	move.l %d0,-(%sp)
	jsr printString
	addq.l #4,%sp
	pea 59.w
	jsr putCharA
	addq.l #4,%sp
	move.l %fp,%d0
	subq.l #4,%d0
	move.l %d0,-(%sp)
	move.l 8(%fp),-(%sp)
	jsr intToStr
	addq.l #8,%sp
	move.l %fp,%d0
	subq.l #4,%d0
	move.l %d0,-(%sp)
	jsr printString
	addq.l #4,%sp
	pea 72.w
	jsr putCharA
	addq.l #4,%sp
	nop
	unlk %fp
	rts
	.size	positionCursorScreen, .-positionCursorScreen
	.align	2
	.globl	copy_ScreenBuffer_Deltas_to_Screen
	.type	copy_ScreenBuffer_Deltas_to_Screen, @function
copy_ScreenBuffer_Deltas_to_Screen:
	link.w %fp,#-8
	move.l %d2,-(%sp)
	moveq #1,%d0
	move.l %d0,-8(%fp)
	jra .L74
.L78:
	moveq #1,%d0
	move.l %d0,-4(%fp)
	jra .L75
.L77:
	move.l -8(%fp),%d1
	move.l %d1,%d0
	lsl.l #7,%d0
	add.l %d1,%d0
	add.l -4(%fp),%d0
	move.l %d0,%a0
	add.l #fromBuffer,%a0
	move.b (%a0),%d2
	move.l -8(%fp),%d1
	move.l %d1,%d0
	lsl.l #7,%d0
	add.l %d1,%d0
	add.l -4(%fp),%d0
	move.l %d0,%a0
	add.l #screenBuffer,%a0
	move.b (%a0),%d0
	cmp.b %d2,%d0
	jeq .L76
	move.l -8(%fp),%d1
	move.l %d1,%d0
	lsl.l #7,%d0
	add.l %d1,%d0
	add.l -4(%fp),%d0
	move.l %d0,%a0
	add.l #fromBuffer,%a0
	move.b (%a0),%d0
	ext.w %d0
	move.w %d0,%a0
	move.l %a0,-(%sp)
	move.l -8(%fp),-(%sp)
	move.l -4(%fp),-(%sp)
	jsr charToScreen
	lea (12,%sp),%sp
	move.l -8(%fp),%d1
	move.l %d1,%d0
	lsl.l #7,%d0
	add.l %d1,%d0
	add.l -4(%fp),%d0
	move.l %d0,%a0
	add.l #fromBuffer,%a0
	move.b (%a0),%d2
	move.l -8(%fp),%d1
	move.l %d1,%d0
	lsl.l #7,%d0
	add.l %d1,%d0
	add.l -4(%fp),%d0
	move.l %d0,%a0
	add.l #screenBuffer,%a0
	move.b %d2,(%a0)
.L76:
	addq.l #1,-4(%fp)
.L75:
	move.l screenWidth,%d0
	cmp.l -4(%fp),%d0
	jge .L77
	addq.l #1,-8(%fp)
.L74:
	move.l screenHeight,%d0
	cmp.l -8(%fp),%d0
	jge .L78
	nop
	nop
	move.l -12(%fp),%d2
	unlk %fp
	rts
	.size	copy_ScreenBuffer_Deltas_to_Screen, .-copy_ScreenBuffer_Deltas_to_Screen
	.align	2
	.globl	charToScreen
	.type	charToScreen, @function
charToScreen:
	link.w %fp,#-4
	move.l 16(%fp),%d0
	move.b %d0,%d0
	move.b %d0,-2(%fp)
	move.l 12(%fp),-(%sp)
	move.l 8(%fp),-(%sp)
	jsr positionCursorScreen
	addq.l #8,%sp
	move.b -2(%fp),%d0
	ext.w %d0
	move.w %d0,%a0
	move.l %a0,-(%sp)
	jsr putCharA
	addq.l #4,%sp
	nop
	unlk %fp
	rts
	.size	charToScreen, .-charToScreen
	.section	.rodata
.LC0:
	.string	"HITs:"
.LC1:
	.string	"MISSes:"
.LC2:
	.string	"Time:"
	.text
	.align	2
	.globl	playGame
	.type	playGame, @function
playGame:
	link.w %fp,#-112
	moveq #5,%d0
	move.l %d0,-4(%fp)
	moveq #12,%d0
	move.l %d0,-8(%fp)
	moveq #2,%d0
	move.l %d0,-44(%fp)
	moveq #10,%d0
	move.l %d0,-48(%fp)
	moveq #2,%d0
	move.l %d0,-52(%fp)
	moveq #23,%d0
	move.l %d0,-56(%fp)
	moveq #60,%d0
	move.l %d0,-12(%fp)
	moveq #12,%d0
	move.l %d0,-16(%fp)
	moveq #30,%d0
	move.l %d0,-60(%fp)
	moveq #78,%d0
	move.l %d0,-64(%fp)
	moveq #2,%d0
	move.l %d0,-68(%fp)
	moveq #23,%d0
	move.l %d0,-72(%fp)
	moveq #6,%d0
	move.l %d0,-20(%fp)
	moveq #12,%d0
	move.l %d0,-24(%fp)
	clr.l -28(%fp)
	clr.l -32(%fp)
	clr.l -36(%fp)
	clr.l -40(%fp)
	jsr init_nncurses
	jsr drawFrame
	pea .LC0
	pea 25.w
	pea 35.w
	jsr stringToScreen
	lea (12,%sp),%sp
	lea (-90,%fp),%a0
	move.l %a0,-(%sp)
	move.l -36(%fp),-(%sp)
	jsr intToStr
	addq.l #8,%sp
	lea (-90,%fp),%a0
	move.l %a0,-(%sp)
	pea 25.w
	pea 41.w
	jsr stringToScreen
	lea (12,%sp),%sp
	pea .LC1
	pea 25.w
	pea 50.w
	jsr stringToScreen
	lea (12,%sp),%sp
	lea (-100,%fp),%a0
	move.l %a0,-(%sp)
	move.l -40(%fp),-(%sp)
	jsr intToStr
	addq.l #8,%sp
	lea (-100,%fp),%a0
	move.l %a0,-(%sp)
	pea 25.w
	pea 58.w
	jsr stringToScreen
	lea (12,%sp),%sp
	jsr readTimer
	pea 60.w
	move.l %d0,-(%sp)
	jsr __divsi3
	addq.l #8,%sp
	move.l %d0,-76(%fp)
	pea .LC2
	pea 25.w
	pea 65.w
	jsr stringToScreen
	lea (12,%sp),%sp
	jsr readTimer
	pea 60.w
	move.l %d0,-(%sp)
	jsr __divsi3
	addq.l #8,%sp
	sub.l -76(%fp),%d0
	lea (-110,%fp),%a0
	move.l %a0,-(%sp)
	move.l %d0,-(%sp)
	jsr intToStr
	addq.l #8,%sp
	lea (-110,%fp),%a0
	move.l %a0,-(%sp)
	pea 25.w
	pea 71.w
	jsr stringToScreen
	lea (12,%sp),%sp
	move.l -8(%fp),-(%sp)
	move.l -4(%fp),-(%sp)
	jsr positionCursorScreen
	addq.l #8,%sp
	pea 125.w
	jsr putCharA
	addq.l #4,%sp
	move.l -16(%fp),-(%sp)
	move.l -12(%fp),-(%sp)
	jsr positionCursorScreen
	addq.l #8,%sp
	pea 64.w
	jsr putCharA
	addq.l #4,%sp
	pea 25.w
	pea 40.w
	jsr positionCursorScreen
	addq.l #8,%sp
	jsr copy_ScreenBuffer_Deltas_to_Screen
	jra .L81
.L100:
	jsr rxStatPortA
	cmp.b #1,%d0
	jne .L82
	jsr getKeyboard
	move.l %d0,-80(%fp)
	tst.l -80(%fp)
	jne .L83
	moveq #1,%d0
	move.l %d0,-32(%fp)
	jra .L82
.L83:
	moveq #1,%d0
	cmp.l -80(%fp),%d0
	jne .L84
	move.l -8(%fp),-(%sp)
	move.l -4(%fp),-(%sp)
	jsr positionCursorScreen
	addq.l #8,%sp
	pea 32.w
	jsr putCharA
	addq.l #4,%sp
	subq.l #1,-8(%fp)
	move.l -8(%fp),%d0
	cmp.l -52(%fp),%d0
	jge .L85
	move.l -52(%fp),-8(%fp)
.L85:
	move.l -8(%fp),-(%sp)
	move.l -4(%fp),-(%sp)
	jsr positionCursorScreen
	addq.l #8,%sp
	pea 125.w
	jsr putCharA
	addq.l #4,%sp
	jsr copy_ScreenBuffer_Deltas_to_Screen
	jra .L82
.L84:
	moveq #2,%d0
	cmp.l -80(%fp),%d0
	jne .L86
	move.l -8(%fp),-(%sp)
	move.l -4(%fp),-(%sp)
	jsr positionCursorScreen
	addq.l #8,%sp
	pea 32.w
	jsr putCharA
	addq.l #4,%sp
	addq.l #1,-8(%fp)
	move.l -8(%fp),%d0
	cmp.l -56(%fp),%d0
	jle .L87
	move.l -56(%fp),-8(%fp)
.L87:
	move.l -8(%fp),-(%sp)
	move.l -4(%fp),-(%sp)
	jsr positionCursorScreen
	addq.l #8,%sp
	pea 125.w
	jsr putCharA
	addq.l #4,%sp
	jsr copy_ScreenBuffer_Deltas_to_Screen
	jra .L82
.L86:
	moveq #3,%d0
	cmp.l -80(%fp),%d0
	jne .L88
	move.l -8(%fp),-(%sp)
	move.l -4(%fp),-(%sp)
	jsr positionCursorScreen
	addq.l #8,%sp
	pea 32.w
	jsr putCharA
	addq.l #4,%sp
	addq.l #1,-4(%fp)
	move.l -4(%fp),%d0
	cmp.l -48(%fp),%d0
	jle .L89
	move.l -48(%fp),-4(%fp)
.L89:
	move.l -8(%fp),-(%sp)
	move.l -4(%fp),-(%sp)
	jsr positionCursorScreen
	addq.l #8,%sp
	pea 125.w
	jsr putCharA
	addq.l #4,%sp
	jsr copy_ScreenBuffer_Deltas_to_Screen
	jra .L82
.L88:
	moveq #4,%d0
	cmp.l -80(%fp),%d0
	jne .L90
	move.l -8(%fp),-(%sp)
	move.l -4(%fp),-(%sp)
	jsr positionCursorScreen
	addq.l #8,%sp
	pea 32.w
	jsr putCharA
	addq.l #4,%sp
	subq.l #1,-4(%fp)
	move.l -4(%fp),%d0
	cmp.l -44(%fp),%d0
	jge .L91
	move.l -44(%fp),-4(%fp)
.L91:
	move.l -8(%fp),-(%sp)
	move.l -4(%fp),-(%sp)
	jsr positionCursorScreen
	addq.l #8,%sp
	pea 125.w
	jsr putCharA
	addq.l #4,%sp
	jsr copy_ScreenBuffer_Deltas_to_Screen
	jra .L82
.L90:
	moveq #5,%d0
	cmp.l -80(%fp),%d0
	jne .L82
	tst.l -28(%fp)
	jne .L82
	move.l -4(%fp),%d0
	addq.l #1,%d0
	move.l %d0,-20(%fp)
	move.l -8(%fp),-24(%fp)
	move.l -24(%fp),-(%sp)
	move.l -20(%fp),-(%sp)
	jsr positionCursorScreen
	addq.l #8,%sp
	pea 45.w
	jsr putCharA
	addq.l #4,%sp
	jsr copy_ScreenBuffer_Deltas_to_Screen
	moveq #1,%d0
	move.l %d0,-28(%fp)
.L82:
	move.l -16(%fp),-(%sp)
	move.l -12(%fp),-(%sp)
	jsr positionCursorScreen
	addq.l #8,%sp
	pea 32.w
	jsr putCharA
	addq.l #4,%sp
	pea 1.w
	pea -1.w
	jsr randomNum
	addq.l #8,%sp
	add.l %d0,-12(%fp)
	move.l -12(%fp),%d0
	cmp.l -60(%fp),%d0
	jge .L92
	move.l -60(%fp),-12(%fp)
	jra .L93
.L92:
	move.l -12(%fp),%d0
	cmp.l -64(%fp),%d0
	jle .L93
	move.l -64(%fp),-12(%fp)
.L93:
	pea 1.w
	pea -1.w
	jsr randomNum
	addq.l #8,%sp
	add.l %d0,-16(%fp)
	move.l -16(%fp),%d0
	cmp.l -68(%fp),%d0
	jge .L94
	move.l -68(%fp),-16(%fp)
	jra .L95
.L94:
	move.l -16(%fp),%d0
	cmp.l -72(%fp),%d0
	jle .L95
	move.l -72(%fp),-16(%fp)
.L95:
	move.l -16(%fp),-(%sp)
	move.l -12(%fp),-(%sp)
	jsr positionCursorScreen
	addq.l #8,%sp
	pea 64.w
	jsr putCharA
	addq.l #4,%sp
	moveq #1,%d0
	cmp.l -28(%fp),%d0
	jne .L96
	move.l -24(%fp),-(%sp)
	move.l -20(%fp),-(%sp)
	jsr positionCursorScreen
	addq.l #8,%sp
	pea 32.w
	jsr putCharA
	addq.l #4,%sp
	addq.l #1,-20(%fp)
	moveq #79,%d0
	cmp.l -20(%fp),%d0
	jlt .L97
	move.l -20(%fp),%d0
	cmp.l -12(%fp),%d0
	jne .L98
	move.l -24(%fp),%d0
	cmp.l -16(%fp),%d0
	jne .L98
	addq.l #1,-36(%fp)
	clr.l -28(%fp)
	lea (-90,%fp),%a0
	move.l %a0,-(%sp)
	move.l -36(%fp),-(%sp)
	jsr intToStr
	addq.l #8,%sp
	lea (-90,%fp),%a0
	move.l %a0,-(%sp)
	pea 25.w
	pea 41.w
	jsr stringToScreen
	lea (12,%sp),%sp
	move.l -24(%fp),-(%sp)
	move.l -20(%fp),-(%sp)
	jsr explosion
	addq.l #8,%sp
	jra .L96
.L98:
	move.l -24(%fp),-(%sp)
	move.l -20(%fp),-(%sp)
	jsr positionCursorScreen
	addq.l #8,%sp
	pea 45.w
	jsr putCharA
	addq.l #4,%sp
	jra .L96
.L97:
	addq.l #1,-40(%fp)
	clr.l -28(%fp)
	lea (-100,%fp),%a0
	move.l %a0,-(%sp)
	move.l -40(%fp),-(%sp)
	jsr intToStr
	addq.l #8,%sp
	lea (-100,%fp),%a0
	move.l %a0,-(%sp)
	pea 25.w
	pea 58.w
	jsr stringToScreen
	lea (12,%sp),%sp
.L96:
	jsr readTimer
	pea 60.w
	move.l %d0,-(%sp)
	jsr __divsi3
	addq.l #8,%sp
	sub.l -76(%fp),%d0
	lea (-110,%fp),%a0
	move.l %a0,-(%sp)
	move.l %d0,-(%sp)
	jsr intToStr
	addq.l #8,%sp
	lea (-110,%fp),%a0
	move.l %a0,-(%sp)
	pea 25.w
	pea 71.w
	jsr stringToScreen
	lea (12,%sp),%sp
	jsr copy_ScreenBuffer_Deltas_to_Screen
.L81:
	tst.l -32(%fp)
	jeq .L100
	jsr cls
	pea 1.w
	pea 1.w
	jsr positionCursorScreen
	addq.l #8,%sp
	jsr copy_ScreenBuffer_Deltas_to_Screen
	moveq #1,%d0
	unlk %fp
	rts
	.size	playGame, .-playGame
	.align	2
	.globl	explosion
	.type	explosion, @function
explosion:
	link.w %fp,#-4
	move.b #33,-1(%fp)
	jra .L103
.L104:
	move.l 12(%fp),-(%sp)
	move.l 8(%fp),-(%sp)
	jsr positionCursorScreen
	addq.l #8,%sp
	move.b -1(%fp),%d0
	ext.w %d0
	move.w %d0,%a0
	move.l %a0,-(%sp)
	jsr putCharA
	addq.l #4,%sp
	pea 25.w
	pea 79.w
	jsr positionCursorScreen
	addq.l #8,%sp
	jsr copy_ScreenBuffer_Deltas_to_Screen
	move.b -1(%fp),%d0
	addq.b #1,%d0
	move.b %d0,-1(%fp)
.L103:
	cmp.b #46,-1(%fp)
	jle .L104
	move.l 12(%fp),-(%sp)
	move.l 8(%fp),-(%sp)
	jsr positionCursorScreen
	addq.l #8,%sp
	pea 42.w
	jsr putCharA
	addq.l #4,%sp
	nop
	unlk %fp
	rts
	.size	explosion, .-explosion
	.section	.rodata
.LC3:
	.string	"Arrows=move, Space=fire, (Q)uit"
	.text
	.align	2
	.globl	drawFrame
	.type	drawFrame, @function
drawFrame:
	link.w %fp,#-8
	moveq #1,%d0
	move.l %d0,-8(%fp)
	moveq #1,%d0
	move.l %d0,-4(%fp)
	jra .L106
.L107:
	move.l -8(%fp),%d1
	move.l %d1,%d0
	lsl.l #7,%d0
	add.l %d1,%d0
	add.l -4(%fp),%d0
	move.l %d0,%a0
	add.l #fromBuffer,%a0
	move.b #35,(%a0)
	addq.l #1,-4(%fp)
.L106:
	moveq #80,%d0
	cmp.l -4(%fp),%d0
	jge .L107
	moveq #24,%d0
	move.l %d0,-8(%fp)
	moveq #1,%d0
	move.l %d0,-4(%fp)
	jra .L108
.L109:
	move.l -8(%fp),%d1
	move.l %d1,%d0
	lsl.l #7,%d0
	add.l %d1,%d0
	add.l -4(%fp),%d0
	move.l %d0,%a0
	add.l #fromBuffer,%a0
	move.b #35,(%a0)
	addq.l #1,-4(%fp)
.L108:
	moveq #80,%d0
	cmp.l -4(%fp),%d0
	jge .L109
	moveq #1,%d0
	move.l %d0,-4(%fp)
	moveq #2,%d0
	move.l %d0,-8(%fp)
	jra .L110
.L111:
	move.l -8(%fp),%d1
	move.l %d1,%d0
	lsl.l #7,%d0
	add.l %d1,%d0
	add.l -4(%fp),%d0
	move.l %d0,%a0
	add.l #fromBuffer,%a0
	move.b #35,(%a0)
	addq.l #1,-8(%fp)
.L110:
	moveq #24,%d0
	cmp.l -8(%fp),%d0
	jge .L111
	moveq #80,%d0
	move.l %d0,-4(%fp)
	moveq #2,%d0
	move.l %d0,-8(%fp)
	jra .L112
.L113:
	move.l -8(%fp),%d1
	move.l %d1,%d0
	lsl.l #7,%d0
	add.l %d1,%d0
	add.l -4(%fp),%d0
	move.l %d0,%a0
	add.l #fromBuffer,%a0
	move.b #35,(%a0)
	addq.l #1,-8(%fp)
.L112:
	moveq #24,%d0
	cmp.l -8(%fp),%d0
	jge .L113
	pea .LC3
	pea 25.w
	pea 1.w
	jsr stringToScreen
	lea (12,%sp),%sp
	nop
	unlk %fp
	rts
	.size	drawFrame, .-drawFrame
	.align	2
	.globl	getKeyboard
	.type	getKeyboard, @function
getKeyboard:
	link.w %fp,#-4
	jsr getCharA
	move.b %d0,-1(%fp)
	cmp.b #113,-1(%fp)
	jne .L115
	moveq #0,%d0
	jra .L116
.L115:
	cmp.b #81,-1(%fp)
	jne .L117
	moveq #0,%d0
	jra .L116
.L117:
	cmp.b #32,-1(%fp)
	jne .L118
	moveq #5,%d0
	jra .L116
.L118:
	cmp.b #27,-1(%fp)
	jne .L119
	jsr getCharA
	move.b %d0,-1(%fp)
	cmp.b #91,-1(%fp)
	jne .L119
	jsr getCharA
	move.b %d0,-1(%fp)
	cmp.b #65,-1(%fp)
	jne .L120
	moveq #1,%d0
	jra .L116
.L120:
	cmp.b #66,-1(%fp)
	jne .L121
	moveq #2,%d0
	jra .L116
.L121:
	cmp.b #67,-1(%fp)
	jne .L122
	moveq #3,%d0
	jra .L116
.L122:
	cmp.b #68,-1(%fp)
	jne .L119
	moveq #4,%d0
	jra .L116
.L119:
	moveq #6,%d0
.L116:
	unlk %fp
	rts
	.size	getKeyboard, .-getKeyboard
	.globl	__umodsi3
	.align	2
	.globl	randomNum
	.type	randomNum, @function
randomNum:
	link.w %fp,#-8
	jsr readTimer
	move.l %d0,-4(%fp)
	move.l 12(%fp),%d0
	sub.l 8(%fp),%d0
	addq.l #1,%d0
	move.l %d0,%d1
	move.l -4(%fp),%d0
	move.l %d1,-(%sp)
	move.l %d0,-(%sp)
	jsr __umodsi3
	addq.l #8,%sp
	move.l %d0,-8(%fp)
	move.l 8(%fp),%d0
	add.l %d0,-8(%fp)
	move.l -8(%fp),%d0
	unlk %fp
	rts
	.size	randomNum, .-randomNum
	.align	2
	.globl	readTimer
	.type	readTimer, @function
readTimer:
	link.w %fp,#-8
	move.l #1032,-4(%fp)
	move.l -4(%fp),%a0
	move.l (%a0),-8(%fp)
	move.l -8(%fp),%d0
	unlk %fp
	rts
	.size	readTimer, .-readTimer
	.ident	"GCC: (GNU) 9.3.1 20200817"

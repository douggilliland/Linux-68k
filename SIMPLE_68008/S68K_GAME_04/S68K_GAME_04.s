#NO_APP
	.file	"S68K_GAME_04.c"
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
	link.w %fp,#-8
	clr.l -4(%fp)
	move.l 8(%fp),-8(%fp)
	jra .L64
.L65:
	move.l -4(%fp),%d0
	move.l 16(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	ext.w %d0
	move.w %d0,%a0
	move.l %a0,-(%sp)
	move.l 12(%fp),-(%sp)
	move.l -8(%fp),-(%sp)
	jsr charToScreen
	lea (12,%sp),%sp
	addq.l #1,-8(%fp)
	addq.l #1,-4(%fp)
.L64:
	move.l -4(%fp),%d0
	move.l 16(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	tst.b %d0
	jne .L65
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
	jne .L67
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
	jra .L69
.L67:
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
.L69:
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
	jra .L72
.L76:
	moveq #1,%d0
	move.l %d0,-4(%fp)
	jra .L73
.L75:
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
	jeq .L74
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
.L74:
	addq.l #1,-4(%fp)
.L73:
	move.l screenWidth,%d0
	cmp.l -4(%fp),%d0
	jge .L75
	addq.l #1,-8(%fp)
.L72:
	move.l screenHeight,%d0
	cmp.l -8(%fp),%d0
	jge .L76
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
	.align	2
	.globl	playGame
	.type	playGame, @function
playGame:
	link.w %fp,#-16
	clr.l -12(%fp)
	jsr init_nncurses
	moveq #40,%d0
	move.l %d0,-4(%fp)
	moveq #12,%d0
	move.l %d0,-8(%fp)
	move.l -8(%fp),%d1
	move.l %d1,%d0
	lsl.l #7,%d0
	add.l %d1,%d0
	add.l -4(%fp),%d0
	move.l %d0,%a0
	add.l #fromBuffer,%a0
	move.b #42,(%a0)
	jsr copy_ScreenBuffer_Deltas_to_Screen
	jra .L79
.L88:
	jsr getKeyboard
	move.b %d0,-13(%fp)
	tst.b -13(%fp)
	jne .L80
	moveq #1,%d0
	move.l %d0,-12(%fp)
	jra .L79
.L80:
	cmp.b #1,-13(%fp)
	jne .L81
	move.l -8(%fp),%d1
	move.l %d1,%d0
	lsl.l #7,%d0
	add.l %d1,%d0
	add.l -4(%fp),%d0
	move.l %d0,%a0
	add.l #fromBuffer,%a0
	move.b #32,(%a0)
	subq.l #1,-8(%fp)
	tst.l -8(%fp)
	jne .L82
	moveq #1,%d0
	move.l %d0,-8(%fp)
.L82:
	move.l -8(%fp),%d1
	move.l %d1,%d0
	lsl.l #7,%d0
	add.l %d1,%d0
	add.l -4(%fp),%d0
	move.l %d0,%a0
	add.l #fromBuffer,%a0
	move.b #42,(%a0)
	jsr copy_ScreenBuffer_Deltas_to_Screen
	jra .L79
.L81:
	cmp.b #2,-13(%fp)
	jne .L83
	move.l -8(%fp),%d1
	move.l %d1,%d0
	lsl.l #7,%d0
	add.l %d1,%d0
	add.l -4(%fp),%d0
	move.l %d0,%a0
	add.l #fromBuffer,%a0
	move.b #32,(%a0)
	addq.l #1,-8(%fp)
	moveq #25,%d0
	cmp.l -8(%fp),%d0
	jge .L84
	moveq #25,%d0
	move.l %d0,-8(%fp)
.L84:
	move.l -8(%fp),%d1
	move.l %d1,%d0
	lsl.l #7,%d0
	add.l %d1,%d0
	add.l -4(%fp),%d0
	move.l %d0,%a0
	add.l #fromBuffer,%a0
	move.b #42,(%a0)
	jsr copy_ScreenBuffer_Deltas_to_Screen
	jra .L79
.L83:
	cmp.b #3,-13(%fp)
	jne .L85
	move.l -8(%fp),%d1
	move.l %d1,%d0
	lsl.l #7,%d0
	add.l %d1,%d0
	add.l -4(%fp),%d0
	move.l %d0,%a0
	add.l #fromBuffer,%a0
	move.b #32,(%a0)
	addq.l #1,-4(%fp)
	moveq #81,%d0
	cmp.l -4(%fp),%d0
	jne .L86
	moveq #80,%d0
	move.l %d0,-4(%fp)
.L86:
	move.l -8(%fp),%d1
	move.l %d1,%d0
	lsl.l #7,%d0
	add.l %d1,%d0
	add.l -4(%fp),%d0
	move.l %d0,%a0
	add.l #fromBuffer,%a0
	move.b #42,(%a0)
	jsr copy_ScreenBuffer_Deltas_to_Screen
	jra .L79
.L85:
	cmp.b #4,-13(%fp)
	jne .L79
	move.l -8(%fp),%d1
	move.l %d1,%d0
	lsl.l #7,%d0
	add.l %d1,%d0
	add.l -4(%fp),%d0
	move.l %d0,%a0
	add.l #fromBuffer,%a0
	move.b #32,(%a0)
	subq.l #1,-4(%fp)
	tst.l -4(%fp)
	jne .L87
	moveq #1,%d0
	move.l %d0,-4(%fp)
.L87:
	move.l -8(%fp),%d1
	move.l %d1,%d0
	lsl.l #7,%d0
	add.l %d1,%d0
	add.l -4(%fp),%d0
	move.l %d0,%a0
	add.l #fromBuffer,%a0
	move.b #42,(%a0)
	jsr copy_ScreenBuffer_Deltas_to_Screen
.L79:
	tst.l -12(%fp)
	jeq .L88
	moveq #1,%d0
	unlk %fp
	rts
	.size	playGame, .-playGame
	.align	2
	.globl	getKeyboard
	.type	getKeyboard, @function
getKeyboard:
	link.w %fp,#-4
	jsr getCharA
	move.b %d0,-1(%fp)
	cmp.b #113,-1(%fp)
	jne .L91
	moveq #0,%d0
	jra .L92
.L91:
	cmp.b #81,-1(%fp)
	jne .L93
	moveq #0,%d0
	jra .L92
.L93:
	cmp.b #27,-1(%fp)
	jne .L94
	jsr getCharA
	move.b %d0,-1(%fp)
	cmp.b #91,-1(%fp)
	jne .L94
	jsr getCharA
	move.b %d0,-1(%fp)
	cmp.b #65,-1(%fp)
	jne .L95
	moveq #1,%d0
	jra .L92
.L95:
	cmp.b #66,-1(%fp)
	jne .L96
	moveq #2,%d0
	jra .L92
.L96:
	cmp.b #67,-1(%fp)
	jne .L97
	moveq #3,%d0
	jra .L92
.L97:
	cmp.b #68,-1(%fp)
	jne .L94
	moveq #4,%d0
	jra .L92
.L94:
	moveq #5,%d0
.L92:
	unlk %fp
	rts
	.size	getKeyboard, .-getKeyboard
	.ident	"GCC: (GNU) 9.3.1 20200817"

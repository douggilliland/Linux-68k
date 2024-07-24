#NO_APP
	.file	"S68K_GAME_02.c"
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
	.globl	getCharA
	.type	getCharA, @function
getCharA:
	link.w %fp,#-12
	move.l #983042,-6(%fp)
	move.l #983046,-10(%fp)
	clr.b -1(%fp)
	jra .L8
.L9:
	move.l -6(%fp),%a0
	move.b (%a0),-1(%fp)
	and.b #1,-1(%fp)
.L8:
	tst.b -1(%fp)
	jeq .L9
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
	jra .L16
.L17:
	move.l -6(%fp),%a0
	move.b (%a0),%d0
	move.b %d0,-1(%fp)
	and.b #4,-1(%fp)
.L16:
	tst.b -1(%fp)
	jeq .L17
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
	jra .L19
.L20:
	move.l -6(%fp),%a0
	move.b (%a0),%d0
	move.b %d0,-1(%fp)
	and.b #4,-1(%fp)
.L19:
	tst.b -1(%fp)
	jeq .L20
	move.b -12(%fp),%d0
	move.l -10(%fp),%a0
	move.b %d0,(%a0)
	nop
	unlk %fp
	rts
	.size	putCharB, .-putCharB
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
	jge .L23
	moveq #1,%d0
	move.l %d0,-8(%fp)
	neg.l 8(%fp)
.L23:
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
	jgt .L23
	tst.l -8(%fp)
	jeq .L24
	move.l -4(%fp),%d0
	move.l %d0,%d1
	addq.l #1,%d1
	move.l %d1,-4(%fp)
	move.l 12(%fp),%a0
	add.l %d0,%a0
	move.b #45,(%a0)
.L24:
	move.l -4(%fp),%d0
	move.l 12(%fp),%a0
	add.l %d0,%a0
	clr.b (%a0)
	clr.l -12(%fp)
	jra .L25
.L26:
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
.L25:
	move.l -4(%fp),%d0
	move.l %d0,%d1
	add.l %d1,%d1
	subx.l %d1,%d1
	neg.l %d1
	add.l %d1,%d0
	asr.l #1,%d0
	cmp.l -12(%fp),%d0
	jgt .L26
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
	jne .L28
	move.l -4(%fp),%d0
	jra .L29
.L28:
	clr.l -8(%fp)
	jra .L30
.L31:
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
.L30:
	move.l 8(%fp),-(%sp)
	jsr strlen
	addq.l #4,%sp
	cmp.l -8(%fp),%d0
	jgt .L31
	move.l -4(%fp),%d0
.L29:
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
	jra .L33
.L37:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	cmp.b #57,%d0
	jle .L34
	moveq #0,%d0
	jra .L35
.L34:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	cmp.b #47,%d0
	jgt .L36
	moveq #0,%d0
	jra .L35
.L36:
	addq.l #1,-4(%fp)
.L33:
	move.l -4(%fp),%d0
	cmp.l -8(%fp),%d0
	jlt .L37
	moveq #1,%d0
.L35:
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
	jra .L39
.L43:
	jsr getCharA
	move.b %d0,-9(%fp)
	move.l 8(%fp),%a0
	move.b -9(%fp),(%a0)
	addq.l #1,8(%fp)
	addq.l #1,-4(%fp)
	clr.l -8(%fp)
	moveq #78,%d0
	cmp.l -4(%fp),%d0
	jge .L40
	moveq #1,%d0
	move.l %d0,-8(%fp)
	jra .L41
.L40:
	cmp.b #10,-9(%fp)
	jne .L42
	moveq #1,%d0
	move.l %d0,-8(%fp)
	jra .L41
.L42:
	cmp.b #13,-9(%fp)
	jne .L41
	moveq #1,%d0
	move.l %d0,-8(%fp)
.L41:
	move.b -9(%fp),%d0
	ext.w %d0
	move.w %d0,%a0
	move.l %a0,-(%sp)
	jsr putCharA
	addq.l #4,%sp
.L39:
	tst.l -8(%fp)
	jeq .L43
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
	jra .L46
.L47:
	move.l 8(%fp),%a0
	add.l -4(%fp),%a0
	move.b (%a0),%d0
	ext.w %d0
	move.w %d0,%a0
	move.l %a0,-(%sp)
	jsr putCharA
	addq.l #4,%sp
	addq.l #1,-4(%fp)
.L46:
	move.l 8(%fp),-(%sp)
	jsr strlen
	addq.l #4,%sp
	cmp.l -4(%fp),%d0
	jhi .L47
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
	jra .L49
.L50:
	addq.l #1,-4(%fp)
.L49:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	tst.b %d0
	jne .L50
	move.l -4(%fp),%d0
	unlk %fp
	rts
	.size	strlen, .-strlen
	.section	.rodata
.LC0:
	.string	"Guess a number from 1 to 99\n\r"
.LC1:
	.string	"Hit a key to create random number\n\r"
.LC2:
	.string	"\n\r"
.LC3:
	.string	"Guess #"
.LC4:
	.string	"Number is too high\n\r"
.LC5:
	.string	"Number is too low\n\r"
.LC6:
	.string	"Good job, you got it in "
.LC7:
	.string	" tries\n\r"
	.text
	.align	2
	.globl	playGame
	.type	playGame, @function
playGame:
	link.w %fp,#-96
	moveq #1,%d0
	move.l %d0,-4(%fp)
	pea .LC0
	jsr printString
	addq.l #4,%sp
	pea .LC1
	jsr printString
	addq.l #4,%sp
	jsr makeSeedFromKeyWait
	move.l %d0,-8(%fp)
	move.l -8(%fp),%d0
	pea 100.w
	move.l %d0,-(%sp)
	jsr __modsi3
	addq.l #8,%sp
	move.l %d0,-12(%fp)
	pea .LC2
	jsr printString
	addq.l #4,%sp
.L57:
	pea .LC3
	jsr printString
	addq.l #4,%sp
	lea (-96,%fp),%a0
	move.l %a0,-(%sp)
	move.l -4(%fp),-(%sp)
	jsr intToStr
	addq.l #8,%sp
	lea (-96,%fp),%a0
	move.l %a0,-(%sp)
	jsr printString
	addq.l #4,%sp
	pea .LC2
	jsr printString
	addq.l #4,%sp
	lea (-96,%fp),%a0
	move.l %a0,-(%sp)
	jsr getString
	addq.l #4,%sp
	pea .LC2
	jsr printString
	addq.l #4,%sp
	lea (-96,%fp),%a0
	move.l %a0,-(%sp)
	jsr strToNum
	addq.l #4,%sp
	move.l %d0,-16(%fp)
	move.l -16(%fp),%d0
	cmp.l -12(%fp),%d0
	jle .L53
	pea .LC4
	jsr printString
	addq.l #4,%sp
	jra .L54
.L53:
	move.l -16(%fp),%d0
	cmp.l -12(%fp),%d0
	jge .L55
	pea .LC5
	jsr printString
	addq.l #4,%sp
	jra .L54
.L55:
	pea .LC6
	jsr printString
	addq.l #4,%sp
	lea (-96,%fp),%a0
	move.l %a0,-(%sp)
	move.l -4(%fp),-(%sp)
	jsr intToStr
	addq.l #8,%sp
	lea (-96,%fp),%a0
	move.l %a0,-(%sp)
	jsr printString
	addq.l #4,%sp
	pea .LC7
	jsr printString
	addq.l #4,%sp
	moveq #0,%d0
	jra .L58
.L54:
	addq.l #1,-4(%fp)
	jra .L57
.L58:
	unlk %fp
	rts
	.size	playGame, .-playGame
	.ident	"GCC: (GNU) 9.3.1 20200817"

#NO_APP
	.file	"S68K_GAME_01.c"
	.text
	.section	.rodata
.LC0:
	.string	"Guess a number from 1 to 99\n\r"
.LC1:
	.string	"Guess #"
.LC2:
	.string	"\n\r"
.LC3:
	.string	"Number is too high\n\r"
.LC4:
	.string	"Number is too low\n\r"
.LC5:
	.string	"Good job, you got it in "
.LC6:
	.string	" tries\n\r"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	link.w %fp,#-88
	clr.l -4(%fp)
	pea .LC0
	jsr printString
	addq.l #4,%sp
.L6:
	pea .LC1
	jsr printString
	addq.l #4,%sp
	lea (-88,%fp),%a0
	move.l %a0,-(%sp)
	move.l -4(%fp),-(%sp)
	jsr intToStr
	addq.l #8,%sp
	lea (-88,%fp),%a0
	move.l %a0,-(%sp)
	jsr printString
	addq.l #4,%sp
	pea .LC2
	jsr printString
	addq.l #4,%sp
	lea (-88,%fp),%a0
	move.l %a0,-(%sp)
	jsr getString
	addq.l #4,%sp
	pea .LC2
	jsr printString
	addq.l #4,%sp
	lea (-88,%fp),%a0
	move.l %a0,-(%sp)
	jsr strToNum
	addq.l #4,%sp
	move.l %d0,-8(%fp)
	moveq #50,%d0
	cmp.l -8(%fp),%d0
	jge .L2
	pea .LC3
	jsr printString
	addq.l #4,%sp
	jra .L3
.L2:
	moveq #49,%d0
	cmp.l -8(%fp),%d0
	jlt .L4
	pea .LC4
	jsr printString
	addq.l #4,%sp
	jra .L3
.L4:
	pea .LC5
	jsr printString
	addq.l #4,%sp
	lea (-88,%fp),%a0
	move.l %a0,-(%sp)
	move.l -4(%fp),-(%sp)
	jsr intToStr
	addq.l #8,%sp
	lea (-88,%fp),%a0
	move.l %a0,-(%sp)
	jsr printString
	addq.l #4,%sp
	pea .LC6
	jsr printString
	addq.l #4,%sp
	moveq #0,%d0
	jra .L7
.L3:
	addq.l #1,-4(%fp)
	jra .L6
.L7:
	unlk %fp
	rts
	.size	main, .-main
	.align	2
	.globl	getCharA
	.type	getCharA, @function
getCharA:
	link.w %fp,#-12
	move.l #983042,-6(%fp)
	move.l #983046,-10(%fp)
	clr.b -1(%fp)
	jra .L9
.L10:
	move.l -6(%fp),%a0
	move.b (%a0),-1(%fp)
	and.b #1,-1(%fp)
.L9:
	tst.b -1(%fp)
	jeq .L10
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
	jra .L13
.L14:
	move.l -6(%fp),%a0
	move.b (%a0),-1(%fp)
	and.b #1,-1(%fp)
.L13:
	tst.b -1(%fp)
	jeq .L14
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
	jra .L17
.L18:
	move.l -6(%fp),%a0
	move.b (%a0),%d0
	move.b %d0,-1(%fp)
	and.b #4,-1(%fp)
.L17:
	tst.b -1(%fp)
	jeq .L18
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
	jge .L24
	moveq #1,%d0
	move.l %d0,-8(%fp)
	neg.l 8(%fp)
.L24:
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
	jgt .L24
	tst.l -8(%fp)
	jeq .L25
	move.l -4(%fp),%d0
	move.l %d0,%d1
	addq.l #1,%d1
	move.l %d1,-4(%fp)
	move.l 12(%fp),%a0
	add.l %d0,%a0
	move.b #45,(%a0)
.L25:
	move.l -4(%fp),%d0
	move.l 12(%fp),%a0
	add.l %d0,%a0
	clr.b (%a0)
	clr.l -12(%fp)
	jra .L26
.L27:
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
.L26:
	move.l -4(%fp),%d0
	move.l %d0,%d1
	add.l %d1,%d1
	subx.l %d1,%d1
	neg.l %d1
	add.l %d1,%d0
	asr.l #1,%d0
	cmp.l -12(%fp),%d0
	jgt .L27
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
	jne .L29
	move.l -4(%fp),%d0
	jra .L30
.L29:
	clr.l -8(%fp)
	jra .L31
.L32:
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
.L31:
	move.l 8(%fp),-(%sp)
	jsr strlen
	addq.l #4,%sp
	cmp.l -8(%fp),%d0
	jgt .L32
	move.l -4(%fp),%d0
.L30:
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
	jra .L34
.L38:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	cmp.b #57,%d0
	jle .L35
	moveq #0,%d0
	jra .L36
.L35:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	cmp.b #47,%d0
	jgt .L37
	moveq #0,%d0
	jra .L36
.L37:
	addq.l #1,-4(%fp)
.L34:
	move.l -4(%fp),%d0
	cmp.l -8(%fp),%d0
	jlt .L38
	moveq #1,%d0
.L36:
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
	jra .L40
.L44:
	jsr getCharA
	move.b %d0,-9(%fp)
	move.l 8(%fp),%a0
	move.b -9(%fp),(%a0)
	addq.l #1,-4(%fp)
	clr.l -8(%fp)
	moveq #78,%d0
	cmp.l -4(%fp),%d0
	jge .L41
	moveq #1,%d0
	move.l %d0,-8(%fp)
	jra .L40
.L41:
	cmp.b #10,-9(%fp)
	jne .L42
	move.l 8(%fp),%a0
	clr.b (%a0)
	moveq #1,%d0
	move.l %d0,-8(%fp)
	jra .L40
.L42:
	cmp.b #13,-9(%fp)
	jne .L43
	move.l 8(%fp),%a0
	clr.b (%a0)
	moveq #1,%d0
	move.l %d0,-8(%fp)
	jra .L40
.L43:
	move.b -9(%fp),%d0
	ext.w %d0
	move.w %d0,%a0
	move.l %a0,-(%sp)
	jsr putCharA
	addq.l #4,%sp
	addq.l #1,8(%fp)
.L40:
	tst.l -8(%fp)
	jeq .L44
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
	jra .L47
.L48:
	move.l 8(%fp),%a0
	add.l -4(%fp),%a0
	move.b (%a0),%d0
	ext.w %d0
	move.w %d0,%a0
	move.l %a0,-(%sp)
	jsr putCharA
	addq.l #4,%sp
	addq.l #1,-4(%fp)
.L47:
	move.l 8(%fp),-(%sp)
	jsr strlen
	addq.l #4,%sp
	cmp.l -4(%fp),%d0
	jhi .L48
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
	jra .L50
.L51:
	addq.l #1,-4(%fp)
.L50:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	tst.b %d0
	jne .L51
	move.l -4(%fp),%d0
	unlk %fp
	rts
	.size	strlen, .-strlen
	.ident	"GCC: (GNU) 9.3.1 20200817"

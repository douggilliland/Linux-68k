#NO_APP
	.file	"S68K_005.c"
	.text
	.section	.rodata
.LC0:
	.string	"Turn on LED for a second\n\r"
.LC1:
	.string	"Type a string\n\r"
.LC2:
	.string	"\n\r"
.LC3:
	.string	"String non-zero length\n\r"
.LC4:
	.string	"String was zero length\n\r"
.LC5:
	.string	"Test String to number\n\r"
.LC6:
	.string	"12345"
.LC7:
	.string	"string to number = OK\n\r"
.LC8:
	.string	"str to num BAD\n\r"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	link.w %fp,#-96
	move.l #983066,-4(%fp)
	move.l -4(%fp),%a0
	clr.b (%a0)
	pea .LC0
	jsr printString
	addq.l #4,%sp
	pea 1.w
	jsr setLED
	addq.l #4,%sp
	pea .LC1
	jsr printString
	addq.l #4,%sp
	lea (-93,%fp),%a0
	move.l %a0,-(%sp)
	jsr getString
	addq.l #4,%sp
	move.l %d0,-8(%fp)
	pea .LC2
	jsr printString
	addq.l #4,%sp
	clr.l -(%sp)
	jsr setLED
	addq.l #4,%sp
	tst.l -8(%fp)
	jle .L2
	pea .LC3
	jsr printString
	addq.l #4,%sp
	jra .L3
.L2:
	pea .LC4
	jsr printString
	addq.l #4,%sp
.L3:
	lea (-93,%fp),%a0
	move.l %a0,-(%sp)
	jsr printString
	addq.l #4,%sp
	pea .LC2
	jsr printString
	addq.l #4,%sp
	jsr wait1Sec
	pea .LC5
	jsr printString
	addq.l #4,%sp
	pea .LC6
	jsr strToNum
	addq.l #4,%sp
	move.l %d0,-12(%fp)
	cmp.l #12345,-12(%fp)
	jne .L4
	pea .LC7
	jsr printString
	addq.l #4,%sp
	jra .L5
.L4:
	pea .LC8
	jsr printString
	addq.l #4,%sp
.L5:
	lea (-93,%fp),%a0
	move.l %a0,-(%sp)
	move.l #123456,-(%sp)
	jsr intToStr
	addq.l #8,%sp
	lea (-93,%fp),%a0
	move.l %a0,-(%sp)
	jsr printString
	addq.l #4,%sp
.L6:
	jsr getCharA
	move.b %d0,-13(%fp)
	move.b -13(%fp),%d0
	ext.w %d0
	move.w %d0,%a0
	move.l %a0,-(%sp)
	jsr putCharA
	addq.l #4,%sp
	jra .L6
	.size	main, .-main
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
	jge .L9
	moveq #1,%d0
	move.l %d0,-8(%fp)
	neg.l 8(%fp)
.L9:
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
	jgt .L9
	tst.l -8(%fp)
	jeq .L10
	move.l -4(%fp),%d0
	move.l %d0,%d1
	addq.l #1,%d1
	move.l %d1,-4(%fp)
	move.l 12(%fp),%a0
	add.l %d0,%a0
	move.b #45,(%a0)
.L10:
	move.l -4(%fp),%d0
	move.l 12(%fp),%a0
	add.l %d0,%a0
	clr.b (%a0)
	clr.l -12(%fp)
	jra .L11
.L12:
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
.L11:
	move.l -4(%fp),%d0
	move.l %d0,%d1
	add.l %d1,%d1
	subx.l %d1,%d1
	neg.l %d1
	add.l %d1,%d0
	asr.l #1,%d0
	cmp.l -12(%fp),%d0
	jgt .L12
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
	jne .L14
	move.l -4(%fp),%d0
	jra .L15
.L14:
	clr.l -8(%fp)
	jra .L16
.L17:
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
.L16:
	move.l 8(%fp),-(%sp)
	jsr strlen
	addq.l #4,%sp
	cmp.l -8(%fp),%d0
	jgt .L17
	move.l -4(%fp),%d0
.L15:
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
	jra .L19
.L23:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	cmp.b #57,%d0
	jle .L20
	moveq #0,%d0
	jra .L21
.L20:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	cmp.b #47,%d0
	jgt .L22
	moveq #0,%d0
	jra .L21
.L22:
	addq.l #1,-4(%fp)
.L19:
	move.l -4(%fp),%d0
	cmp.l -8(%fp),%d0
	jlt .L23
	moveq #1,%d0
.L21:
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
	jra .L25
.L29:
	jsr getCharA
	move.b %d0,-9(%fp)
	move.l 8(%fp),%a0
	move.b -9(%fp),(%a0)
	addq.l #1,8(%fp)
	addq.l #1,-4(%fp)
	clr.l -8(%fp)
	moveq #78,%d0
	cmp.l -4(%fp),%d0
	jge .L26
	moveq #1,%d0
	move.l %d0,-8(%fp)
	jra .L27
.L26:
	cmp.b #10,-9(%fp)
	jne .L28
	moveq #1,%d0
	move.l %d0,-8(%fp)
	jra .L27
.L28:
	cmp.b #13,-9(%fp)
	jne .L27
	moveq #1,%d0
	move.l %d0,-8(%fp)
.L27:
	move.b -9(%fp),%d0
	ext.w %d0
	move.w %d0,%a0
	move.l %a0,-(%sp)
	jsr putCharA
	addq.l #4,%sp
.L25:
	tst.l -8(%fp)
	jeq .L29
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
	jra .L32
.L33:
	move.l 8(%fp),%a0
	add.l -4(%fp),%a0
	move.b (%a0),%d0
	ext.w %d0
	move.w %d0,%a0
	move.l %a0,-(%sp)
	jsr putCharA
	addq.l #4,%sp
	addq.l #1,-4(%fp)
.L32:
	move.l 8(%fp),-(%sp)
	jsr strlen
	addq.l #4,%sp
	cmp.l -4(%fp),%d0
	jhi .L33
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
	jra .L35
.L36:
	addq.l #1,-4(%fp)
.L35:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	tst.b %d0
	jne .L36
	move.l -4(%fp),%d0
	unlk %fp
	rts
	.size	strlen, .-strlen
	.align	2
	.globl	setLED
	.type	setLED, @function
setLED:
	link.w %fp,#-12
	move.l 8(%fp),%d0
	move.b %d0,%d0
	move.b %d0,-10(%fp)
	move.l #983068,-4(%fp)
	move.l #983070,-8(%fp)
	tst.b -10(%fp)
	jne .L39
	move.l -4(%fp),%a0
	move.b #4,(%a0)
	jra .L41
.L39:
	move.l -8(%fp),%a0
	move.b #4,(%a0)
.L41:
	nop
	unlk %fp
	rts
	.size	setLED, .-setLED
	.align	2
	.globl	wait1Sec
	.type	wait1Sec, @function
wait1Sec:
	link.w %fp,#-4
	move.l #50000,-4(%fp)
	jra .L43
.L44:
	subq.l #1,-4(%fp)
.L43:
	tst.l -4(%fp)
	jne .L44
	nop
	nop
	unlk %fp
	rts
	.size	wait1Sec, .-wait1Sec
	.align	2
	.globl	getCharA
	.type	getCharA, @function
getCharA:
	link.w %fp,#-12
	move.l #983042,-6(%fp)
	move.l #983046,-10(%fp)
	clr.b -1(%fp)
	jra .L46
.L47:
	move.l -6(%fp),%a0
	move.b (%a0),-1(%fp)
	and.b #1,-1(%fp)
.L46:
	tst.b -1(%fp)
	jeq .L47
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
	jra .L50
.L51:
	move.l -6(%fp),%a0
	move.b (%a0),-1(%fp)
	and.b #1,-1(%fp)
.L50:
	tst.b -1(%fp)
	jeq .L51
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
	jra .L54
.L55:
	move.l -6(%fp),%a0
	move.b (%a0),%d0
	move.b %d0,-1(%fp)
	and.b #4,-1(%fp)
.L54:
	tst.b -1(%fp)
	jeq .L55
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
	jra .L57
.L58:
	move.l -6(%fp),%a0
	move.b (%a0),%d0
	move.b %d0,-1(%fp)
	and.b #4,-1(%fp)
.L57:
	tst.b -1(%fp)
	jeq .L58
	move.b -12(%fp),%d0
	move.l -10(%fp),%a0
	move.b %d0,(%a0)
	nop
	unlk %fp
	rts
	.size	putCharB, .-putCharB
	.ident	"GCC: (GNU) 9.3.1 20200817"

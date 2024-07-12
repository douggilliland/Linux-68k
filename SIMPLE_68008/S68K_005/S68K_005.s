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
	.string	"string to number = OK"
.LC8:
	.string	"str to num BAD"
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
	jra .L6
.L4:
	pea .LC8
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
	jne .L8
	move.l -4(%fp),%d0
	jra .L9
.L8:
	clr.l -8(%fp)
	jra .L10
.L11:
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
.L10:
	move.l 8(%fp),-(%sp)
	jsr strlen
	addq.l #4,%sp
	cmp.l -8(%fp),%d0
	jgt .L11
	move.l -4(%fp),%d0
.L9:
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
	jra .L13
.L17:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	cmp.b #57,%d0
	jle .L14
	moveq #0,%d0
	jra .L15
.L14:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	cmp.b #47,%d0
	jgt .L16
	moveq #0,%d0
	jra .L15
.L16:
	addq.l #1,-4(%fp)
.L13:
	move.l -4(%fp),%d0
	cmp.l -8(%fp),%d0
	jlt .L17
	moveq #1,%d0
.L15:
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
	jra .L19
.L23:
	jsr getCharA
	move.b %d0,-9(%fp)
	move.l 8(%fp),%a0
	move.b -9(%fp),(%a0)
	addq.l #1,8(%fp)
	addq.l #1,-4(%fp)
	clr.l -8(%fp)
	moveq #78,%d0
	cmp.l -4(%fp),%d0
	jge .L20
	moveq #1,%d0
	move.l %d0,-8(%fp)
	jra .L21
.L20:
	cmp.b #10,-9(%fp)
	jne .L22
	moveq #1,%d0
	move.l %d0,-8(%fp)
	jra .L21
.L22:
	cmp.b #13,-9(%fp)
	jne .L21
	moveq #1,%d0
	move.l %d0,-8(%fp)
.L21:
	move.b -9(%fp),%d0
	ext.w %d0
	move.w %d0,%a0
	move.l %a0,-(%sp)
	jsr putCharA
	addq.l #4,%sp
.L19:
	tst.l -8(%fp)
	jeq .L23
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
	jra .L26
.L27:
	move.l 8(%fp),%a0
	add.l -4(%fp),%a0
	move.b (%a0),%d0
	ext.w %d0
	move.w %d0,%a0
	move.l %a0,-(%sp)
	jsr putCharA
	addq.l #4,%sp
	addq.l #1,-4(%fp)
.L26:
	move.l 8(%fp),-(%sp)
	jsr strlen
	addq.l #4,%sp
	cmp.l -4(%fp),%d0
	jhi .L27
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
	jra .L29
.L30:
	addq.l #1,-4(%fp)
.L29:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	tst.b %d0
	jne .L30
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
	jne .L33
	move.l -4(%fp),%a0
	move.b #4,(%a0)
	jra .L35
.L33:
	move.l -8(%fp),%a0
	move.b #4,(%a0)
.L35:
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
	jra .L37
.L38:
	subq.l #1,-4(%fp)
.L37:
	tst.l -4(%fp)
	jne .L38
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
	jra .L40
.L41:
	move.l -6(%fp),%a0
	move.b (%a0),-1(%fp)
	and.b #1,-1(%fp)
.L40:
	tst.b -1(%fp)
	jeq .L41
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
	jra .L44
.L45:
	move.l -6(%fp),%a0
	move.b (%a0),-1(%fp)
	and.b #1,-1(%fp)
.L44:
	tst.b -1(%fp)
	jeq .L45
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
	jra .L48
.L49:
	move.l -6(%fp),%a0
	move.b (%a0),%d0
	move.b %d0,-1(%fp)
	and.b #4,-1(%fp)
.L48:
	tst.b -1(%fp)
	jeq .L49
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
	jra .L51
.L52:
	move.l -6(%fp),%a0
	move.b (%a0),%d0
	move.b %d0,-1(%fp)
	and.b #4,-1(%fp)
.L51:
	tst.b -1(%fp)
	jeq .L52
	move.b -12(%fp),%d0
	move.l -10(%fp),%a0
	move.b %d0,(%a0)
	nop
	unlk %fp
	rts
	.size	putCharB, .-putCharB
	.ident	"GCC: (GNU) 9.3.1 20200817"

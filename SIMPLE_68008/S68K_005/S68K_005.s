#NO_APP
	.file	"S68K_005.c"
	.text
	.section	.rodata
.LC0:
	.string	"String to print\n\r"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	link.w %fp,#-88
	move.l #983066,-4(%fp)
	move.l -4(%fp),%a0
	clr.b (%a0)
	pea .LC0
	jsr printString
	addq.l #4,%sp
	lea (-85,%fp),%a0
	move.l %a0,-(%sp)
	jsr getString
	addq.l #4,%sp
	lea (-85,%fp),%a0
	move.l %a0,-(%sp)
	jsr printString
	addq.l #4,%sp
.L2:
	pea 1.w
	jsr setLED
	addq.l #4,%sp
	jsr getCharA
	move.b %d0,-5(%fp)
	clr.l -(%sp)
	jsr setLED
	addq.l #4,%sp
	jsr wait1Sec
	moveq #0,%d0
	move.b -5(%fp),%d0
	move.l %d0,-(%sp)
	jsr putCharA
	addq.l #4,%sp
	jra .L2
	.size	main, .-main
	.align	2
	.globl	getString
	.type	getString, @function
getString:
	link.w %fp,#-8
	clr.l -4(%fp)
	clr.b -5(%fp)
	jra .L4
.L8:
	jsr getCharA
	move.b %d0,-6(%fp)
	move.l 8(%fp),%a0
	move.b -6(%fp),(%a0)
	addq.l #1,8(%fp)
	addq.l #1,-4(%fp)
	clr.b -5(%fp)
	moveq #78,%d0
	cmp.l -4(%fp),%d0
	jcc .L5
	move.b #1,-5(%fp)
	jra .L6
.L5:
	cmp.b #10,-6(%fp)
	jne .L7
	move.b #1,-5(%fp)
	jra .L6
.L7:
	cmp.b #13,-6(%fp)
	jne .L6
	move.b #1,-5(%fp)
.L6:
	moveq #0,%d0
	move.b -6(%fp),%d0
	move.l %d0,-(%sp)
	jsr putCharA
	addq.l #4,%sp
.L4:
	tst.b -5(%fp)
	jeq .L8
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
	jra .L11
.L12:
	move.l 8(%fp),%a0
	add.l -4(%fp),%a0
	move.b (%a0),%d0
	move.b %d0,%d0
	and.l #255,%d0
	move.l %d0,-(%sp)
	jsr putCharA
	addq.l #4,%sp
	addq.l #1,-4(%fp)
.L11:
	move.l 8(%fp),-(%sp)
	jsr strlen
	addq.l #4,%sp
	cmp.l -4(%fp),%d0
	jhi .L12
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
	jra .L14
.L15:
	addq.l #1,-4(%fp)
.L14:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	tst.b %d0
	jne .L15
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
	jne .L18
	move.l -4(%fp),%a0
	move.b #4,(%a0)
	jra .L20
.L18:
	move.l -8(%fp),%a0
	move.b #4,(%a0)
.L20:
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
	jra .L22
.L23:
	subq.l #1,-4(%fp)
.L22:
	tst.l -4(%fp)
	jne .L23
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
	jra .L25
.L26:
	move.l -6(%fp),%a0
	move.b (%a0),-1(%fp)
	and.b #1,-1(%fp)
.L25:
	tst.b -1(%fp)
	jeq .L26
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
	jra .L29
.L30:
	move.l -6(%fp),%a0
	move.b (%a0),-1(%fp)
	and.b #1,-1(%fp)
.L29:
	tst.b -1(%fp)
	jeq .L30
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
	jra .L33
.L34:
	move.l -6(%fp),%a0
	move.b (%a0),-1(%fp)
	and.b #4,-1(%fp)
.L33:
	tst.b -1(%fp)
	jeq .L34
	move.l -10(%fp),%a0
	move.b -12(%fp),(%a0)
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
	jra .L36
.L37:
	move.l -6(%fp),%a0
	move.b (%a0),-1(%fp)
	and.b #4,-1(%fp)
.L36:
	tst.b -1(%fp)
	jeq .L37
	move.l -10(%fp),%a0
	move.b -12(%fp),(%a0)
	nop
	unlk %fp
	rts
	.size	putCharB, .-putCharB
	.ident	"GCC: (GNU) 9.3.1 20200817"

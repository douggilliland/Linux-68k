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
	link.w %fp,#-8
	move.l #983066,-4(%fp)
	move.l -4(%fp),%a0
	clr.b (%a0)
	pea .LC0
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
	.globl	printString
	.type	printString, @function
printString:
	link.w %fp,#-4
	clr.l -4(%fp)
	jra .L4
.L5:
	move.l 8(%fp),%a0
	add.l -4(%fp),%a0
	move.b (%a0),%d0
	move.b %d0,%d0
	and.l #255,%d0
	move.l %d0,-(%sp)
	jsr putCharA
	addq.l #4,%sp
	addq.l #1,-4(%fp)
.L4:
	move.l 8(%fp),-(%sp)
	jsr strlen
	addq.l #4,%sp
	cmp.l -4(%fp),%d0
	jhi .L5
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
	jra .L7
.L8:
	addq.l #1,-4(%fp)
.L7:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	tst.b %d0
	jne .L8
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
	jne .L11
	move.l -4(%fp),%a0
	move.b #4,(%a0)
	jra .L13
.L11:
	move.l -8(%fp),%a0
	move.b #4,(%a0)
.L13:
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
	jra .L15
.L16:
	subq.l #1,-4(%fp)
.L15:
	tst.l -4(%fp)
	jne .L16
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
	jra .L18
.L19:
	move.l -6(%fp),%a0
	move.b (%a0),-1(%fp)
	and.b #1,-1(%fp)
.L18:
	tst.b -1(%fp)
	jeq .L19
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
	jra .L22
.L23:
	move.l -6(%fp),%a0
	move.b (%a0),-1(%fp)
	and.b #1,-1(%fp)
.L22:
	tst.b -1(%fp)
	jeq .L23
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
	jra .L26
.L27:
	move.l -6(%fp),%a0
	move.b (%a0),-1(%fp)
	and.b #4,-1(%fp)
.L26:
	tst.b -1(%fp)
	jeq .L27
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
	jra .L29
.L30:
	move.l -6(%fp),%a0
	move.b (%a0),-1(%fp)
	and.b #4,-1(%fp)
.L29:
	tst.b -1(%fp)
	jeq .L30
	move.l -10(%fp),%a0
	move.b -12(%fp),(%a0)
	nop
	unlk %fp
	rts
	.size	putCharB, .-putCharB
	.ident	"GCC: (GNU) 9.3.1 20200817"

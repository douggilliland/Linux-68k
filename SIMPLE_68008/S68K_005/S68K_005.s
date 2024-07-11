#NO_APP
	.file	"S68K_005.c"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	link.w %fp,#-8
	move.l #983066,-4(%fp)
	move.l -4(%fp),%a0
	clr.b (%a0)
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
	jne .L4
	move.l -4(%fp),%a0
	move.b #4,(%a0)
	jra .L6
.L4:
	move.l -8(%fp),%a0
	move.b #4,(%a0)
.L6:
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
	jra .L8
.L9:
	subq.l #1,-4(%fp)
.L8:
	tst.l -4(%fp)
	jne .L9
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
	jra .L11
.L12:
	move.l -6(%fp),%a0
	move.b (%a0),-1(%fp)
	and.b #1,-1(%fp)
.L11:
	tst.b -1(%fp)
	jeq .L12
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
	jra .L15
.L16:
	move.l -6(%fp),%a0
	move.b (%a0),-1(%fp)
	and.b #1,-1(%fp)
.L15:
	tst.b -1(%fp)
	jeq .L16
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
	jra .L19
.L20:
	move.l -6(%fp),%a0
	move.b (%a0),-1(%fp)
	and.b #4,-1(%fp)
.L19:
	tst.b -1(%fp)
	jeq .L20
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
	jra .L22
.L23:
	move.l -6(%fp),%a0
	move.b (%a0),-1(%fp)
	and.b #4,-1(%fp)
.L22:
	tst.b -1(%fp)
	jeq .L23
	move.l -10(%fp),%a0
	move.b -12(%fp),(%a0)
	nop
	unlk %fp
	rts
	.size	putCharB, .-putCharB
	.ident	"GCC: (GNU) 9.3.1 20200817"

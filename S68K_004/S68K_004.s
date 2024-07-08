#NO_APP
	.file	"S68K_004.c"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	link.w %fp,#-16
	move.l #983040,-4(%fp)
	move.l #983078,-8(%fp)
	move.l #983080,-12(%fp)
	move.l #983088,-16(%fp)
	move.l -8(%fp),%a0
	clr.b (%a0)
	move.l -16(%fp),%a0
	move.b #-4,(%a0)
	move.l -12(%fp),%a0
	move.b #4,(%a0)
.L2:
	jsr wait1Sec
	move.l -16(%fp),%a0
	move.b #-4,(%a0)
	jsr wait1Sec
	move.l -12(%fp),%a0
	move.b #-4,(%a0)
	jra .L2
	.size	main, .-main
	.align	2
	.globl	wait1Sec
	.type	wait1Sec, @function
wait1Sec:
	link.w %fp,#-4
	move.l #1048576,-4(%fp)
	jra .L4
.L5:
	subq.l #1,-4(%fp)
.L4:
	tst.l -4(%fp)
	jne .L5
	nop
	nop
	unlk %fp
	rts
	.size	wait1Sec, .-wait1Sec
	.ident	"GCC: (GNU) 9.3.1 20200817"

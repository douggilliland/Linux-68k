#NO_APP
	.file	"S68K_005.c"
	.text
	.globl	DUART_OPC
	.data
	.align	2
	.type	DUART_OPC, @object
	.size	DUART_OPC, 4
DUART_OPC:
	.long	983066
	.globl	DUART_OPS
	.align	2
	.type	DUART_OPS, @object
	.size	DUART_OPS, 4
DUART_OPS:
	.long	983068
	.globl	DUART_OPR
	.align	2
	.type	DUART_OPR, @object
	.size	DUART_OPR, 4
DUART_OPR:
	.long	983070
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	link.w %fp,#0
	move.l #983066,DUART_OPC
	move.l #983068,DUART_OPS
	move.l #983070,DUART_OPR
	move.l DUART_OPC,%a0
	clr.b (%a0)
	move.l DUART_OPR,%a0
	move.b #-4,(%a0)
.L2:
	jsr wait1Sec
	move.l DUART_OPS,%a0
	move.b #4,(%a0)
	jsr wait1Sec
	move.l DUART_OPR,%a0
	move.b #4,(%a0)
	jra .L2
	.size	main, .-main
	.align	2
	.globl	wait1Sec
	.type	wait1Sec, @function
wait1Sec:
	link.w %fp,#-4
	move.l #50000,-4(%fp)
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

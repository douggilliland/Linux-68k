#NO_APP
	.file	"testser.c"
	.text
	.section	.rodata
.LC0:
	.string	"Test String 1"
.LC1:
	.string	"Test String 2"
	.text
	.align	2
	.globl	_start
	.type	_start, @function
_start:
	link.w %fp,#0
	pea .LC0
	jsr printStringToACIA
	addq.l #4,%sp
	pea .LC1
	jsr printStringToVDU
	addq.l #4,%sp
	nop
	unlk %fp
	rts
	.size	_start, .-_start
	.align	2
	.globl	printCharToACIA
	.type	printCharToACIA, @function
printCharToACIA:
	link.w %fp,#-4
	move.l 8(%fp),%d0
	move.b %d0,%d0
	move.b %d0,-2(%fp)
	nop
.L3:
	move.l #65601,%a0
	move.b (%a0),%d0
	move.b %d0,%d0
	and.l #255,%d0
	moveq #2,%d1
	and.l %d1,%d0
	tst.l %d0
	jeq .L3
	move.l #65603,%a0
	move.b -2(%fp),(%a0)
	nop
	unlk %fp
	rts
	.size	printCharToACIA, .-printCharToACIA
	.align	2
	.globl	printStringToACIA
	.type	printStringToACIA, @function
printStringToACIA:
	link.w %fp,#-4
	clr.l -4(%fp)
	jra .L5
.L6:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	move.b %d0,%d0
	and.l #255,%d0
	move.l %d0,-(%sp)
	jsr printCharToACIA
	addq.l #4,%sp
.L5:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	tst.b %d0
	jne .L6
	nop
	nop
	unlk %fp
	rts
	.size	printStringToACIA, .-printStringToACIA
	.align	2
	.globl	printCharToVDU
	.type	printCharToVDU, @function
printCharToVDU:
	link.w %fp,#-4
	move.l 8(%fp),%d0
	move.b %d0,%d0
	move.b %d0,-2(%fp)
	nop
.L8:
	move.l #65600,%a0
	move.b (%a0),%d0
	move.b %d0,%d0
	and.l #255,%d0
	moveq #2,%d1
	and.l %d1,%d0
	tst.l %d0
	jeq .L8
	move.l #65602,%a0
	move.b -2(%fp),(%a0)
	nop
	unlk %fp
	rts
	.size	printCharToVDU, .-printCharToVDU
	.align	2
	.globl	printStringToVDU
	.type	printStringToVDU, @function
printStringToVDU:
	link.w %fp,#-4
	clr.l -4(%fp)
	jra .L10
.L11:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	move.b %d0,%d0
	and.l #255,%d0
	move.l %d0,-(%sp)
	jsr printCharToVDU
	addq.l #4,%sp
.L10:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	tst.b %d0
	jne .L11
	nop
	nop
	unlk %fp
	rts
	.size	printStringToVDU, .-printStringToVDU
	.ident	"GCC: (GNU) 9.3.1 20200817"

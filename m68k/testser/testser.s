#NO_APP
	.file	"testser.c"
	.text
	.align	2
	.globl	_start
	.type	_start, @function
_start:
	link.w %fp,#-4
.L2:
	move.l #65601,%a0
	move.b (%a0),-1(%fp)
	moveq #0,%d0
	move.b -1(%fp),%d0
	moveq #2,%d1
	and.l %d1,%d0
	tst.l %d0
	jne .L2
	move.l #65603,%a0
	move.b #88,(%a0)
	nop
	unlk %fp
	rts
	.size	_start, .-_start
	.ident	"GCC: (GNU) 9.3.1 20200817"

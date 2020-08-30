#NO_APP
	.file	"testser.c"
	.text
	.section	.rodata
.LC0:
	.string	"Test String to serial\n\r"
.LC1:
	.string	"Test String to VDU\n\r"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	link.w %fp,#0
#APP
| 17 "testser.c" 1
	move.l #0x1000,%sp
| 0 "" 2
#NO_APP
	pea .LC0
	jsr printStringToACIA
	addq.l #4,%sp
	pea .LC1
	jsr printStringToVDU
	addq.l #4,%sp
#APP
| 21 "testser.c" 1
	move.b #228,%d7
	trap #14
| 0 "" 2
#NO_APP
	moveq #0,%d0
	unlk %fp
	rts
	.size	main, .-main
	.align	2
	.globl	printCharToACIA
	.type	printCharToACIA, @function
printCharToACIA:
	link.w %fp,#-4
	move.l 8(%fp),%d0
	move.b %d0,%d0
	move.b %d0,-2(%fp)
	nop
.L4:
	move.l #65601,%a0
	move.b (%a0),%d0
	move.b %d0,%d0
	and.l #255,%d0
	moveq #2,%d1
	and.l %d1,%d0
	tst.l %d0
	jeq .L4
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
	jra .L6
.L7:
	move.l -4(%fp),%d0
	move.l %d0,%d1
	addq.l #1,%d1
	move.l %d1,-4(%fp)
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	move.b %d0,%d0
	and.l #255,%d0
	move.l %d0,-(%sp)
	jsr printCharToACIA
	addq.l #4,%sp
.L6:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	tst.b %d0
	jne .L7
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
.L9:
	move.l #65600,%a0
	move.b (%a0),%d0
	move.b %d0,%d0
	and.l #255,%d0
	moveq #2,%d1
	and.l %d1,%d0
	tst.l %d0
	jeq .L9
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
	jra .L11
.L12:
	move.l -4(%fp),%d0
	move.l %d0,%d1
	addq.l #1,%d1
	move.l %d1,-4(%fp)
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	move.b %d0,%d0
	and.l #255,%d0
	move.l %d0,-(%sp)
	jsr printCharToVDU
	addq.l #4,%sp
.L11:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	tst.b %d0
	jne .L12
	nop
	nop
	unlk %fp
	rts
	.size	printStringToVDU, .-printStringToVDU
	.ident	"GCC: (GNU) 9.3.1 20200817"

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
| 21 "testser.c" 1
	move.l #0x1000,%sp
| 0 "" 2
#NO_APP
	pea .LC0
	jsr printStringToACIA
	addq.l #4,%sp
	pea .LC1
	jsr printStringToVDU
	addq.l #4,%sp
	pea 10000.w
	jsr wait
	addq.l #4,%sp
#APP
| 26 "testser.c" 1
	move.b #228,%d7
	trap #14
| 0 "" 2
#NO_APP
	moveq #0,%d0
	unlk %fp
	rts
	.size	main, .-main
	.align	2
	.globl	getCharVDU
	.type	getCharVDU, @function
getCharVDU:
	link.w %fp,#0
	nop
.L4:
	move.l #65600,%a0
	move.b (%a0),%d0
	move.b %d0,%d0
	and.l #255,%d0
	moveq #1,%d1
	and.l %d1,%d0
	moveq #1,%d1
	cmp.l %d0,%d1
	jne .L4
	move.l #65603,%a0
	move.b (%a0),%d0
	unlk %fp
	rts
	.size	getCharVDU, .-getCharVDU
	.align	2
	.globl	getCharACIA
	.type	getCharACIA, @function
getCharACIA:
	link.w %fp,#0
	nop
.L7:
	move.l #65601,%a0
	move.b (%a0),%d0
	move.b %d0,%d0
	and.l #255,%d0
	moveq #1,%d1
	and.l %d1,%d0
	moveq #1,%d1
	cmp.l %d0,%d1
	jne .L7
	move.l #65602,%a0
	move.b (%a0),%d0
	unlk %fp
	rts
	.size	getCharACIA, .-getCharACIA
	.align	2
	.globl	wait
	.type	wait, @function
wait:
	link.w %fp,#-4
	moveq #0,%d0
	move.l %d0,-4(%fp)
	moveq #0,%d0
	move.l %d0,-4(%fp)
	jra .L10
.L11:
	move.l -4(%fp),%d0
	addq.l #1,%d0
	move.l %d0,-4(%fp)
.L10:
	move.l -4(%fp),%d0
	cmp.l 8(%fp),%d0
	jcs .L11
	nop
	nop
	unlk %fp
	rts
	.size	wait, .-wait
	.align	2
	.globl	printCharToACIA
	.type	printCharToACIA, @function
printCharToACIA:
	link.w %fp,#-4
	move.l 8(%fp),%d0
	move.b %d0,%d0
	move.b %d0,-2(%fp)
	nop
.L13:
	move.l #65601,%a0
	move.b (%a0),%d0
	move.b %d0,%d0
	and.l #255,%d0
	moveq #2,%d1
	and.l %d1,%d0
	moveq #2,%d1
	cmp.l %d0,%d1
	jne .L13
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
	jra .L15
.L16:
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
.L15:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	tst.b %d0
	jne .L16
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
.L18:
	move.l #65600,%a0
	move.b (%a0),%d0
	move.b %d0,%d0
	and.l #255,%d0
	moveq #2,%d1
	and.l %d1,%d0
	moveq #2,%d1
	cmp.l %d0,%d1
	jne .L18
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
	jra .L20
.L21:
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
.L20:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	tst.b %d0
	jne .L21
	nop
	nop
	unlk %fp
	rts
	.size	printStringToVDU, .-printStringToVDU
	.ident	"GCC: (GNU) 9.3.1 20200817"

#NO_APP
	.file	"SDCard.c"
	.text
	.section	.rodata
.LC0:
	.string	"Waiting on SD Card ready\n\r"
.LC1:
	.string	"SD Card is ready\n\r"
.LC2:
	.string	"Writing LBA = 0\n\r"
.LC3:
	.string	"Reading block\n\r"
.LC4:
	.string	"Block was read to 0xE000\n\r"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	link.w %fp,#0
#APP
| 57 "SDCard.c" 1
	move.l #0x1000,%sp
| 0 "" 2
#NO_APP
	pea .LC0
	jsr printStringToVDU
	addq.l #4,%sp
	jsr wait_Until_SD_CMD_Done
	pea .LC1
	jsr printStringToVDU
	addq.l #4,%sp
	pea .LC2
	jsr printStringToVDU
	addq.l #4,%sp
	clr.l -(%sp)
	jsr write_SD_LBA
	addq.l #4,%sp
	pea .LC3
	jsr printStringToVDU
	addq.l #4,%sp
	jsr readSDBlockToBuffer
	pea .LC4
	jsr printStringToVDU
	addq.l #4,%sp
#APP
| 67 "SDCard.c" 1
	move.b #228,%d7
	trap #14
| 0 "" 2
#NO_APP
	moveq #0,%d0
	unlk %fp
	rts
	.size	main, .-main
	.align	2
	.globl	readSDBlockToBuffer
	.type	readSDBlockToBuffer, @function
readSDBlockToBuffer:
	link.w %fp,#-8
	move.w #512,-6(%fp)
	move.l #57344,-4(%fp)
	jra .L4
.L5:
	jsr wait_Until_SD_Char_RD_Rdy
	move.l #65617,%a0
	move.b (%a0),-7(%fp)
	move.l -4(%fp),%d0
	move.l %d0,%d1
	addq.l #1,%d1
	move.l %d1,-4(%fp)
	move.l %d0,%a0
	move.b -7(%fp),(%a0)
.L4:
	tst.w -6(%fp)
	jne .L5
	nop
	nop
	unlk %fp
	rts
	.size	readSDBlockToBuffer, .-readSDBlockToBuffer
	.align	2
	.globl	write_SD_LBA
	.type	write_SD_LBA, @function
write_SD_LBA:
	link.w %fp,#-4
	move.b 11(%fp),-1(%fp)
	move.l 8(%fp),%d0
	lsr.l #8,%d0
	move.b %d0,-2(%fp)
	move.l 8(%fp),%d0
	clr.w %d0
	swap %d0
	move.b %d0,-3(%fp)
	move.l #65621,%a0
	move.b -1(%fp),(%a0)
	move.l #65623,%a0
	move.b -2(%fp),(%a0)
	move.l #65625,%a0
	move.b -3(%fp),(%a0)
	nop
	unlk %fp
	rts
	.size	write_SD_LBA, .-write_SD_LBA
	.align	2
	.globl	wait_Until_SD_Char_RD_Rdy
	.type	wait_Until_SD_Char_RD_Rdy, @function
wait_Until_SD_Char_RD_Rdy:
	link.w %fp,#-4
	move.l #65619,%a0
	move.b (%a0),-1(%fp)
	jra .L8
.L9:
	move.l #65619,%a0
	move.b (%a0),-1(%fp)
.L8:
	cmp.b #-32,-1(%fp)
	jne .L9
	nop
	nop
	unlk %fp
	rts
	.size	wait_Until_SD_Char_RD_Rdy, .-wait_Until_SD_Char_RD_Rdy
	.align	2
	.globl	wait_Until_SD_CMD_Done
	.type	wait_Until_SD_CMD_Done, @function
wait_Until_SD_CMD_Done:
	link.w %fp,#-4
	move.l #65619,%a0
	move.b (%a0),-1(%fp)
	jra .L11
.L12:
	move.l #65619,%a0
	move.b (%a0),-1(%fp)
.L11:
	cmp.b #-128,-1(%fp)
	jne .L12
	nop
	nop
	unlk %fp
	rts
	.size	wait_Until_SD_CMD_Done, .-wait_Until_SD_CMD_Done
	.align	2
	.globl	waitUART
	.type	waitUART, @function
waitUART:
	link.w %fp,#-4
	moveq #0,%d0
	move.l %d0,-4(%fp)
	moveq #0,%d0
	move.l %d0,-4(%fp)
	jra .L14
.L15:
	move.l -4(%fp),%d0
	addq.l #1,%d0
	move.l %d0,-4(%fp)
.L14:
	move.l -4(%fp),%d0
	cmp.l 8(%fp),%d0
	jcs .L15
	nop
	nop
	unlk %fp
	rts
	.size	waitUART, .-waitUART
	.align	2
	.globl	printCharToACIA
	.type	printCharToACIA, @function
printCharToACIA:
	link.w %fp,#-4
	move.l 8(%fp),%d0
	move.b %d0,%d0
	move.b %d0,-2(%fp)
	nop
.L17:
	move.l #65601,%a0
	move.b (%a0),%d0
	move.b %d0,%d0
	and.l #255,%d0
	moveq #2,%d1
	and.l %d1,%d0
	moveq #2,%d1
	cmp.l %d0,%d1
	jne .L17
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
	jra .L19
.L20:
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
.L19:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	tst.b %d0
	jne .L20
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
.L22:
	move.l #65600,%a0
	move.b (%a0),%d0
	move.b %d0,%d0
	and.l #255,%d0
	moveq #2,%d1
	and.l %d1,%d0
	moveq #2,%d1
	cmp.l %d0,%d1
	jne .L22
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
	jra .L24
.L25:
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
.L24:
	move.l -4(%fp),%d0
	move.l 8(%fp),%a0
	add.l %d0,%a0
	move.b (%a0),%d0
	tst.b %d0
	jne .L25
	nop
	nop
	unlk %fp
	rts
	.size	printStringToVDU, .-printStringToVDU
	.ident	"GCC: (GNU) 9.3.1 20200817"

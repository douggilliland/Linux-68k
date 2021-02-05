#NO_APP
	.file	"main.c"
	.text
	.align	2
	.type	heartbeat_int, @function
heartbeat_int:
	add.l #10000,microseconds
	rts
	.size	heartbeat_int, .-heartbeat_int
	.align	2
	.type	mousetimer_int, @function
mousetimer_int:
	move.w -2130706418,%d0
	btst #5,%d0
	jeq .L3
	move.w #1,mousetimeout
.L3:
	rts
	.size	mousetimer_int, .-mousetimer_int
	.globl	__mulsi3
	.align	2
	.type	vblank_int, @function
vblank_int:
	subq.l #4,%sp
	movem.l #16176,-(%sp)
	move.w framecount,%d0
	addq.w #1,%d0
	move.w %d0,framecount
	cmp.w #959,%d0
	jeq .L45
	move.w %d0,%a0
	cmp.w #479,%d0
	jle .L13
	move.w #959,%a1
	sub.l %a0,%a1
	move.l %a1,%a0
.L13:
	move.l screenwidth,-(%sp)
	move.l %a0,-(%sp)
	jsr __mulsi3
	addq.l #8,%sp
	add.l %d0,%d0
	add.l FrameBuffer,%d0
	move.l %d0,-2147483648
	move.w mousemode.2861,%d4
	lea ps2_ringbuffer_count,%a3
	lea ps2_ringbuffer_read,%a2
	move.w #639,%d6
	move.w #479,%d5
.L14:
	pea mousebuffer
	jsr (%a3)
	move.w %d4,%a0
	move.l %a0,%d4
	addq.l #2,%d4
	move.w %d0,%a0
	addq.l #4,%sp
	cmp.l %d4,%a0
	jle .L46
.L23:
	pea mousebuffer
	jsr (%a2)
	move.w %d0,%d7
	pea mousebuffer
	jsr (%a2)
	move.w %d0,%d3
	pea mousebuffer
	jsr (%a2)
	move.w %d0,%d2
	move.w mousemode.2861,%d4
	lea (12,%sp),%sp
	jne .L47
.L15:
	move.w %d7,MouseButtons
	btst #5,%d7
	jeq .L17
	or.w #-256,%d2
.L17:
	btst #4,%d7
	jeq .L18
	or.w #-256,%d3
.L18:
	move.w %d3,%d0
	add.w MouseX,%d0
	cmp.w #639,%d0
	jle .L19
	move.w %d6,%d0
.L19:
	tst.w %d0
	jlt .L48
.L20:
	move.w %d0,MouseX
	move.w MouseY,%d0
	sub.w %d2,%d0
	cmp.w #479,%d0
	jle .L21
	move.w %d5,%d0
.L21:
	tst.w %d0
	jlt .L49
	move.w %d0,MouseY
	clr.w mousetimeout
.L50:
	pea mousebuffer
	jsr (%a3)
	move.w %d4,%a0
	move.l %a0,%d4
	addq.l #2,%d4
	move.w %d0,%a0
	addq.l #4,%sp
	cmp.l %d4,%a0
	jgt .L23
.L46:
	move.w MouseX,-2147483388
	move.w MouseY,-2147483386
	pea mousebuffer
	jsr (%a3)
	addq.l #4,%sp
	tst.w %d0
	jeq .L25
	move.w mousetimeout,%d0
	addq.w #1,%d0
	move.w %d0,mousetimeout
	lea ps2_ringbuffer_read,%a2
	cmp.w #20,%d0
	jeq .L26
.L25:
	pea kbbuffer
	jsr (%a3)
	addq.l #4,%sp
	tst.w %d0
	jeq .L10
	lea HandlePS2RawCodes,%a2
	moveq #34,%d2
	add.l %sp,%d2
	lea tb_puts,%a3
	jsr (%a2)
	tst.b %d0
	jeq .L10
.L30:
	clr.w 34(%sp)
	move.b %d0,34(%sp)
	move.l %d2,-(%sp)
	jsr (%a3)
	addq.l #4,%sp
	jsr (%a2)
	tst.b %d0
	jne .L30
.L10:
	movem.l (%sp)+,#3324
	addq.l #4,%sp
	rts
.L48:
	clr.w %d0
	jra .L20
.L49:
	clr.w %d0
	move.w %d0,MouseY
	clr.w mousetimeout
	jra .L50
.L47:
	pea mousebuffer
	jsr (%a2)
	addq.l #4,%sp
	btst #3,%d0
	jeq .L16
	eor.w #15,%d0
	and.w #15,%d0
	sub.w %d0,MouseZ
	move.w mousemode.2861,%d4
	jra .L15
.L16:
	and.w #15,%d0
	add.w %d0,MouseZ
	move.w mousemode.2861,%d4
	jra .L15
.L26:
	pea mousebuffer
	jsr (%a3)
	addq.l #4,%sp
	tst.w %d0
	jeq .L51
.L28:
	pea mousebuffer
	jsr (%a2)
	addq.l #4,%sp
	pea mousebuffer
	jsr (%a3)
	addq.l #4,%sp
	tst.w %d0
	jne .L28
.L51:
	clr.w mousetimeout
	eor.w #1,mousemode.2861
	jra .L25
.L45:
	clr.w framecount
	sub.l %a0,%a0
	move.l screenwidth,-(%sp)
	move.l %a0,-(%sp)
	jsr __mulsi3
	addq.l #8,%sp
	add.l %d0,%d0
	add.l FrameBuffer,%d0
	move.l %d0,-2147483648
	move.w mousemode.2861,%d4
	lea ps2_ringbuffer_count,%a3
	lea ps2_ringbuffer_read,%a2
	move.w #639,%d6
	move.w #479,%d5
	jra .L14
	.size	vblank_int, .-vblank_int
	.align	2
	.globl	SetHeartbeat
	.type	SetHeartbeat, @function
SetHeartbeat:
	move.w -2130706390,%d0
	add.w %d0,%d0
	move.w %d0,-2130706416
	move.w #512,-2130706418
	move.w #1000,-2130706414
	pea heartbeat_int
	pea 3.w
	jsr SetIntHandler
	addq.l #8,%sp
	rts
	.size	SetHeartbeat, .-SetHeartbeat
	.align	2
	.globl	SetMouseTimeout
	.type	SetMouseTimeout, @function
SetMouseTimeout:
	clr.w mousetimeout
	move.w #8192,-2130706418
	move.w 6(%sp),-2130706406
	pea mousetimer_int
	pea 3.w
	jsr SetIntHandler
	addq.l #8,%sp
	rts
	.size	SetMouseTimeout, .-SetMouseTimeout
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Heap_low: %lx, heap_size: %lx\n"
	.text
	.align	2
	.globl	AddMemory
	.type	AddMemory, @function
AddMemory:
	move.l %d3,-(%sp)
	move.l %d2,-(%sp)
	move.w -2130706392,%d0
	and.l #65535,%d0
	moveq #1,%d2
	lsl.l %d0,%d2
	move.l #heap_low+15,%d3
	moveq #-16,%d0
	and.l %d0,%d3
	sub.l %d3,%d2
	add.l #-4096,%d2
	move.l %d2,-(%sp)
	move.l %d3,-(%sp)
	pea .LC0
	jsr printf
	move.l %d2,-(%sp)
	move.l %d3,-(%sp)
	jsr malloc_add
	lea (20,%sp),%sp
	move.l (%sp)+,%d2
	move.l (%sp)+,%d3
	rts
	.size	AddMemory, .-AddMemory
	.section	.rodata.str1.1
.LC1:
	.string	"<DIR>\n"
.LC2:
	.string	"\n"
	.text
	.align	2
	.globl	PrintDirectory
	.type	PrintDirectory, @function
PrintDirectory:
	movem.l #12344,-(%sp)
	lea sort_table,%a2
	move.l #sort_table+8,%d3
	lea puts,%a3
	lea DirEntry,%a4
.L63:
	move.b (%a2)+,%d1
	moveq #0,%d2
	move.b %d1,%d2
	move.l %d2,%d0
	lsl.l #6,%d0
	add.l %d2,%d0
	add.l %d0,%d0
	add.l %d0,%d0
	move.l %d0,%a0
	add.l %d2,%a0
	add.l #DirEntryLFN,%a0
	tst.b (%a0)
	jeq .L59
	move.l %a0,-(%sp)
	jsr (%a3)
	addq.l #4,%sp
.L60:
	lsl.l #5,%d2
	btst #4,11(%a4,%d2.l)
	jeq .L61
	pea .LC1
	jsr (%a3)
	addq.l #4,%sp
	cmp.l %d3,%a2
	jne .L63
.L67:
	movem.l (%sp)+,#7180
	rts
.L61:
	pea .LC2
	jsr (%a3)
	addq.l #4,%sp
	cmp.l %d3,%a2
	jne .L63
	jra .L67
.L59:
	and.l #255,%d1
	lsl.l #5,%d1
	add.l #DirEntry,%d1
	move.l %d1,-(%sp)
	jsr (%a3)
	addq.l #4,%sp
	jra .L60
	.size	PrintDirectory, .-PrintDirectory
	.section	.rodata.str1.1
.LC3:
	.string	"Error at %x\n"
.LC4:
	.string	"expected %x, got %x\n"
	.text
	.align	2
	.globl	DoMemcheckCycle
	.type	DoMemcheckCycle, @function
DoMemcheckCycle:
	movem.l #15416,-(%sp)
	move.l 32(%sp),%a2
	move.l lfsr.2914,%d1
	move.l inv.2915,%d0
	move.l %d1,%d2
	and.l #1048575,%d2
	moveq #1,%d3
	cmp.l %d2,%d3
	jeq .L150
.L69:
	tst.l %d0
	jeq .L99
	move.l %d1,%d0
	move.l #65536,%a0
.L75:
	move.l %d0,%d5
	and.l #1048575,%d5
	move.l %d0,%d3
	add.l %d0,%d3
	btst #21,%d0
	jeq .L71
	moveq #1,%d0
	or.l %d0,%d3
.L71:
	btst #21,%d3
	jeq .L72
	eor.w #1,%d3
.L72:
	move.l %d3,%d4
	and.l #1048575,%d4
	move.l %d5,%d0
	add.l %d5,%d0
	add.l %d0,%d0
	move.l %d5,(%a2,%d0.l)
	move.l %d4,%d0
	add.l %d4,%d0
	add.l %d0,%d0
	move.l %d4,(%a2,%d0.l)
	move.l %d3,%d0
	add.l %d3,%d0
	btst #21,%d3
	jeq .L73
	moveq #1,%d3
	or.l %d3,%d0
.L73:
	btst #21,%d0
	jeq .L74
	eor.w #1,%d0
.L74:
	subq.l #1,%a0
	cmp.w #0,%a0
	jne .L75
	moveq #1,%d4
	swap %d4
	lea printf,%a4
.L85:
	move.l %d1,%d3
	add.l %d1,%d3
	btst #21,%d1
	jeq .L144
	moveq #1,%d5
	or.l %d5,%d3
.L144:
	move.l %d3,lfsr.2914
	btst #21,%d3
	jeq .L78
	eor.w #1,%d3
	move.l %d3,lfsr.2914
.L78:
	and.l #1048575,%d3
	move.l %d2,%d0
	add.l %d2,%d0
	add.l %d0,%d0
	lea (%a2,%d0.l),%a3
	cmp.l (%a3),%d2
	jeq .L79
	move.l %d2,-(%sp)
	pea .LC3
	jsr (%a4)
	move.l (%a3),-(%sp)
	move.l %d2,-(%sp)
	pea .LC4
	jsr (%a4)
	lea (20,%sp),%sp
.L79:
	move.l %d3,%d0
	add.l %d3,%d0
	add.l %d0,%d0
	cmp.l (%a2,%d0.l),%d3
	jeq .L80
	move.l %d2,-(%sp)
	pea .LC3
	jsr (%a4)
	move.l (%a3),-(%sp)
	move.l %d2,-(%sp)
	pea .LC4
	jsr (%a4)
	lea (20,%sp),%sp
.L80:
	move.l lfsr.2914,%d1
	move.l %d1,%d0
	add.l %d1,%d0
	btst #21,%d1
	jeq .L145
	moveq #1,%d1
	or.l %d1,%d0
.L145:
	move.l %d0,lfsr.2914
	btst #21,%d0
	jeq .L83
	eor.w #1,%d0
	move.l %d0,lfsr.2914
.L83:
	subq.l #1,%d4
	jeq .L68
	move.l lfsr.2914,%d1
	move.l %d1,%d2
	and.l #1048575,%d2
	jra .L85
.L99:
	move.l %d1,%d0
	move.l #65536,%a1
.L70:
	move.l %d0,%d4
	and.l #1048575,%d4
	move.l %d0,%d3
	add.l %d0,%d3
	btst #21,%d0
	jeq .L86
	moveq #1,%d5
	or.l %d5,%d3
.L86:
	btst #21,%d3
	jeq .L87
	eor.w #1,%d3
.L87:
	move.l %d4,%a0
	add.l %d4,%a0
	add.l %a0,%a0
	not.l %d0
	and.l #1048575,%d0
	move.l %d0,(%a0,%a2.l)
	move.l %d3,%d0
	and.l #1048575,%d0
	add.l %d0,%d0
	add.l %d0,%d0
	move.l %d3,%d4
	not.l %d4
	and.l #1048575,%d4
	move.l %d4,(%a2,%d0.l)
	move.l %d3,%d0
	add.l %d3,%d0
	btst #21,%d3
	jeq .L88
	moveq #1,%d3
	or.l %d3,%d0
.L88:
	btst #21,%d0
	jeq .L89
	eor.w #1,%d0
.L89:
	subq.l #1,%a1
	cmp.w #0,%a1
	jne .L70
	moveq #1,%d5
	swap %d5
	lea printf,%a3
.L98:
	move.l %d1,%d3
	add.l %d1,%d3
	btst #21,%d1
	jeq .L146
	moveq #1,%d0
	or.l %d0,%d3
.L146:
	move.l %d3,lfsr.2914
	btst #21,%d3
	jeq .L92
	eor.w #1,%d3
	move.l %d3,lfsr.2914
.L92:
	move.l %d3,%d4
	and.l #1048575,%d4
	move.l %d2,%d0
	add.l %d2,%d0
	add.l %d0,%d0
	lea (%a2,%d0.l),%a4
	move.l %d2,%d0
	eor.l #1048575,%d0
	cmp.l (%a4),%d0
	jeq .L93
	move.l %d2,-(%sp)
	pea .LC3
	jsr (%a3)
	move.l (%a4),-(%sp)
	move.l %d2,-(%sp)
	pea .LC4
	jsr (%a3)
	lea (20,%sp),%sp
.L93:
	add.l %d4,%d4
	add.l %d4,%d4
	not.l %d3
	and.l #1048575,%d3
	cmp.l (%a2,%d4.l),%d3
	jeq .L94
	move.l %d2,-(%sp)
	pea .LC3
	jsr (%a3)
	move.l (%a4),-(%sp)
	move.l %d2,-(%sp)
	pea .LC4
	jsr (%a3)
	lea (20,%sp),%sp
.L94:
	move.l lfsr.2914,%d1
	move.l %d1,%d0
	add.l %d1,%d0
	btst #21,%d1
	jeq .L147
	moveq #1,%d1
	or.l %d1,%d0
.L147:
	move.l %d0,lfsr.2914
	btst #21,%d0
	jeq .L97
	eor.w #1,%d0
	move.l %d0,lfsr.2914
.L97:
	subq.l #1,%d5
	jeq .L68
	move.l lfsr.2914,%d1
	move.l %d1,%d2
	and.l #1048575,%d2
	jra .L98
.L150:
	moveq #1,%d5
	sub.l %d0,%d5
	move.l %d5,%d0
	move.l %d5,inv.2915
	jra .L69
.L68:
	movem.l (%sp)+,#7228
	rts
	.size	DoMemcheckCycle, .-DoMemcheckCycle
	.section	.rodata.str1.1
.LC5:
	.string	"Initialising SD card\n"
.LC6:
	.string	"FindDrive() returned\n"
.LC7:
	.string	"Changed directory\n"
.LC8:
	.string	"*"
	.text
	.align	2
	.globl	SDCardInit
	.type	SDCardInit, @function
SDCardInit:
	move.l %a2,-(%sp)
	pea .LC5
	lea puts,%a2
	jsr (%a2)
	jsr spi_init
	addq.l #4,%sp
	tst.w %d0
	jne .L158
	move.l (%sp)+,%a2
	rts
.L158:
	jsr FindDrive
	pea .LC6
	jsr (%a2)
	clr.l -(%sp)
	jsr ChangeDirectory
	pea .LC7
	jsr (%a2)
	clr.l -(%sp)
	pea .LC8
	clr.l -(%sp)
	jsr ScanDirectory
	lea (24,%sp),%sp
	moveq #1,%d0
	move.l (%sp)+,%a2
	rts
	.size	SDCardInit, .-SDCardInit
	.align	2
	.globl	makeRect
	.type	makeRect, @function
makeRect:
	move.l 16(%sp),%d0
	rts
	.size	makeRect, .-makeRect
	.globl	__udivsi3
	.globl	__divsi3
	.section	.rodata.str1.1
.LC9:
	.string	"Mouse timed out\n"
.LC10:
	.string	"\r\nWelcome to TG68MiniSOC, a minimal System-on-Chip,\r\nbuilt around Tobias Gubener's TG68k processor core.\r\n"
.LC11:
	.string	"Initializing SD card...\r\n"
.LC12:
	.string	"  SD card error!\r\n"
.LC13:
	.string	"Press F1 to load Image.\r\n"
.LC14:
	.string	"Press F2 for Memory Check.\r\n"
.LC15:
	.string	"Press F3 for rectangles.\r\n"
.LC16:
	.string	"Press F4 to run Dhrystone.\r\n"
.LC17:
	.string	"Press F5 for 640x480 @ 60 Hz.\r\n"
.LC18:
	.string	"Press F6 for 320x480 @ 60 Hz.\r\n"
.LC19:
	.string	"Press F7 for 800x600 @ 52 Hz.\r\n"
.LC20:
	.string	"Press F8 for 768x576 @ 57 Hz.\r\n"
.LC21:
	.string	"Press F9 for 800x600 @ 72 Hz.\r\n"
.LC22:
	.string	"Press F12 to toggle character overlay.\r\n"
.LC23:
	.string	"Switching to image mode\n"
.LC24:
	.string	"Switching to Memcheck mode\n"
.LC25:
	.string	"Switching to Rectangles mode\n"
.LC26:
	.string	"640 x 480 @ 60Hz\n"
.LC27:
	.string	"320 x 480 @ 60Hz\n"
.LC28:
	.string	"800 x 600 @ 52Hz\n"
.LC29:
	.string	"768 x 576 @ 57Hz\n"
.LC30:
	.string	"800 x 600 @ 72HZ\n"
.LC31:
	.string	"Rectangle me\n"
.LC32:
	.string	"Toggling overlay\n"
.LC33:
	.string	"TEST    IMG"
.LC34:
	.string	"Couldn't load test.img"
.LC35:
	.string	"Running Dhrystone benchmark...\r\n"
.LC36:
	.string	"%d DMIPS\r\n"
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	lea (-300,%sp),%sp
	movem.l #16190,-(%sp)
	jsr ClearTextBuffer
	move.l #-2130706390,%a2
	move.w (%a2),%d0
	pea 1152.w
	mulu.w #1000,%d0
	move.l %d0,-(%sp)
	jsr __divsi3
	addq.l #8,%sp
	move.w %d0,-2130706430
	move.w (%a2),%d0
	add.w %d0,%d0
	move.w %d0,-2130706416
	jsr AddMemory
	jsr PS2Init
	jsr VGA_SetSprite
	move.l #1228815,-(%sp)
	jsr malloc
	moveq #15,%d1
	add.l %d1,%d0
	moveq #-16,%d1
	and.l %d1,%d0
	move.l %d0,FrameBuffer
	move.l %d0,-2147483648
	move.l #1228800,-(%sp)
	clr.l -(%sp)
	move.l %d0,-(%sp)
	jsr memset
	jsr EnableInterrupts
	lea (16,%sp),%sp
	lea ps2_ringbuffer_read,%a3
.L162:
	pea mousebuffer
	jsr (%a3)
	addq.l #4,%sp
	tst.w %d0
	jge .L162
	pea 244.w
	pea mousebuffer
	jsr ps2_ringbuffer_write
	clr.w mousetimeout
	move.w #8192,-2130706418
	move.w #1000,-2130706406
	pea mousetimer_int
	pea 3.w
	lea SetIntHandler,%a2
	jsr (%a2)
	lea (16,%sp),%sp
.L164:
	pea mousebuffer
	jsr (%a3)
	addq.l #4,%sp
	cmp.w #250,%d0
	jeq .L163
	tst.w mousetimeout
	jeq .L164
.L165:
	pea .LC9
	lea puts,%a3
	jsr (%a3)
	addq.l #4,%sp
	pea vblank_int
	pea 1.w
	jsr (%a2)
	move.w -2130706390,%d0
	add.w %d0,%d0
	move.w %d0,-2130706416
	move.w #512,-2130706418
	move.w #1000,-2130706414
	pea heartbeat_int
	pea 3.w
	jsr (%a2)
	pea .LC10
	move.l #tb_puts,%d7
	move.l %d7,%a0
	jsr (%a0)
	pea .LC11
	move.l %d7,%a0
	jsr (%a0)
	jsr SDCardInit
	lea (24,%sp),%sp
	tst.w %d0
	jeq .L278
.L167:
	pea .LC13
	move.l %d7,%a0
	jsr (%a0)
	pea .LC14
	move.l %d7,%a0
	jsr (%a0)
	pea .LC15
	move.l %d7,%a0
	jsr (%a0)
	pea .LC16
	move.l %d7,%a0
	jsr (%a0)
	pea .LC17
	move.l %d7,%a0
	jsr (%a0)
	pea .LC18
	move.l %d7,%a0
	jsr (%a0)
	pea .LC19
	move.l %d7,%a0
	jsr (%a0)
	pea .LC20
	move.l %d7,%a0
	jsr (%a0)
	lea (28,%sp),%sp
	move.l #.LC21,(%sp)
	move.l %d7,%a0
	jsr (%a0)
	pea .LC22
	move.l %d7,%a0
	jsr (%a0)
	addq.l #8,%sp
	moveq #4,%d2
	lea TestKey,%a2
	lea VGA_SetScreenMode,%a6
	moveq #46,%d5
	add.l %sp,%d5
	lea FileRead,%a5
	move.l #FileNextSector,%d6
.L168:
	pea 5.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L279
.L169:
	pea 6.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L280
.L171:
	pea 4.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L281
.L173:
	pea 12.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L282
.L175:
	pea 3.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L177
.L181:
	pea 11.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L283
.L179:
	pea 131.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L284
.L183:
	pea 10.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L285
.L186:
	pea 1.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L286
.L189:
	pea 9.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L287
	pea 7.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L215
.L196:
	moveq #3,%d0
	cmp.l %d2,%d0
	jeq .L200
	jcs .L201
	moveq #1,%d1
	cmp.l %d2,%d1
	jeq .L202
	moveq #2,%d0
	cmp.l %d2,%d0
	jne .L168
	move.l FrameBuffer,-(%sp)
	jsr DoMemcheckCycle
	addq.l #4,%sp
	pea 5.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jeq .L169
	jra .L279
.L163:
	lea puts,%a3
	tst.w mousetimeout
	jne .L165
	pea vblank_int
	pea 1.w
	jsr (%a2)
	move.w -2130706390,%d0
	add.w %d0,%d0
	move.w %d0,-2130706416
	move.w #512,-2130706418
	move.w #1000,-2130706414
	pea heartbeat_int
	pea 3.w
	jsr (%a2)
	pea .LC10
	move.l #tb_puts,%d7
	move.l %d7,%a0
	jsr (%a0)
	pea .LC11
	move.l %d7,%a0
	jsr (%a0)
	jsr SDCardInit
	lea (24,%sp),%sp
	tst.w %d0
	jne .L167
	jra .L278
.L286:
	pea .LC30
	jsr (%a3)
	move.l #800,screenwidth
	pea 4.w
	jsr (%a6)
	addq.l #8,%sp
.L193:
	pea 1.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jeq .L189
	pea 1.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L193
	jra .L189
.L285:
	pea .LC29
	jsr (%a3)
	move.l #768,screenwidth
	pea 5.w
	jsr (%a6)
	addq.l #8,%sp
.L190:
	pea 10.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jeq .L186
	pea 10.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L190
	jra .L186
.L284:
	pea .LC28
	jsr (%a3)
	move.l #800,screenwidth
	pea 3.w
	jsr (%a6)
	addq.l #8,%sp
.L187:
	pea 131.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jeq .L183
	pea 131.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L187
	jra .L183
.L283:
	pea .LC27
	jsr (%a3)
	move.l #320,screenwidth
	pea 2.w
	jsr (%a6)
	addq.l #8,%sp
.L184:
	pea 11.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jeq .L179
	pea 11.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L184
	jra .L179
.L177:
	pea .LC26
	jsr (%a3)
	move.l #640,screenwidth
	pea 1.w
	jsr (%a6)
	addq.l #8,%sp
.L180:
	pea 3.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jeq .L181
	pea 3.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L180
	jra .L181
.L282:
	pea .LC23
	jsr (%a3)
	addq.l #4,%sp
.L176:
	pea 12.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L176
	moveq #4,%d2
	pea 3.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jeq .L181
	jra .L177
.L281:
	pea .LC25
	jsr (%a3)
	addq.l #4,%sp
.L174:
	pea 4.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L174
	moveq #3,%d2
	pea 12.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jeq .L175
	jra .L282
.L280:
	pea .LC24
	jsr (%a3)
	addq.l #4,%sp
.L172:
	pea 6.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L172
	moveq #2,%d2
	pea 4.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jeq .L173
	jra .L281
.L279:
	pea .LC23
	jsr (%a3)
	addq.l #4,%sp
.L170:
	pea 5.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L170
	moveq #1,%d2
	pea 6.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jeq .L171
	jra .L280
.L287:
	pea .LC31
	jsr (%a3)
	addq.l #4,%sp
.L194:
	pea 9.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L194
	pea 7.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jeq .L266
	moveq #5,%d2
.L215:
	pea .LC32
	jsr (%a3)
	move.w overlay.3004,%d0
	not.w %d0
	move.w %d0,overlay.3004
	addq.l #4,%sp
	jeq .L197
	jsr VGA_HideOverlay
.L199:
	pea 7.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jeq .L196
.L276:
	pea 7.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L199
	jra .L196
.L201:
	subq.l #4,%d2
	jne .L266
	pea .LC35
	move.l %d7,%a0
	jsr (%a0)
	jsr Dhrystone
	move.l %d0,-(%sp)
	pea .LC36
	pea printf_buffer
	jsr sprintf
	pea printf_buffer
	move.l %d7,%a0
	jsr (%a0)
	lea (20,%sp),%sp
	moveq #3,%d2
	pea 5.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jeq .L169
	jra .L279
.L266:
	moveq #5,%d2
	pea 5.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jeq .L169
	jra .L279
.L200:
	move.w MouseButtons,%d0
	btst #0,%d0
	jeq .L213
	add.w #1024,pen
.L213:
	btst #1,%d0
	jeq .L214
	add.w #-1024,pen
.L214:
	jsr DrawIteration
	move.w pen,-2130706426
	pea 5.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jeq .L169
	jra .L279
.L202:
	pea .LC33
	move.l %d5,-(%sp)
	jsr FileOpen
	addq.l #8,%sp
	tst.b %d0
	jne .L288
	pea .LC34
	jsr (%a3)
	addq.l #4,%sp
.L267:
	moveq #0,%d2
.L291:
	pea 5.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jeq .L169
	jra .L279
.L288:
	move.l FrameBuffer,%d4
	move.l 70(%sp),%d0
	moveq #9,%d1
	lsr.l %d1,%d0
	move.w %d0,%a4
	moveq #0,%d3
	moveq #6,%d2
.L207:
	cmp.l %a4,%d3
	jge .L267
	move.l %d4,-(%sp)
	move.l %d5,-(%sp)
	jsr (%a5)
	addq.l #8,%sp
	tst.b %d0
	jne .L289
	subq.l #1,%d2
	jeq .L267
	moveq #3,%d0
	cmp.l %d2,%d0
	jeq .L290
	cmp.l #2400,%d3
	jne .L207
.L277:
	moveq #0,%d2
	jra .L291
.L290:
	jsr SDCardInit
	tst.w %d0
	jeq .L267
	pea .LC33
	move.l %d5,-(%sp)
	jsr FileOpen
	addq.l #8,%sp
	tst.b %d0
	jeq .L267
	cmp.l #2400,%d3
	jne .L207
	jra .L277
.L289:
	addq.l #1,%d3
	move.l %d5,-(%sp)
	move.l %d6,%a0
	jsr (%a0)
	add.l #512,%d4
	addq.l #4,%sp
	cmp.l #2400,%d3
	jne .L207
	jra .L277
.L197:
	jsr VGA_ShowOverlay
	pea 7.w
	jsr (%a2)
	addq.l #4,%sp
	tst.w %d0
	jne .L276
	jra .L196
.L278:
	pea .LC12
	move.l %d7,%a0
	jsr (%a0)
	addq.l #4,%sp
	pea .LC13
	move.l %d7,%a0
	jsr (%a0)
	pea .LC14
	move.l %d7,%a0
	jsr (%a0)
	pea .LC15
	move.l %d7,%a0
	jsr (%a0)
	pea .LC16
	move.l %d7,%a0
	jsr (%a0)
	pea .LC17
	move.l %d7,%a0
	jsr (%a0)
	pea .LC18
	move.l %d7,%a0
	jsr (%a0)
	pea .LC19
	move.l %d7,%a0
	jsr (%a0)
	pea .LC20
	move.l %d7,%a0
	jsr (%a0)
	lea (28,%sp),%sp
	move.l #.LC21,(%sp)
	move.l %d7,%a0
	jsr (%a0)
	pea .LC22
	move.l %d7,%a0
	jsr (%a0)
	addq.l #8,%sp
	moveq #4,%d2
	lea TestKey,%a2
	lea VGA_SetScreenMode,%a6
	moveq #46,%d5
	add.l %sp,%d5
	lea FileRead,%a5
	move.l #FileNextSector,%d6
	jra .L168
	.size	main, .-main
	.local	mousemode.2861
	.comm	mousemode.2861,2,2
	.local	overlay.3004
	.comm	overlay.3004,2,2
	.data
	.align	2
	.type	inv.2915, @object
	.size	inv.2915, 4
inv.2915:
	.long	1
	.align	2
	.type	lfsr.2914, @object
	.size	lfsr.2914, 4
lfsr.2914:
	.long	1
	.globl	printf_buffer
	.section	.bss
	.type	printf_buffer, @object
	.size	printf_buffer, 256
printf_buffer:
	.zero	256
	.globl	DiskInfo
	.type	DiskInfo, @object
	.size	DiskInfo, 5
DiskInfo:
	.zero	5
	.globl	DirEntryInfo
	.type	DirEntryInfo, @object
	.size	DirEntryInfo, 40
DirEntryInfo:
	.zero	40
	.globl	screenwidth
	.data
	.align	2
	.type	screenwidth, @object
	.size	screenwidth, 4
screenwidth:
	.long	640
	.globl	microseconds
	.section	.bss
	.align	2
	.type	microseconds, @object
	.size	microseconds, 4
microseconds:
	.zero	4
	.globl	mousetimeout
	.align	2
	.type	mousetimeout, @object
	.size	mousetimeout, 2
mousetimeout:
	.zero	2
	.globl	MouseButtons
	.align	2
	.type	MouseButtons, @object
	.size	MouseButtons, 2
MouseButtons:
	.zero	2
	.globl	MouseZ
	.align	2
	.type	MouseZ, @object
	.size	MouseZ, 2
MouseZ:
	.zero	2
	.globl	MouseY
	.align	2
	.type	MouseY, @object
	.size	MouseY, 2
MouseY:
	.zero	2
	.globl	MouseX
	.align	2
	.type	MouseX, @object
	.size	MouseX, 2
MouseX:
	.zero	2
	.local	framecount
	.comm	framecount,2,2
	.globl	FrameBuffer
	.align	2
	.type	FrameBuffer, @object
	.size	FrameBuffer, 4
FrameBuffer:
	.zero	4
	.ident	"GCC: (GNU) 9.3.1 20200817"

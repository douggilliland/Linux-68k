PER_CAP_RAMSIZE equ	$81000028

	section vectors,code
	dc.l	0
	dc.l	Start
	ds.l	62,0

Start:
	; Set stack to the top of memory
	moveq	#1,d0
	moveq	#0,d1
	move.w	PER_CAP_RAMSIZE,d1
	lsl.l	d1,d0
	sub.l	#4,d0
	move.l	d0,a7
	
	; clear bss
	lea.l   __bss_start__,a0    
	move.l  #__bss_end__,d0
l1
	cmp.l   d0,a0
	bge	  l2
	clr.l   (a0)+
	bra.s   l1
l2
	; Set up interrupt vectors...
	lea	.int1,a0
	move.l	a0,$64
	lea	.int2,a0
	move.l	a0,$68
	lea	.int3,a0
	move.l	a0,$6C
	lea	.int4,a0
	move.l	a0,$70
	lea	.int5,a0
	move.l	a0,$74
	lea	.int6,a0
	move.l	a0,$78
	lea	.int7,a0
	move.l	a0,$7C

	; Startup code complete, hand control over to C code.
	pea 1
	pea	.name
	jsr main
.loop
	bra.s .loop
.name
	dc.b	"Bootrom",0

.int1:
	movem.l	d0-7/a0-6,-(a7)	; Preserve scratch registers
	pea	.intend1	; A stub to restore the scratch registers
	move.l	IntHandler1,-(a7)	; equivalent to move.l IntHandler1,reg; jmp reg - without using registers
	rts

.int2:
	movem.l	d0-7/a0-6,-(a7)	; Preserve scratch registers
	pea	.intend1
	move.l	IntHandler2,-(a7)
	rts

.int3:
	movem.l	d0-7/a0-6,-(a7)	; Preserve scratch registers
	pea	.intend1
	move.l	IntHandler3,-(a7)
	rts

.int4:
	movem.l	d0-7/a0-6,-(a7)	; Preserve scratch registers
	pea	.intend1
	move.l	IntHandler4,-(a7)
	rts

.int5
	movem.l	d0-7/a0-6,-(a7)	; Preserve scratch registers
	pea	.intend1
	move.l	IntHandler5,-(a7)
	rts

.int6
	movem.l	d0-7/a0-6,-(a7)	; Preserve scratch registers
	pea	.intend1
	move.l	IntHandler6,-(a7)
	rts

.int7
	movem.l	d0-7/a0-6,-(a7)	; Preserve scratch registers
	pea	.intend1
	move.l	IntHandler7,-(a7)
	rts

.intend1
	movem.l	(a7)+,d0-d7/a0-a6
	rte

DummyIntHandler
	rts

; Interrupt handler table, modified by C code.
IntHandler1	dc.l	DummyIntHandler
IntHandler2 dc.l	DummyIntHandler
IntHandler3 dc.l	DummyIntHandler
IntHandler4 dc.l	DummyIntHandler
IntHandler5 dc.l	DummyIntHandler
IntHandler6 dc.l	DummyIntHandler
IntHandler7 dc.l	DummyIntHandler

EnableInterrupts ; FIXME - use a trap or suchlike to make this happen even if we're in user mode.
	move.w	#$2000,SR
	rts

DisableInterrupts
	move.w	#$2700,SR
	rts

	cnop 0,16 ; must be aligned to a burst boundary.
StandardPointer
	dc.l $CF000000,$00000000
	dc.l $8CFFF000,$00000000
	dc.l $08CCFFF0,$00000000
	dc.l $08CCCCFF,$FF000000
	dc.l $088CCCCC,$CFFF0000
	dc.l $008CCCCC,$CCC80000
	dc.l $0088CCCC,$CC800000
	dc.l $0008CCCC,$CF000000
	dc.l $0008CCCC,$CCF00000
	dc.l $00088CC8,$CCCF0000
	dc.l $00008C80,$8CCCF000
	dc.l $00008800,$08CCCF00
	dc.l $00000000,$008CCCF0
	dc.l $00000000,$0008CCC8
	dc.l $00000000,$00008C80
	dc.l $00000000,$00000800

	; make symbols visible to C code

	XDEF EnableInterrupts
	XDEF DisableInterrupts
	XDEF IntHandler1
	XDEF IntHandler2
	XDEF IntHandler3
	XDEF IntHandler4
	XDEF IntHandler5
	XDEF IntHandler6
	XDEF IntHandler7
	XDEF StandardPointer

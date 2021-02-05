SPI_PUMP	equ	$81000100

	XDEF spi_readsector
spi_readsector
	move.l	4(a7),a0
	movem.l	d2-d7/a2,-(a7)

	moveq	#15,d7
	lea	SPI_PUMP,a1
	move.w	(a1),d0
.loop
	movem.l	(a1),d0-d6/a2
	movem.l	d0-d6/a2,(a0)
	add.l	#32,a0
	dbf	d7,.loop

	movem.l	(a7)+,d2-d7/a2
	rts

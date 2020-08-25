_start():
        link.w %fp,#0
.L2:
        move.b 65601,%d0
        btst #1,%d0
        jeq .L2
.L8:
        move.b #84,65603
        move.b 65601,%d0
        btst #1,%d0
        jeq .L2
        jra .L8
printCharToACIA(unsigned char):
        link.w %fp,#0
        move.l 8(%fp),%d1
.L10:
        move.b 65601,%d0
        btst #1,%d0
        jeq .L10
        move.b %d1,65603
        unlk %fp
        rts
printStringToACIA(char const*):
        link.w %fp,#0
        move.l 8(%fp),%a0
        move.b (%a0),%d1
        jeq .L15
.L17:
        move.b 65601,%d0
        btst #1,%d0
        jeq .L17
        move.b %d1,65603
        move.b (%a0),%d1
        jne .L17
.L15:
        unlk %fp
        rts
		
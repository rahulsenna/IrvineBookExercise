; Link Library Test #2 (TestLib2.asm)
; Testing the Irvine32 Library procedures

INCLUDE Irvine32.inc

TAB = 9									; ASCII code for Tab


.CODE
main	PROC

	call	Randomize ; init random generator
	call	Rand1
	call	Rand2
	
	exit

main	ENDP

Rand1	PROC	
; Generate ten pseudo-random integers.

	mov		ecx,10
L1:	
	call	Random32
	call	WriteDec
	mov		al,TAB
	call	WriteChar
	loop	L1
	
	call	Crlf
	ret
Rand1	ENDP


Rand2	PROC

; Generate ten pseudo-random integers from -50 to +49
	mov		ecx,10
L1:
	mov		eax,100			; values 0 to 99
	call	RandomRange
	sub		eax,50			; values -50 to +49
	call	WriteInt
	mov		al,TAB
	call	WriteChar
	loop	L1

	call	Crlf
	ret
Rand2	ENDP

END		main
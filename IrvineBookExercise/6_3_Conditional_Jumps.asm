;		6.3 Conditional Jumps
;		Put the lowest of the 3 in ax register

INCLUDE	Irvine32.inc


.DATA
	V1		WORD		?
	V2		WORD		?
	V3		WORD		?

.CODE
main		PROC
;----------------------------------------------
	call	Randomize

	mov		eax,99
	call	RandomRange
	mov		V1,ax

	mov		eax,99
	call	RandomRange
	mov		V2,ax
	
	mov		eax,99
	call	RandomRange
	mov		V3,ax
;-------------------------------------------------
	mov		ax,V1
	cmp		ax,V2
	JBE		L1
	mov		ax,V2
L1:
	cmp		ax,V3
	JBE		EndRoutine
	mov		ax,V3
EndRoutine:

	exit
main		ENDP

END		main
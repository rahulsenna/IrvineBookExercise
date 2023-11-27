INCLUDE	Irvine32.inc

.DATA

.CODE


;-----------------------------------------------------
GCD		PROC,
	A:DWORD,
	B:DWORD
;
; Find GCD using Euclid’s algorithm
; Returns: EAX = result
;-----------------------------------------------------
	cmp		A,0
	je		C1

	cmp		B,0
	je		C2

	mov		eax,A
	mov		ebx,B
	xor		edx,edx
	div		ebx
	INVOKE	GCD,B,edx	
	
	ret
C1:
	mov		eax,B
	ret	
C2:
	mov		eax,A
	ret

GCD		ENDP

main	PROC

	INVOKE	GCD, 270,192
	call	WriteInt
	call	Crlf

	INVOKE	GCD, 432,226
	call	WriteInt
	call	Crlf
	
	INVOKE	GCD, 11,7
	call	WriteInt
	call	Crlf
	
	exit
main	ENDP


END		main
INCLUDE	Irvine32.inc

.DATA

.CODE

DifferentInputs	PROTO,
	One:DWORD,
	Two:DWORD,
	Three:DWORD	


main	PROC

	INVOKE	DifferentInputs, 3,4,5
	call	WriteInt
	call	Crlf
	
	INVOKE	DifferentInputs, 1,2,3
	call	WriteInt
	call	Crlf
	
	INVOKE	DifferentInputs, 3,4,3
	call	WriteInt
	call	Crlf
	
	INVOKE	DifferentInputs, 3,3,3
	call	WriteInt
	call	Crlf

	INVOKE	DifferentInputs, 1,3,3
	call	WriteInt
	call	Crlf
main	ENDP

;-----------------------------------------------------
DifferentInputs		PROC,
	One:DWORD,
	Two:DWORD,
	Three:DWORD	
;
; Checks if all three arguments are different
; Returns: EAX = Result of search
;-----------------------------------------------------
	xor		eax,eax
	
	mov		ebx,One
	mov		ecx,Two
	mov		edx,Three

	cmp		ebx,ecx
	je		ExitProc

	cmp		ebx,edx
	je		ExitProc
	
	cmp		ecx,edx
	je		ExitProc

	mov		eax,1
ExitProc:

	ret
DifferentInputs		ENDP

END		main
INCLUDE Irvine32.inc

.DATA

	arr1	DWORD	1,2,3,3,3,4,5,6,7,8,9
	size1	=		($-arr1)/4

	arr2	DWORD	1,2,3,4,5,6,7,8,9,0
	size2	=		($-arr2)/4

.CODE




;-----------------------------------------------------
FindThrees	PROC,
    ArrayPTR:PTR DWORD,
    ArraySize:DWORD
    LOCAL    Res:DWORD
;
; Finds	Three consecutive 3s
; Returns: EAX = Result of search
;-----------------------------------------------------

	mov		Res,0
    pushad          ; save registers

	mov		ecx,ArraySize
	dec		ecx					;
	mov		esi,ArrayPTR
	add		esi,4				;
L1:
	cmp		DWORD PTR [esi-4],3
	jne		NoConsecutive
	
	cmp		DWORD PTR [esi],3
	jne		NoConsecutive
	
	cmp		DWORD PTR [esi+4],3
	jne		NoConsecutive
	
	mov		Res,1
	jmp		EndLoop

NoConsecutive:
	add		esi,4
	loop	L1

EndLoop:
	popad           ; save registers
	mov		eax,Res
    ret
FindThrees    ENDP

main    PROC

	INVOKE	FindThrees,addr arr1,size1
	call	WriteInt
	call	Crlf
	
	INVOKE	FindThrees,addr arr2,size2
	call	WriteInt
	call	Crlf
    
	exit
main    ENDP

END    main
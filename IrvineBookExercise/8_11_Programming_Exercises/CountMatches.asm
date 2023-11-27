INCLUDE	Irvine32.inc

.DATA
	arr1	DWORD	1,2,3,4,5,6,7,8,9
	arr2	DWORD	9,8,7,6,5,4,3,2,1
	arr_size	=		($-arr2)/4

	t_arr1	DWORD	1,8,3,4,5,6,3,8,9
	t_arr2	DWORD	9,8,7,6,5,4,3,2,1
	t_arr_size	=		($-t_arr2)/4
.CODE
;-----------------------------------------------
;			PROTOTYPES
CountMatches	PROTO,			
	ArrOnePTR:PTR DWORD,
	ArrTwoPTR:PTR DWORD,
	ArrSize:DWORD

CountNearMatches	PROTO,
	ArrOnePTR:PTR DWORD,
	ArrTwoPTR:PTR DWORD,
	ArrSize:DWORD,
	diff:DWORD
;-----------------------------------------------

main	PROC
	
	INVOKE	CountMatches,ADDR arr1,ADDR arr2, arr_size
	call	WriteInt
	call	Crlf

	INVOKE	CountMatches,ADDR t_arr1,ADDR t_arr2, t_arr_size
	call	WriteInt
	call	Crlf


	INVOKE	CountNearMatches,ADDR arr1,ADDR arr2, arr_size, 3
	call	WriteInt
	call	Crlf

	INVOKE	CountNearMatches,ADDR t_arr1,ADDR t_arr2, t_arr_size, 3
	call	WriteInt
	call	Crlf


	INVOKE	CountNearMatches,ADDR arr1,ADDR arr2, arr_size, 10
	call	WriteInt
	call	Crlf

	exit
main	ENDP


;-----------------------------------------------------
CountNearMatches	PROC USES esi edi ebx,
	ArrOnePTR:PTR DWORD,
	ArrTwoPTR:PTR DWORD,
	ArrSize:DWORD,
	diff:DWORD
;
; Tallies the NEARLY matching values at corresponding positions in two arrays.
; Returns: EAX = match count
;-----------------------------------------------------
	xor		eax,eax

	mov		ecx,ArrSize
	mov		esi,ArrOnePTR
	mov		edi,ArrTwoPTR
L1:
	mov		ebx,[esi]
	sub		ebx,[edi]
	js		Negative	; jump if signed
	sub		ebx,diff
	cmp		ebx,0
	jg		Continue	; num-diff > 0
	jmp		NearMatch
Negative:				; arr1[i]-arr2[i] = negative num

	add		ebx,diff
	cmp		ebx,0
	jl		Continue	; negNum+diff < 0
NearMatch:
	inc		eax
Continue:
	add		esi,4
	add		edi,4
	loop	L1
	ret
CountNearMatches	ENDP




;-----------------------------------------------------
CountMatches	PROC USES esi edi ebx,
	ArrOnePTR: PTR DWORD,
	ArrTwoPTR: PTR DWORD,
	ArrSize:DWORD
;
; Tallies the matching values at corresponding positions in two arrays.
; Returns: EAX = match count
;-----------------------------------------------------
	xor		eax,eax
	mov		ecx,ArrSize
	mov		esi,ArrOnePTR
	mov		edi,ArrTwoPTR

L1:
	mov		ebx,[esi]
	cmp		ebx,[edi]
	jne		Continue
	inc		eax
Continue:
	add		esi,4
	add		edi,4
	loop	L1
	ret
CountMatches	ENDP



END		main
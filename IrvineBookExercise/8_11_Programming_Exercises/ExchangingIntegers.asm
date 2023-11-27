INCLUDE	Irvine32.inc

.DATA
	arr1	DWORD	1,2,3,4,5,6
	size1	=		($-arr1)/4

.CODE

;-------------------------------------------------------
Swap PROC USES eax esi edi,
pValX:PTR DWORD, ; pointer to first integer
pValY:PTR DWORD ; pointer to second integer
;
; Exchange the values of two 32-bit integers
; Returns: nothing
;-------------------------------------------------------
	mov		esi,pValX
	mov		edi,pValY

	mov		eax,[esi]
	xchg	eax,[edi]
	mov		[esi],eax
ret
Swap ENDP

;-----------------------------------------------------
Exchanging_Ints	PROC,
	ArrayPTR: PTR DWORD,
	ArrayLen: DWORD
;
; Exchanges consicutive pairs of integers
; Returns: nothing
;-----------------------------------------------------
	mov		ecx,ArrayLen
	shr		ecx,1
	mov		esi,ArrayPTR
	add		esi,4
L1:
	INVOKE	Swap, ArrayPTR, esi
	add		ArrayPTR,8
	add		esi,8
	loop	L1

	ret
Exchanging_Ints	ENDP




main	PROC

	INVOKE	Exchanging_Ints, addr arr1,size1
	exit
main	ENDP


END		main
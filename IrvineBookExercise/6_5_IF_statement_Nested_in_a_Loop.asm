
INCLUDE Irvine32.inc

.DATA
	array		DWORD		10,60,20,33,72,89,45,65,72,18
	arraySize	DWORD		LENGTHOF array
	sample		DWORD		50
	sum			DWORD		?
	
.CODE
main		PROC
;-------------------------------------------------------------
;					My	Version
	mov		ecx,arraySize
	mov		edx,sample
	xor		eax,eax
BeginLoop:
	cmp		array[ecx * TYPE array - TYPE array],edx
	jbe		EndLoop
	add		eax,array[ecx * TYPE array - TYPE array]
EndLoop:
	loop	BeginLoop

	mov		sum,eax
;-------------------------------------------------------------
;					Book Version

	
	mov		sum,0
	mov		ecx,arraySize
	mov		esi,0
	mov		edx,sample
	xor		eax,eax

BegLoop:	
	cmp		esi,ecx
	jg		EndRoutine

	cmp		array[esi * TYPE array],edx
	jbe		EndLoop1
	add		eax,array[esi * TYPE array]
EndLoop1:
	inc		esi
	jmp		BegLoop

EndRoutine:
	mov		sum,eax
	


	exit
main		ENDP

END		main
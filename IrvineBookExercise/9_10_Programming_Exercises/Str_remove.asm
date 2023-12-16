INCLUDE	Irvine32.inc

.DATA

	target BYTE "abcxxxxdefghijklmop",0

.CODE


;-----------------------------------------------------
 Str_remove	PROC,
	start_ptr: ptr byte,
	N: dword
;
; Removes characters in range
; Returns: nothing
;-----------------------------------------------------
	mov edi,start_ptr
	mov esi,edi
	add esi,N
	INVOKE Str_length, esi
	mov ecx,eax

	rep movsb
	mov byte ptr[edi],0 ; null terminate

	ret
 Str_remove	ENDP

main	PROC
	INVOKE Str_remove, ADDR [target+3], 4
	exit
main	ENDP


END		main
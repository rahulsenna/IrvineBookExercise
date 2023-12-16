INCLUDE	Irvine32.inc

.DATA

	targetStr BYTE "ABCDE",10 DUP(0)
	sourceStr BYTE "FGH",0

.CODE


;-----------------------------------------------------
Str_concat		PROC,
	dest_str: ptr byte,
	src_str: ptr byte
;
; Concatenates src string to dest
; Returns: nothing
;-----------------------------------------------------

	mov esi,src_str
	mov edi,dest_str

	INVOKE Str_length, dest_str
	add edi,eax

	INVOKE Str_length, src_str
	mov ecx,eax

	rep movsb
	ret
Str_concat		ENDP

main	PROC

	mov edx,OFFSET targetStr
	call WriteString
	call Crlf

	INVOKE Str_concat, ADDR targetStr, ADDR sourceStr

	mov edx,OFFSET targetStr
	call WriteString
	call Crlf

	exit
main	ENDP


END		main
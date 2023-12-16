INCLUDE	Irvine32.inc

.DATA
	some_string BYTE "###ABC",0
.CODE


;-----------------------------------------------------
Str_trim_leading PROC,
	StringPTR: PTR BYTE,
	delim: BYTE
;
; Remove all instances of a leading character from a string
; Returns: EAX = new String pointer
;-----------------------------------------------------
	INVOKE Str_length, StringPTR
	mov ecx,eax
	mov edi,StringPTR
	mov al, delim
	repe scasb
	mov eax,edi
	dec eax

	ret
Str_trim_leading ENDP

main	PROC
	mov edx,OFFSET some_string
	call WriteString
	call Crlf

	INVOKE Str_trim_leading, ADDR some_string, '#'
	mov edx,eax
	call WriteString
	call Crlf
	exit
main	ENDP


END		main
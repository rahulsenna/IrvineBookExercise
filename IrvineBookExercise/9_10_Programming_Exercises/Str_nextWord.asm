INCLUDE	Irvine32.inc

.DATA
	target BYTE "Johnson,Calvin",0
	prev_msg BYTE "Prev Word: ",0
	next_msg BYTE "Next Word: ",0
	not_found_msg BYTE "Did not find next word!!!",0

.CODE


;-----------------------------------------------------
Str_nextWord PROC,
	tgt: PTR BYTE,
	delim: BYTE,
;
; Finds next word based on a delimeter
; Returns: EAX = points to next word
;-----------------------------------------------------
	invoke Str_length, tgt
	mov ecx,eax
	mov al, delim
	mov edi, tgt
	repne scasb
	cmp ecx,0
	jg Found
NotFound:
	xor eax,eax
	cmp eax,1    ; clearing Zero flag
	ret
Found:
	mov BYTE PTR[edi-1],0  ; null terminating previous word
	mov eax,edi
	cmp eax,eax  ; setting Zero flag
	ret
Str_nextWord ENDP

main	PROC

	INVOKE Str_nextWord, ADDR target, ','
	jnz notFound
	mov edx, OFFSET next_msg
	call WriteString

	mov edx,eax
	call WriteString
	call Crlf

	mov edx, OFFSET prev_msg
	call WriteString
	mov edx, OFFSET target
	call WriteString
	call Crlf
	exit

notFound:
	mov edx,OFFSET not_found_msg
	call WriteString
	call Crlf
	exit
main	ENDP


END		main
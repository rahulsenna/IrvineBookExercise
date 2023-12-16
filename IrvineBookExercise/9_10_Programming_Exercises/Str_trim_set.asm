INCLUDE	Irvine32.inc

.DATA
	some_string BYTE "ABC#$&",0
	str_len = ($-some_string)-1

	delim_set BYTE "%#!;$&*"
	delim_len = ($-delim_set)

.CODE


;-----------------------------------------------------
Str_trim_set PROC,
	StringPTR: PTR BYTE,
	StringLen: DWORD,
	delimPTR: PTR BYTE,
	delimLen: DWORD
;
; Removes all instances of a set of characters from the end of a string
; Returns: nothing
;-----------------------------------------------------
	mov ecx,StringLen
	dec ecx               ; omitting null char
	mov esi,StringPTR

L1:
	mov al,[esi+ecx]
	mov edi,delimPTR
	push ecx
	mov ecx, delimLen
	repne scasb
	pop ecx
	jne Done

Loop L1
	ret
Done:
	mov BYTE PTR [esi+ecx+1],0
	ret
Str_trim_set ENDP

main	PROC
	mov edx, offset some_string
	call WriteString
	call Crlf

	INVOKE Str_trim_set, ADDR some_string, str_len, ADDR delim_set, delim_len
	mov edx, offset some_string
	call WriteString
	call Crlf

	exit
main	ENDP


END		main
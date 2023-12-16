INCLUDE	Irvine32.inc

.DATA
	target BYTE "123ABC342432",0
	source BYTE "ABC",0
	not_found_msg BYTE "Not Found!!!",0

	pos DWORD ?

.CODE

;-----------------------------------------------------
Str_find PROC,
	src: PTR BYTE,
	tgt: PTR BYTE
;
; Finds if a substring is in a String
; Returns: EAX = Position of substring inside the string
;-----------------------------------------------------
	mov edi,tgt

	invoke Str_length, tgt
	mov ecx,eax	
	mov ebx,eax		; for counting pos
L1:
	mov esi,src
	repe cmpsb
	cmp byte ptr [esi-1],0  ; end of the search string
	je Found
	cmp ecx,0 
	jg L1
NotFound:
	mov eax,-1
	cmp eax,0    ; clear zero flag (eax=-1)
	ret
Found:
	sub ebx,ecx
	invoke Str_length, src
	sub ebx,eax
	dec ebx
	mov eax,ebx
	cmp eax,eax ; set zero flag
	ret
Str_find ENDP

main	PROC

	INVOKE Str_find, ADDR source, ADDR target
	jnz notFound
	mov pos,eax ; store the position value
	call WriteInt
	call Crlf
	exit

notFound:
	mov edx, OFFSET not_found_msg
	call WriteString
	exit
main	ENDP


END		main
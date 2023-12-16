INCLUDE	Irvine32.inc

Str_copyN		PROTO,
	src:  PTR BYTE,    ; source
	dest: PTR BYTE,    ; destination
	N:    DWORD         ; chars to copy 

.DATA

	src_str BYTE "Hello this is a test string",0
	STR_CNT = ($-src_str)
	dest_str BYTE STR_CNT dup(1)

.CODE


main	PROC

	INVOKE Str_copyN, ADDR src_str, ADDR dest_str, STR_CNT
	mov edx, OFFSET dest_str
	call WriteString
	call Crlf

	INVOKE Str_copyN, ADDR src_str, ADDR dest_str, 10
	mov edx, OFFSET dest_str
	call WriteString
	call Crlf


	INVOKE Str_copyN, ADDR src_str, ADDR dest_str, 5
	mov edx, OFFSET dest_str
	call WriteString
	call Crlf

	exit
main	ENDP


;-----------------------------------------------------
Str_copyN		PROC USES ESI edi ecx,
	src:  PTR BYTE,    ; source
	dest: PTR BYTE,    ; destination
	N:    DWORD,        ; chars to copy 
;
; Copies N numbers of chars from a source string to dest 
; Returns: nothing
;-----------------------------------------------------
	mov ecx,N
	mov esi,src
	mov edi, dest
	rep movsb
	mov BYTE PTR[edi],0  ; null terminate in case of (N) count is lower than src string length
	ret
Str_copyN		ENDP


END		main
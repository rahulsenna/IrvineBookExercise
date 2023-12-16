INCLUDE	Irvine32.inc

.DATA
		arr DWORD 467,89,723,321,556,42,888,175,633,945,208,779,514,66,327,931,154,788,602,45
        arr_len = ($-arr)/TYPE DWORD

.CODE


;-----------------------------------------------------
BubbleSort		PROC,
	ArrayPTR: PTR DWORD,
	ArrayLen: DWORD
;
; Sorts an array using Bubble Sort alogrithm
; Returns: nothing
;-----------------------------------------------------
	mov ecx, ArrayLen
	dec ecx
OuterLoop:
	push ecx
	mov esi,ArrayPTR
	mov edi,0
InnerLoop:
	mov eax,[esi]
	cmp eax,[esi+4]
	jle Continue
	xchg eax,[esi+4]
	mov [esi],eax
	inc edi				; exhange flag
Continue:
	add esi,4

Loop InnerLoop
	pop ecx
	dec ecx
	cmp edi,0            ; exhange flag
	ja OuterLoop

	ret
BubbleSort		ENDP

main	PROC
	INVOKE BubbleSort, ADDR arr, arr_len
	mov ecx, arr_len
	mov esi, OFFSET arr
PrintLoop:
	lodsd
	call WriteInt
	call Crlf
Loop PrintLoop

	exit
main	ENDP


END		main
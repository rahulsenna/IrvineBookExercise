BubbleSort		PROTO,
	ArrayPTR: PTR DWORD,
	ArrayLen: DWORD

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

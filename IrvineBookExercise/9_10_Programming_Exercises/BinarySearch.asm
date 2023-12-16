INCLUDE	Irvine32.inc
INCLUDE	BubbleSort.inc

.DATA
		arr DWORD 1000, 467,89,723,321,556,42,888,175,633,945,208,779,514,66,327,931,154,788,602,45
        arr_len = ($-arr)/TYPE DWORD

		not_found_msg byte "Number not found!!!",0
		found_msg byte "Number found at location: ",0

.CODE


;-----------------------------------------------------
BinarySearch PROC,
	ArrayPTR:   PTR DWORD,
	ArrayLen:   DWORD,
	ItemToFind: DWORD
;
; Finds an item in the Array using BinarySearch
; Returns: EAX = Position of the item in the Array
;-----------------------------------------------------
	mov esi,ArrayPTR
	mov edx,ItemToFind
	mov ebx,0			; First
	mov edi,ArrayLen	; Last
L1:
	mov ecx,edi
	add ecx,ebx			; First+Last
	shr ecx,1			; Mid = First+Last / 2

	mov eax,[esi+ecx*4]
	cmp eax,edx
	je Found
	jl GoHigh
	jg GoLow

GoHigh:
	mov ebx,ecx
	inc ebx
	jmp ContinueLoop

GoLow:
	mov edi,ecx
	dec edi
ContinueLoop:
	cmp ebx,edi
	jle L1
NotFound:
	mov eax,-1	
	jmp EndOfProc
Found:
	mov eax,ecx

EndOfProc:
	ret
BinarySearch ENDP

main	PROC
	INVOKE BubbleSort, ADDR arr, arr_len			; sort the array
	INVOKE BinarySearch, ADDR arr, arr_len, 89

	cmp eax,-1
	je NotFound
	mov edx,OFFSET found_msg
	call WriteString
	call WriteInt

	ret
NotFound:
	mov edx,OFFSET not_found_msg
	call WriteString
	exit
main	ENDP


END		main
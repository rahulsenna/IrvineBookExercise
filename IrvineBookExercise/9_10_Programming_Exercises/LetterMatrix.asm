INCLUDE	Irvine32.inc

.DATA
	mat_arr BYTE 4*4 dup(?)
	alphabet BYTE "BCDFGHJKLMNPQRSTVWXYZ"
			 BYTE "AEIOUAEIOUAEIOUAEIOUA"
	alphabet_size = ($-alphabet)
.CODE


;-----------------------------------------------------
GenMatrix	PROC USES ecx,
	Mat4x4_PTR:   PTR BYTE,
	ColSize:      DWORD,
	AlphabetPTR:  PTR BYTE,
	AlphabetSize: DWORD
;
; Generates a four-by-four matrix of randomly chosen capital letters.
; Returns: nothing
;-----------------------------------------------------
	call Randomize
	mov esi,Mat4x4_PTR
	mov edi,AlphabetPTR
	mov ecx,4*4
RandAlpha:
	mov eax, AlphabetSize
	call RandomRange
	mov al, [edi+eax]
	mov [esi+ecx-1],al
Loop RandAlpha

	ret
GenMatrix	ENDP

;-----------------------------------------------------
PrintMatrix PROC USES ecx,
	Mat4x4_PTR:   PTR BYTE,
	ColSize:      DWORD
;
; Prints a four-by-four matrix of randomly chosen capital letters.
; Returns: nothing
;-----------------------------------------------------

	mov ebx,Mat4x4_PTR
	mov esi,0  ; row
	mov ecx,4
R1:
	mov edi,0  ; col
	push ecx
	mov ecx,4
C1:
	mov eax,esi
	mul ColSize
	add eax,edi
	mov al, [ebx+eax]
	call WriteChar
	mov al, ' '
	call WriteChar
	inc edi
Loop C1
	call Crlf
	inc esi   ; next row
	pop ecx
Loop R1
	ret
PrintMatrix ENDP

main	PROC
	mov ecx,5
L1:
	INVOKE GenMatrix, ADDR mat_arr, 4, ADDR alphabet, alphabet_size
	INVOKE PrintMatrix, ADDR mat_arr, 4
	call Crlf
	call Crlf

Loop L1

	exit
main	ENDP


END		main
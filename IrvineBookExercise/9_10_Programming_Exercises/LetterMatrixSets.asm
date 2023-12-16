INCLUDE	Irvine32.inc

.DATA
	mat_arr BYTE 4*4 dup(?)
	alphabet BYTE "BCDFGHJKLMNPQRSTVWXYZ"
			 BYTE "AEIOUAEIOUAEIOUAEIOUA"
	alphabet_size = ($-alphabet)
	vowels byte "AEIOU"
	rows_label byte "------------ROWS--------------",0
	cols_label byte "------------COLS--------------",0
	diag_label byte "------------DIAG--------------",0
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





;-----------------------------------------------------
RowLetterSets PROC USES ecx,
	Mat4x4_PTR:   PTR BYTE,
	ColSize:      DWORD
;
; Prints  four letter sets of a matrix if two letters in that set are vowels
; Returns: nothing
;-----------------------------------------------------
	LOCAL LetterSet:QWORD,
	VowelCount:DWORD
	mov esi, Mat4x4_PTR
	mov ebx,0

	mov ecx,ColSize
Rows:
	push ecx
	mov ecx,ColSize
	lea edx, LetterSet
	mov VowelCount,0
Row:
	mov al,[esi+ebx]
	mov edi, OFFSET vowels
	push ecx
	mov ecx,6     ; vowel size
	repne scasb
	pop ecx
	jne NotVowel
	inc VowelCount
NotVowel:
	mov [edx],al
	inc edx
	inc ebx
	
Loop Row
	mov BYTE PTR [edx],0 ; null terminate 4LetterSet
	cmp VowelCount,2
	jne NotTwoVowels
	lea edx, LetterSet
	call WriteString
	call Crlf
NotTwoVowels:
	pop ecx
Loop Rows
	ret
RowLetterSets ENDP

;-----------------------------------------------------
ColLetterSets PROC USES ecx,
	Mat4x4_PTR:   PTR BYTE,
	ColSize:      DWORD
;
; Prints  four letter sets of a matrix if two letters in that set are vowels
; Returns: nothing
;-----------------------------------------------------
	LOCAL LetterSet:QWORD,
	VowelCount:DWORD
	mov esi, Mat4x4_PTR
	mov ebx,0

	mov ecx,ColSize
Cols:
	push ecx
	push ebx
	mov ecx,ColSize
	lea edx, LetterSet
	mov VowelCount,0
Col:
	mov al,[esi+ebx]
	mov edi, OFFSET vowels
	push ecx
	mov ecx,6
	repne scasb
	pop ecx
	jne NotVowel
	inc VowelCount
NotVowel:
	mov [edx],al
	inc edx
	add ebx,ColSize
	
Loop Col
	mov BYTE PTR [edx],0 ; null terminate 4LetterSet
	cmp VowelCount,2
	jne NotTwoVowels
	lea edx, LetterSet
	call WriteString
	call Crlf
NotTwoVowels:
	pop ebx
	inc ebx
	pop ecx
Loop Cols

	ret
ColLetterSets ENDP


;-----------------------------------------------------
DiagLetterSets PROC USES ecx,
	Mat4x4_PTR:   PTR BYTE,
	ColSize:      DWORD,
	LeftToRight:DWORD
;
; Prints  four letter sets of a matrix if two letters in that set are vowels
; Returns: nothing
;-----------------------------------------------------
	LOCAL LetterSet:QWORD,
	VowelCount:DWORD,
	Stride:DWORD

	mov esi, Mat4x4_PTR

	cmp LeftToRight,1
	je LeftToRightProc

RightToLeftProc:
	mov Stride,3
	add esi,3
	jmp ToProc
LeftToRightProc:
	mov Stride,5

ToProc:

	
	mov ebx,0
	mov ecx,ColSize
	lea edx, LetterSet
	mov VowelCount,0
Diag:
	mov al,[esi+ebx]
	mov edi, OFFSET vowels
	push ecx
	mov ecx,6
	repne scasb
	pop ecx
	jne NotVowel
	inc VowelCount
NotVowel:
	mov [edx],al
	inc edx
	add ebx,Stride
	
Loop Diag
	mov BYTE PTR [edx],0 ; null terminate 4LetterSet
	cmp VowelCount,2
	jne NotTwoVowels
	lea edx, LetterSet
	call WriteString
	call Crlf
NotTwoVowels:

	ret
DiagLetterSets ENDP


main	PROC
	mov ecx,5
L1:
	INVOKE GenMatrix, ADDR mat_arr, 4, ADDR alphabet, alphabet_size
	INVOKE PrintMatrix, ADDR mat_arr, 4
	call Crlf
	call Crlf

	mov edx, OFFSET rows_label
	call WriteString
	call Crlf
	INVOKE RowLetterSets, ADDR mat_arr, 4

	mov edx, OFFSET cols_label
	call WriteString
	call Crlf
	INVOKE ColLetterSets, ADDR mat_arr, 4


	mov edx, OFFSET diag_label
	call WriteString
	call Crlf
	INVOKE DiagLetterSets, ADDR mat_arr, 4,1  ; left to right diag
	INVOKE DiagLetterSets, ADDR mat_arr, 4,0  ; right to left diag

	call Crlf
	call Crlf

	dec ecx
	cmp ecx,0
	jg L1
;Loop L1

	exit
main	ENDP


END		main
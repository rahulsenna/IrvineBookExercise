INCLUDE	Irvine32.inc

.DATA

tableB BYTE 10h, 20h, 30h, 40h, 50h
RowsizeB = ($ - tableB)
 BYTE 60h, 70h, 80h, 90h, 0A0h
 BYTE 0B0h, 0C0h, 0D0h, 0E0h, 0F0h

tableW WORD 10h, 20h, 30h, 40h, 50h
RowsizeW = ($ - tableW)/2
 WORD 60h, 70h, 80h, 90h, 0A0h
 WORD 0B0h, 0C0h, 0D0h, 0E0h, 0F0h


tableD DWORD 10h, 20h, 30h, 40h, 50h
RowsizeD = ($ - tableD)/4
 DWORD 60h, 70h, 80h, 90h, 0A0h
 DWORD 0B0h, 0C0h, 0D0h, 0E0h, 0F0h


.CODE


;-----------------------------------------------------
calc_row_sum PROC
;
; Calculates the sum of a single row in a two-dimensional
; array of bytes, words, or doublewords
; Returns: EAX = sum of all the number in a row
;-----------------------------------------------------
;   Prolouge
	push ebp
	mov ebp,esp
;----------------------
	mov edi,[ebp+8]				; row idx
	mov ebx,[ebp+12]			; type array
	mov ecx,[ebp+16]			; row size
	mov esi,[ebp+20]			; Array

	mov eax,edi					; EAX = rowIdx*rowSize* arr type
	mul ecx
	mul ebx         
	add esi,eax

	xor eax,eax

	cmp ebx,1
	je ByteArr
	cmp ebx,2
	je WordArr
	cmp ebx,4
	je DwordArr
	
	mov BYTE PTR [eax],0  ; assert

ByteArr:
	movzx edx, BYTE PTR [esi]
	add eax, edx
	add esi,ebx			; next col
Loop ByteArr
	jmp EndOfProc
WordArr:
	movzx edx, WORD PTR [esi]
	add eax, edx
	add esi,ebx			; next col
Loop WordArr
	jmp EndOfProc
DwordArr:
	add eax,[esi]
	add esi,ebx			; next col
Loop DwordArr

EndOfProc:
;  Epilouge
	mov esp,ebp
	pop ebp
;----------------------
	ret 16
calc_row_sum ENDP

main	PROC


;array offset, row size, array type, row index.
	push offset tableB
	push RowsizeB
	push TYPE BYTE
	push 1				; row idx
	call calc_row_sum

	call WriteInt
	call Crlf

	push offset tableD
	push RowsizeD
	push TYPE DWORD
	push 2				; row idx
	call calc_row_sum

	call WriteInt
	call Crlf

	exit
main	ENDP


END		main
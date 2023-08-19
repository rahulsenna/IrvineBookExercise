INCLUDE	Irvine32.inc

.data
	op1 BYTE 34h,12h,98h,74h,06h,0A4h,0B2h,0A2h
	op2 BYTE 02h,45h,23h,00h,00h,87h,10h,80h
	sum BYTE 9 dup(0)
	some	word	11ffh
.code
main PROC
	mov al, 00001000b
	sub al, 00001010b

	mov	al, 255
	adc	al, 1
	adc	ah, 1
	adc bl,0

	mov esi,OFFSET op1 ; first operand
	mov edi,OFFSET op2 ; second operand
	mov ebx,OFFSET sum ; sum operand
	mov ecx,LENGTHOF op1 ; number of bytes
	call Extended_Add
	; Display the sum.
	mov esi,OFFSET sum
	mov ecx,LENGTHOF sum
	call Display_Sum
	call Crlf

	exit
main ENDP

;--------------------------------------------------------
Extended_Add PROC
;
; Calculates the sum of two extended integers stored
; as arrays of bytes.
; Receives: ESI and EDI point to the two integers,
; EBX points to a variable that will hold the sum,
; and ECX indicates the number of bytes to be added.
; Storage for the sum must be one byte longer than the
; input operands.
; Returns: nothing
;--------------------------------------------------------
	pushad
	clc ; clear the Carry flag
L1: 
	mov al,[esi] ; get the first integer
	adc al,[edi] ; add the second integer
	pushfd ; save the Carry flag
	mov [ebx],al ; store partial sum
	add esi,1 ; advance all three pointers
	add edi,1
	add ebx,1
	popfd ; restore the Carry flag
	loop L1 ; repeat the loop
	mov byte ptr [ebx],0 ; clear high byte of sum
	adc byte ptr [ebx],0 ; add any leftover carry
	popad
	ret
Extended_Add ENDP

Display_Sum PROC
	pushad
	; point to the last array element
	add esi,ecx
	sub esi,TYPE BYTE
	mov ebx,TYPE BYTE
	L1: mov al,[esi] ; get an array byte
	call WriteHexB ; display it
	sub esi,TYPE BYTE ; point to previous byte
	loop L1
	popad
	ret
Display_Sum ENDP

END main
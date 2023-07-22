;		Sum Array in 64bit

ExitProcess		PROTO

.DATA
	myArray		QWORD	1,2,3,4,5,6,7,8,9
	SumOfArray	QWORD	?

.CODE
main		PROC
	mov		rsi, OFFSET myArray
	mov		rcx, LENGTHOF myArray
	xor		rax,rax
L1:
	add		rax,[rsi]
	add		rsi,TYPE myArray
	loop	L1
	mov		SumOfArray,rax

; --- Partial register operand effects in Add/Sub 64bit reg

	;	16bit and 8bit operand AX/AL--------------------------
	mov		rax,0FFFFh				; RAX = 000000000000FFFF 
	mov		bx,1					
	add		ax,bx					; RAX = 0000000000000000

	mov		rax,0FFFFh				; RAX = 000000000000FFFF
	add		ax,1					; RAX = 0000000000000000

	;	32bit operand EAX--------------------------------------
	mov		rax,0FFFFFFFFh			; RAX = 00000000FFFFFFFF
	add		eax,1					; RAX = 0000000000000000

	mov		rax,0					; RAX = 0000000000000000
	sub		eax,1					; RAX = 00000000FFFFFFFF

	mov		rcx,0DFFFh
	mov		bx,3
	add		cx,bx

; --- Partial register operand effects in Add/Sub 64bit reg

; --- Partial register operand effects in MOV 64bit reg
;	mov constant 8/16/32bit upperbytes will clear to 0
;	mov 32bit memory operand upperbytes will clear to 0
;	mov 16/8bit memory operand won't affect upperbytes of 64bit operand

;		************  Summary  ********
;		Add/Sub with [AL/AH/AX/EAX]  won't affect higher bytes of [RAX]
;		MOV with [AL/AH/AX/EAX] will always clear higher bytes of [RAX] to 0 except
;		when done with memory operands(not constants) of 16/8bit to [AX/AL] 

	mov		rax,0ffffffffffffffffh
	mov		rax,0ffh


;	Exit Procedure
	mov		rcx,0
	call	ExitProcess
main		ENDP

END
INCLUDE Irvine32.inc

.DATA

;---------------------------------------------------------------
; 1.
	DECIMAL_OFFSET = 5
	decimal_one BYTE "100123456789765",0
	
;---------------------------------------------------------------
; 2.


	op1			QWORD  0000000000000055h
	op2			QWORD 0ffffffffffffffffh
	difference	QWORD 2 DUP(?)  ;; = 56h

;---------------------------------------------------------------
; 3.

	bcd1 		DWORD 08723654h ; 8,723,654 decimal
	bcd2 		DWORD 01234567h
	bcd3 		DWORD 09999999h

	ascii_buf	BYTE 9 DUP(0)

;---------------------------------------------------------------
; 4.
	key 		SBYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6
	msg1		BYTE "This is a test msg, it should be encrypted!!!",0

;---------------------------------------------------------------
; 5.
	N_PRIME		= 1000		
	prime		BYTE	1002 DUP(1)

;---------------------------------------------------------------
; 8.

	; align 4
	packed_1 	DWORD 21234536h									; 4 Byte Packed BCD
	packed_2 	DWORD 89517207h					
	; add = 110,751,743

	packed_3 	QWORD 2123453689517207h							; 8 Byte Packed BCD
	packed_4 	QWORD 8951720721234536h


	packed_5 	QWORD 2123453689517207h,8951720721234536h		; 16 Byte Packed BCD
	packed_6 	QWORD 8951720721234536h,2123453689517207h

	packed_sum 	BYTE 17 DUP(0)

.CODE
main PROC

;---------------------------------------------------------------
; 1. Display ASCII Decimal 

	mov		edx, OFFSET decimal_one
	mov		ecx, LENGTHOF decimal_one
	mov 	ebx, DECIMAL_OFFSET
	call	WriteScaled

;---------------------------------------------------------------
; 2. Extended Subtraction Procedure

	mov		esi,OFFSET op1					; first operand
	mov		edi,OFFSET op2					; second operand
	mov		ebx,OFFSET difference			; difference operand
	mov		ecx,SIZE op1 / TYPE DWORD		; number of bytes
	call	Extended_Sub
	
;---------------------------------------------------------------
; 3. Packed Decimal Conversion

	mov		edx, OFFSET ascii_buf
	
	mov		eax,bcd1
	call	PackedToAsc
	call	Crlf
	call	WriteString

	mov		eax,bcd2
	call	PackedToAsc
	call	Crlf
	call	WriteString

	mov		eax,bcd3
	call	PackedToAsc
	call	Crlf
	call	WriteString

;---------------------------------------------------------------
; 4. Encryption Using Rotate Operations

	mov		ebx,OFFSET key
	mov		edx,OFFSET msg1
	mov		ecx,SIZEOF msg1
	call	EncryptMsg
	call	EncryptMsg


;---------------------------------------------------------------
; 5. Prime Numbers
	
	mov		esi, OFFSET prime
	call	GeneratePrimeNumbers

;---------------------------------------------------------------
; 6. Greatest Common Divisor (GCD)

	mov     esi,6
	mov		edi,12
	call	GCD

;---------------------------------------------------------------
; 7. Bitwise Multiplication


	mov		eax, 564
	mov		ebx, 894
	
	mov		eax, 2
	mov		ebx, 7
	call	BitwiseMultiply2

;---------------------------------------------------------------
; 8. Add Packed Integers
	
	mov		edx,OFFSET packed_sum
	mov		ecx,SIZEOF packed_5
	mov		esi,OFFSET packed_5
	mov		edi,OFFSET packed_6

	call	AddPacked

	exit
main ENDP


;-----------------------------------------------------------------
WriteScaled PROC USES edx ecx ebx
;	Prints a decimal ASCII number with decimal point.
;	receives	EDX=Offset to num,ECX=Length of num, EBX=Offset to decimal point from right
;	returns		Nothing
;-----------------------------------------------------------------
	mov		esi,edx
	add		esi,ecx
	sub		esi,ebx
	mov		al, BYTE PTR [esi]
	mov		BYTE PTR [esi],0				; null terminating right where the decimal point is.
	call	WriteString

	mov		BYTE PTR [esi],al				; retrieving the character back
	
	mov		al,'.'
	call	WriteChar
	
	mov		edx,esi
	call	WriteString						; printing rest to the numbers(after decimal point)

	ret
WriteScaled ENDP


;--------------------------------------------------------
Extended_Sub PROC
;
; Calculates the difference of two extended integers stored
; as arrays of DWORDS.
; Receives: ESI and EDI point to the two integers,
; EBX points to a variable that will hold the difference,
; and ECX indicates the number of DWORDS to be added.
; Storage for the difference must be one byte longer than the
; input operands.
; Returns: nothing
;--------------------------------------------------------
	pushad
	clc ; clear the Carry flag

L1:
	mov		eax,[esi]						; get the first integer
	sbb		eax,[edi]						; subtract the second integer
	pushfd									; save carry flag
	mov		[ebx],al						; store partial difference
	add		esi, TYPE DWORD					; advance all three pointers
	add		edi, TYPE DWORD
	add		ebx, TYPE DWORD
	popfd									; restore carry flag
loop L1 									; repeat the loop
	mov		DWORD PTR [ebx],0 				; clear high byte of difference
	sbb		DWORD PTR [ebx],0 				; subtract any leftover carry
	popad
	ret
Extended_Sub ENDP


;----------------------------------------------------------------
PackedToAsc PROC USES edx
;
; procedure that converts a 4-byte packed decimal number
; to a string of ASCII decimal digits
; Receives: EAX = packed decimal number
; Returns: String of ASCII digits in buffer pointed by EDX
;------------------------------------------------------------------

	mov		ecx,8
L1:
	rol		eax,4						; move high 4 bits to low 4 bits
	mov		bl,al						; 
	and		bl,0fh						; mask out low 4 bits in 8bit register
	or		bl,30h						; convert packed BCD to ascii
	mov		BYTE PTR [edx],bl
	inc		edx

	loop	L1
	ret
PackedToAsc ENDP

;----------------------------------------------------------------
EncryptMsg	PROC USES ecx edx ebx esi
;
; Encrypts a string using rotate insturctions
; 
; Receives: EDX= Points to string, ECX= length of string, EBX= points to key
; Returns: Encrypted string buffer pointed by EDX
;----------------------------------------------------------------

	mov		esi,0
L1:
	push	ecx
	mov		cl,[ebx+esi]
	cmp		cl,0
	jg		ShiftRight
ShiftLeft:
	neg		cl
	rol		BYTE PTR[edx],cl
	jmp		Continue
ShiftRight:
	ror		BYTE PTR[edx],cl
	
Continue:
	inc		edx
	

	inc		esi
	cmp		esi,10
	jbe		EndLoop
	mov		esi,0
EndLoop: 
	pop		ecx
	loop	L1
	ret
EncryptMsg	ENDP


;----------------------------------------------------------------
GeneratePrimeNumbers	PROC USES eax ecx edx
;
; Generates prime numbers from 2 to 1000 using Sieve of Eratosthenes algorithm
; 
; Receives: ESI= Points to all prime array, N = 1000
; Returns: Nothing
;----------------------------------------------------------------

	mov		ecx,2
L1:	
	mov		eax,ecx
	mul		ecx							; multiply eax =ecx*eax = i*i
	cmp		eax,N_PRIME					; i*i < N
	ja		BeginPrint					; if not jump to printing part
L2:
	mov		BYTE PTR [esi+eax],0
	
	add		eax,ecx
	cmp		eax,N_PRIME
	jbe		L2
	
	inc		ecx
	jmp		L1

	
;----------------------------------------
;	Print Prime Numbers

BeginPrint:
	call	Crlf
	mov		eax,2
PrintLoop:
	test	BYTE PTR [esi+eax],1
	jz		Continue
	call	WriteDec
	call	Crlf
Continue:
	inc		eax
	cmp		eax,N_PRIME
	jbe		PrintLoop
	
	ret
GeneratePrimeNumbers	ENDP


;----------------------------------------------------------------
GCD	PROC USES esi edi edx
;
; Find Greatest common divisor
; 
; Receives: ESI=x int, EDI=y int
; Returns: EAX=gdc int
;----------------------------------------------------------------

    mov		eax,esi
	call	Abs
	mov		esi,eax

	mov		eax,edi
	call	Abs
	mov		edi,eax


L1:
	cmp		edi,0
	jle		EndLoop				; if y <= 0 ; exit

	mov		eax,esi
	xor		edx,edx				; clear edx
	div		edi					; x / y
	
	mov		esi,edi				; x = y
	mov		edi,edx				; y = remainder
	jmp		L1
EndLoop:	
	
	mov		eax,esi
	ret
GCD	ENDP

;----------------------------------------------------------------
Abs	PROC USES edx
;
; Find absolute value in the eax register
; 
; Receives: EAX=value
; Returns: EAX=abs value
;----------------------------------------------------------------

    mov     edx, eax        ; Copy the number to edx
    sar     edx, 31         ; Shift sign bit of edx to the rightmost bit

    xor     eax, edx        ; XOR the number with the sign extension
    sub     eax, edx        ; Subtract the sign extension
	ret

COMMENT !
	;----------------------------
	; Clang verison
	mov		eax, edi
	neg		eax
	cmovl	eax, edi		; mov if eax < edi
	;----------------------------
	; GCC version
	mov     eax, edi
	cdq						; edx = FFFFFFF or 0000000 based on eax's sign
	xor     eax, edx
	sub     eax, edx
!
Abs	ENDP

; My version (Naive)
;----------------------------------------------------------------
BitwiseMultiply	PROC USES ebx ecx esi edi
;
; Multiply EAX with EDX and store the result in EAX
; using bitwise multiply method
; 
; Receives: EAX=unsigned int, EBX=unsigned int
; Returns: EAX=result
;----------------------------------------------------------------
	mov edi,eax
	mov	eax,0
BegLoop:
	cmp	ebx,0
	jz	EndProc

	mov	cl,0
	mov edx,1
L1:
	shl	edx,1
	inc	cl
	cmp	edx,ebx
	jb	L1
;---------------------
	dec cl
	shr edx,1

	sub	ebx,edx
	
	mov	esi,edi
	shl	esi,cl

	add	eax,esi

	jmp	BegLoop

EndProc:
	ret
BitwiseMultiply	ENDP



; https://stackoverflow.com/questions/26305068/how-do-i-perform-bitwise-multiplication-division-in-masm-x86-assembly
; Multiply EBX by EAX
BitwiseMultiply2 PROC USES EBX ECX EDX
    mov edx, eax            ; EDX: multiplier (EBX: multiplicand)
    xor eax, eax            ; Result will be in EAX - clear it
    bsr ecx, edx            ; ECX = position of the most significant bit
    jz R1                   ; Return with EAX=0 if EDX == 0

    L1:
    shr edx, 1              ; Look at the rightmost bit of the multiplier
    jnc @F                  ; Skip addition if this bit == 0
    add eax, ebx            ; Add multiplikand to result
    @@:
    shl ebx, 1              ; Increase multipland for the next round
    sub ecx, 1              ; Decrease loop variable
    jnc L1                  ; Loop if ECX >= 0

    R1:
    ret                     ; Result in EAX
BitwiseMultiply2 ENDP

; Divide EAX by EBX
BitwiseDivide PROC USES ECX EDX ESI
    mov esi, eax            ; ESI: dividend (EBX: divisor)
    xor eax, eax            ; Result (quotient) = 0
    xor edx, edx            ; EDX = 0 (start value)
    mov cl, 32              ; 32 loops

    L1:
    shl esi, 1              ; Bit 31 from EAX ...
    rcl edx, 1              ;     ... to Bit 1 of EDX
    cmp ebx, edx            ; Carry, if EDX > Divisor
    ja @F                   ; Skip subtraction if carry==0 and zero==0 (result not zero)
    sub edx, ebx            ; Subtract ...
    stc                     ;     ... and set carry
    @@:
    rcl eax, 1              ; Append carry (0 or 1) to quotient.
    sub cl, 1
    jnz L1                  ; loop while CL > 0

    ret                     ; Result in EAX
BitwiseDivide ENDP


;----------------------------------------------------------------
AddPacked	PROC
;
; Add two packed decimal interger of arbitrary size
; 
; Receives: ESI - pointer to the first number, EDI - pointer to the second number 
; 			EDX - pointer to the sum, ECX - number of bytes to add
; Returns: Nothing
;----------------------------------------------------------------

	
	clc						; clear carry
	xor ebx,ebx
L1:
	mov al,BYTE PTR [esi+ebx]
	adc	al,BYTE PTR [edi+ebx]
	daa
	mov	BYTE PTR [edx+ebx],al
	inc ebx
	loop L1

	adc BYTE PTR [edx+ebx],0
	daa

	;----------------------------------------
	;	Print 17 byte result

	xor eax,eax
	mov	al, BYTE PTR [edx+16]
	call WriteHex

	mov	eax, DWORD PTR [edx+12]
	call WriteHex

	mov	eax, DWORD PTR [edx+8]
	call WriteHex

	mov	eax, DWORD PTR [edx+4]
	call WriteHex

	mov	eax, DWORD PTR [edx]
	call WriteHex
	ret
AddPacked	ENDP

END main

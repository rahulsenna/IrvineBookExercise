;           6.11 Programming Exercises

INCLUDE Irvine32.inc

.DATA
 
;-------------------------------------------------
;  1.
	rand_arr				SDWORD			5 DUP(?)
;-------------------------------------------------
;  4.
	prompt_credits		BYTE			"Enter amount of Credits (1:30): ",0
	prompt_grade_avg	BYTE			"Enter your grade average: ",0
	error_msg			BYTE			"Invalid number of credits!!!: ",0Dh,0Ah,0
	success_msg			BYTE			"The student can register",0Dh,0Ah,0
	fail_msg			BYTE			"The student cannot register",0Dh,0Ah,0
	credits 			DWORD			?
	grade_avg 			DWORD			?

;-------------------------------------------------
;  5.
	CaseTable			BYTE			'1'
						DWORD			AND_OP
	CaseSize			=				($-CaseTable)
						BYTE			'2'
						DWORD			OR_OP
						BYTE			'3'
						DWORD			NOT_OP
						BYTE			'4'
						DWORD			XOR_OP
						BYTE			'5'
						DWORD			EXIT_OP



	TotalCases			=				($-CaseTable)/CaseSize

	prompt_calc			BYTE			"1. x AND y",0Dh,0Ah
						BYTE			"2. x OR y",0Dh,0Ah
						BYTE			"3. NOT x",0Dh,0Ah
						BYTE			"4. x XOR y",0Dh,0Ah
						BYTE			"5. Exit program",0Dh,0Ah
						BYTE			"Please select a calulator operation (1:5): ",0
	
	calc_error_msg		BYTE			"Error! invalid selection!!!",0Dh,0Ah,0
	exit_msg			BYTE			"Good bye.",0Dh,0Ah,0

	and_msg				BYTE			"Performing AND Operation",0Dh,0Ah,0
	or_msg				BYTE			"Performing OR Operation",0Dh,0Ah,0
	not_msg				BYTE			"Performing NOT Operation",0Dh,0Ah,0
	xor_msg				BYTE			"Performing XOR Operation",0Dh,0Ah,0
	hex_msg				BYTE			"Enter a value (Hexadecimal): ",0

	x_value				DWORD			?

;-------------------------------------------------
;  7.
	sample_text			BYTE			"This is a sample text.",0Dh,0Ah,0
	
;-------------------------------------------------
;  8.
	encrypttion_prompt	BYTE			"Please enter text to be encrypted : ",0
	encrypted_msg		BYTE			"Encrypted Text: ",0
	decrypted_msg		BYTE			"Decrypted Text: ",0


	encryption_key		BYTE			"ABXmv#7"
	encryption_key_len	=				($-encryption_key)
	input_string_buf	BYTE			256 DUP(?)
	input_string_len	DWORD			?	
;-------------------------------------------------
;	9.
	min_pin_range			BYTE			5,2,4,1,3
	max_pin_range			BYTE			9,5,8,4,6

	my_pin1					BYTE			5,2,4,1,3	;
	my_pin2					BYTE			7,4,6,3,5	; 
	my_pin3					BYTE			6,4,5,3,7	;
	my_pin4					BYTE			4,3,5,3,4	; 
	pin_error_msg			BYTE			"Wrong PIN!!!",0Dh,0Ah,0

;-------------------------------------------------
;	10.
	parity_arr				BYTE			5,2,4,1,3,7,4,6,3,5

.CODE
main		PROC
;-------------------------------------------------
;  1. Filling an Array
	mov		ecx,LENGTHOF rand_arr		; N
	mov		ebx,10						; j
	mov		edx,15						; k
	mov		esi,OFFSET rand_arr			; randArr PTR
	call	FillArray
	call	FillArray

	mov		ebx,-100					; j
	mov		edx,100						; k
	mov		esi,OFFSET rand_arr			; randArr PTR
	call	FillArray
    
;-------------------------------------------------
;  2. Summing Array Elements in a Range
	mov		ecx,LENGTHOF rand_arr		; N
	mov		ebx,-50						; j min range
	mov		edx,50						; k	max range
	mov		esi,OFFSET rand_arr			; randArr PTR
	call	SumArray
;-------------------------------------------------
;  3. Test Score Evaluation
	mov		ecx,10
ScoreLoop:
	mov		eax,51
	call	RandomRange
	add		eax,50
	call	WriteDec
	call	CalcGrade
	call	WriteChar
	call	Crlf
	loop	ScoreLoop

;-------------------------------------------------
;	4. College Registration
;	call 	CollegeReg

;-------------------------------------------------
;	5.,6. Boolean Calculator 
	; call 	BoolCalculator
	
;-------------------------------------------------
;	7. Probabilities and Colors
	; call	ProbableColors

;-------------------------------------------------
;	8. Message Encryption
	; call	MessageEncryption
;-------------------------------------------------
;	9. Validating a PIN
	; mov		esi,OFFSET my_pin1
	; call	Validate_PIN

	; mov		esi,OFFSET my_pin2
	; call	Validate_PIN

	; mov		esi,OFFSET my_pin3
	; call	Validate_PIN

	; mov		esi,OFFSET my_pin4
	; call	Validate_PIN

;-------------------------------------------------
;	10. Parity Checking
	mov		esi,OFFSET parity_arr
	mov		ecx,LENGTHOF parity_arr
	call	CheckParity

	
EndProc:
	
	exit


main		ENDP

;-------------------------------------------
CheckParity			PROC USES esi ecx
;
; Checks parity of an array
; Receives: ecx:N=LengthOf the array,  esi: ArrayPointer
; Returns: eax: 0|1
;-------------------------------------------	


	dec		ecx
ParityLoop:
	mov		al,[esi + ecx]
	xor		[esi + ecx-1],al
	loop	ParityLoop
	
	mov		eax,1
	jp		EndProc
	mov		eax,0
EndProc:
	ret



CheckParity			ENDP

;-------------------------------------------
Validate_PIN		PROC USES esi ecx edx
;
; Validates Bank PIN
; Receives:  esi: Pointer to Pin arr
; Returns: eax: 0 or Position of invalid digit 
;-------------------------------------------	


	mov		ecx,5
ValidateLoop:
	mov		al,[esi + ecx -1]
	cmp		al,min_pin_range[ecx-1]
	jb		ErrorLabel
	cmp		al,max_pin_range[ecx-1]
	ja		ErrorLabel
	
	loop	ValidateLoop

	xor		eax,eax
	ret
ErrorLabel:
	mov		edx,OFFSET pin_error_msg
	call	WriteString
	mov		eax,ecx
	ret
Validate_PIN		ENDP

MessageEncryption	PROC USES edx ecx 
	mov		edx,OFFSET encrypttion_prompt
	call	WriteString

	mov		edx,OFFSET input_string_buf
	mov		ecx,SIZEOF input_string_buf
	call	ReadString
	mov		input_string_len,eax
	mov		input_string_buf[eax],0

	mov		ecx,eax
	call	EncryptDecrypt

	mov		edx,OFFSET encrypted_msg
	call	WriteString

	mov		edx,OFFSET input_string_buf
	call	WriteString
	
	call	Crlf

	mov		ecx,input_string_len
	call	EncryptDecrypt

	mov		edx,OFFSET decrypted_msg
	call	WriteString

	mov		edx,OFFSET input_string_buf
	call	WriteString
	ret
MessageEncryption	ENDP

EncryptDecrypt		PROC USES esi edi

	mov		esi,0
	mov		edi,0
EncryptionLoop:
	mov		al,encryption_key[edi]
	xor		input_string_buf[esi],al
	inc		esi
	inc		edi
	cmp		edi,encryption_key_len
	jb		EndLoop
	mov		edi,0
EndLoop:
	loop	EncryptionLoop

	ret
EncryptDecrypt		ENDP



ProbableColors		PROC
call 	Clrscr
	mov		ecx,20
	mov		edx,OFFSET sample_text
ProbColorLoop:
	mov		eax,10
	call	RandomRange
	
	cmp		eax,2
	jbe		WhiteText
	cmp		eax,3
	je		BlueText
GreenText:
	mov		eax,green + (black *16)
	jmp		EndLoop
BlueText:
	mov		eax,blue + (black *16)
	jmp		EndLoop
WhiteText:
	mov		eax,white + (black *16)
	
EndLoop:
	call	SetTextColor
	call	WriteString	
	loop	ProbColorLoop

	ret
ProbableColors		ENDP

BoolCalculator		PROC
	call	Clrscr
	mov 	edx, OFFSET prompt_calc
	call 	WriteString
	call	ReadChar

	mov		ecx,TotalCases
	mov		esi,OFFSET CaseTable
	call	Clrscr
TableLoop:
	cmp		al, [esi]
	jne		EndTableLoop
	call	NEAR PTR [esi+1]

	call	Crlf
	jmp		EndProc
EndTableLoop:
	add		esi,CaseSize
	loop	TableLoop
Error_Label:
	mov 	edx, OFFSET calc_error_msg
	call 	WriteString
EndProc:
	ret
BoolCalculator		ENDP


AND_OP		PROC
	mov		edx,OFFSET and_msg
	call	WriteString
	mov		edx,OFFSET hex_msg
	call	WriteString
	call	ReadHex
	mov		x_value,eax
	
	call	WriteString
	call	ReadHex

	and		eax,x_value
	
	call	WriteHex
	ret
AND_OP		ENDP
OR_OP		PROC
	mov		edx,OFFSET or_msg
	call	WriteString
	mov		edx,OFFSET hex_msg
	call	WriteString
	call	ReadHex
	mov		x_value,eax
	
	call	WriteString
	call	ReadHex

	or		eax,x_value
	
	call	WriteHex
	ret
OR_OP		ENDP
NOT_OP		PROC
	mov		edx,OFFSET not_msg
	call	WriteString
	
	mov		edx,OFFSET hex_msg
	call	WriteString
	call	ReadHex

	not		eax
	
	call	WriteHex
	ret
NOT_OP		ENDP
XOR_OP		PROC
	mov		edx,OFFSET xor_msg
	call	WriteString

	mov		edx,OFFSET hex_msg
	call	WriteString
	call	ReadHex
	mov		x_value,eax
	
	call	WriteString
	call	ReadHex

	xor		eax,x_value
	
	call	WriteHex
	ret
XOR_OP		ENDP
EXIT_OP		PROC
	mov		edx,OFFSET exit_msg
	call	WriteString
	ret
EXIT_OP		ENDP



CollegeReg		PROC
	call 	Clrscr

	mov		edx,OFFSET prompt_credits
	call	WriteString
	call	ReadDec
	cmp		eax,1
	jb		Error_Label
	cmp		eax,30
	ja		Error_Label
	mov 	credits, eax

	mov		edx,OFFSET prompt_grade_avg
	call	WriteString
	call	ReadDec
	mov 	grade_avg, eax

	cmp		grade_avg,350
	jae		Success_Label

	cmp		credits,12
	jbe		Success_Label
	
	cmp		grade_avg,250
	jbe		Fail_Label
	cmp		credits,16
	jbe		Success_Label
Fail_Label:
	mov 	edx,OFFSET fail_msg
	call 	WriteString
	ret
Success_Label:
	mov 	edx,OFFSET success_msg
	call 	WriteString
	ret
Error_Label:
	mov		edx,OFFSET error_msg
	call	WriteString
	
	ret
CollegeReg		ENDP


;-------------------------------------------------
CalcGrade		PROC
; Calculates grade of a student based on mark
; Receives: al: marks
; Returns:  al: char Grade
;-------------------------------------------------
	cmp		al,90
	jae		GradeA

	cmp		al,80
	jae		GradeB
	
	cmp		al,70
	jae		GradeC
	
	cmp		al,60
	jae		GradeD
	
	jmp		GradeF

GradeA:
	mov		al,'A'
	ret
GradeB:
	mov		al,'B'
	ret
GradeC:
	mov		al,'C'
	ret
GradeD:
	mov		al,'D'
	ret
GradeF:
	mov		al,'F'
	ret

	ret
CalcGrade		ENDP


;-------------------------------------------
FillArray		PROC USES  ecx ebx edx esi
;
; Fills an array with random numbers
; Receives: ecx:N=LengthOf the array, ebx:j=RandomMin, edx:k=RandomMax, esi: ArrayPointer
; Returns: Nothing
;-------------------------------------------	
	call	Randomize
	inc		edx 
RandLoop:
	mov		eax,edx						; j
	sub		eax,ebx						; k-j
	call	RandomRange
	add		eax,ebx						; rand_num+j
	mov		DWORD PTR [esi],eax
	add		esi,4
	loop	RandLoop
	ret
FillArray		ENDP

;-------------------------------------------
SumArray		PROC USES  ecx ebx edx esi
;
; Sums numbers in an array that fall inside min and max range
; Receives: ecx:N=LengthOf the array, ebx:j=MinRange, edx:k=MaxRange, esi: ArrayPointer
; Returns: eax: Sum
;-------------------------------------------	
	mov		eax,0
BegLoop:
	cmp		DWORD PTR [esi],ebx
	jl		EndLoop
	cmp		DWORD PTR [esi],edx
	jg		EndLoop

	add		eax,DWORD PTR [esi]
EndLoop:
	;add		esi,4
	loop	BegLoop

	ret
SumArray		ENDP

END main
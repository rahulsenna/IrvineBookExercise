;		4.10		Programming Exercises

.386
.model		flat,stdcall
.stack		4096

ExitProcess		PROTO,dwExitCode:DWORD

.DATA
	bigEndian		BYTE		12h,34h,56h,78h
	littleEndian	DWORD		?

.CODE
main		PROC

;  * 1. Converting from Big Endian to Little Endian ------------------------------------

	mov		eax, DWORD PTR	bigEndian		; still big endian
	mov		ecx, LENGTHOF bigEndian
	mov		esi, OFFSET bigEndian
L1:
	mov		al, [esi]
	inc		esi
	mov		byte ptr [littleEndian+ecx-1], al
	loop	L1


;	* 2. Exchanging Pairs of Array Values -----------------------------------------------

.DATA 
	myArray		DWORD		2,1,4,3,6,5,8,7,9
.CODE

	mov 	esi, OFFSET myArray
	mov 	ecx, LENGTHOF myArray / 2
	mov 	eax, 0
ExchangeArrLoop:
	mov		ebx,[esi]					; even element to ebx
	mov		edx,[esi+TYPE myArray]  ; odd element to edx
	
	mov 	[esi], edx                  ; put  odd edx , into even loccation
	mov 	[esi+ TYPE myArray], ebx ; put even ebx , into  odd location
	add		esi, 2 * TYPE myArray 		; inc pointer by 2

 
	loop	ExchangeArrLoop


;   * 3. Summing the Gaps between Array Values -------------------------------------------

.DATA
	arrayWithGaps		BYTE 		0, 2, 5, 9, 10
	totalGap			DWORD		?

.CODE
	mov		ecx, LENGTHOF arrayWithGaps - 1
	xor		eax,eax
	xor     ebx,ebx
CountGapsLoop:
	mov		bl, arrayWithGaps[ecx]
	sub		bl, arrayWithGaps[ecx-TYPE arrayWithGaps]
	add		al,  bl
	loop	CountGapsLoop
	
	mov		totalGap, eax



;   * 4. Copying a Word Array to a DoubleWord array --------------------------------------
.DATA
	myWordArray		WORD		0FFF1h,0FFF2h,0FFF3h,0FFF4h
	myDoubleWordArr	DWORD		LENGTHOF myWordArray  DUP (0)
.CODE

	mov		esi,OFFSET myWordArray
	mov		edi,OFFSET myDoubleWordArr

	mov		ecx, LENGTHOF myWordArray
CopyArrayLoop:
	movzx	eax, WORD PTR [esi]
	mov		[edi], eax
	add		esi, TYPE myWordArray
	add		edi, TYPE myDoubleWordArr

	loop	CopyArrayLoop 


;	* 5. Fibonacci Number-----------------------------------------------------------------
	
.DATA
	fibTotal		DWORD		0
.CODE
	mov		ebx,0		; first number 0 in fib series
	mov		edx,1		; second number 1 in fib series
	mov		ecx,5		; 7 numbers 5 + 2 defaults 
	mov		edi,1		; edi accumulator starts with 1, counting defaults 0,1
FibLoop:
	; get the next number in fib series
	mov		eax,ebx		
	add		eax,edx	
	
	; add next number to the accumulator
	add		edi,eax

	; current_num = next_num
	mov		ebx,edx
	mov		edx,eax
	loop	FibLoop

	mov		fibTotal,edi



;	* 6. Reverse an Array ----------------------------------------------------------------
.DATA
	backwardNumbers		WORD		11,10,9,8,7,6,5,4,3,2,1
.CODE
	mov		ecx, LENGTHOF backwardNumbers / 2
	mov		esi, OFFSET backwardNumbers
	mov		edi, OFFSET backwardNumbers + SIZEOF backwardNumbers - TYPE backwardNumbers
	
	; branch for variable TYPE of array
	mov		eax,TYPE backwardNumbers
	cmp		eax,4						; if arr type DWORD
	je		ReverseArrDWORD_Loop
	cmp		eax,2						; if arr type WORD
	je		ReverseArrWORD_Loop

ReverseArrDWORD_Loop:
	mov		eax, [esi]
	mov		ebx, [edi]
	mov		[esi],ebx
	mov		[edi],eax
	add		esi, TYPE backwardNumbers
	sub		edi, TYPE backwardNumbers

	loop	ReverseArrDWORD_Loop
	jmp		endfunc

ReverseArrWORD_Loop:
	mov		ax, [esi]
	mov		bx, [edi]
	mov		[esi],bx
	mov		[edi],ax
	add		esi, TYPE backwardNumbers
	sub		edi, TYPE backwardNumbers

	loop	ReverseArrWORD_Loop

endfunc:


;	* 7. Copy a String in Reverse Order---------------------------------------------------

.DATA
	source BYTE "This is the source string",0
	target BYTE SIZEOF source DUP(0)

.CODE
	mov		ecx, LENGTHOF source -1
	xor		edi,edi
CopyReverseStringLoop:
	mov		al,source[ecx-1]
	mov		target[edi],al
	inc		edi
	loop	CopyReverseStringLoop



;	* 8. Shifting the Elements in an Array------------------------------------------------

.DATA
	array		DWORD		10,20,30,40,50,60
	arraySize	EQU			LENGTHOF array
.CODE
;------Method 1: using xchg and manually swapping last with first--------------
	mov		ecx, arraySize
	mov		esi,0			
	mov		ebx,[array+SIZEOF array - TYPE array]
ShiftArrLoop:
	xchg	[array+esi*TYPE array],ebx
	inc		esi
	loop	ShiftArrLoop

COMMENT !	
;------Method 2: using mod to swap last and first-------------
	mov		ecx, arraySize
	mov		edi, ecx			; for mod
	mov		esi,1			
	mov		ebx,[array]
ShiftArrLoop:
;---Get next element[address] in array using mod-----
	xor		edx,edx				; clear edx so remainder can be stored in it
	mov		eax,esi				; mov current pos(esi) to eax for division
	div		edi					; remainder in edx
	shl		edx,2				; edx * 4 (DWORD)
;----------------------------------------------------
	mov		eax,[array + edx]
	mov		[array + edx],ebx
	mov		ebx,eax
	inc		esi
	
	loop	ShiftArrLoop
!
;	* 8. Shifting the Elements in an Array--------------END-------------------------------
	
	INVOKE	ExitProcess,0
main		ENDP

END		main
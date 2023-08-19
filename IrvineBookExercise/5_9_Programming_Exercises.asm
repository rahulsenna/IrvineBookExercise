; 			5.9 Programming Exercises

INCLUDE	Irvine32.inc

COUNT	=	4

blueOnWhite		=	blue + (white*16)
greenOnRed		=	green + (red SHL 4)
yellowOnBrown	=	yellow + (brown*16)
redOnWhite		=	red + (white SHL 4)
DefaultColor = lightGray + (black * 16)

.DATA
	;-----------------------------------------------------------------------
	;	* 1
	testString		BYTE	"This is a test string",0Dh,0Ah,0
	textColors		DWORD	blueOnWhite, greenOnRed, yellowOnBrown, redOnWhite
	;-----------------------------------------------------------------------
	;	* 2
	start	=	0
	chars		BYTE	"HACEBDFG"
	char_size	=		($-chars)
	links		DWORD	1,4,2,5,3,6,7,0
	outChars	BYTE	char_size+1 DUP(?)
	;-----------------------------------------------------------------------
	;	* 3

	first_digit			SDWORD		?
	second_digit		SDWORD		?
	sum					SDWORD		?

	row					BYTE		?
	col					BYTE		?


	calc_title			BYTE	"Simple Calculator",0 
	prompt				BYTE	"Please Enter 2 numbers",0

	CenteredTextMacro	MACRO
	call	StrLength
	push	edx
	shr		al,1
	mov		dh,row
	mov		dl,col
	sub		dl,al
	call	Gotoxy
	inc		row
	pop		edx
ENDM

	;-----------------------------------------------------------------------
	;	* 6

	randomStringArr		BYTE	50	DUP(?)
	;-----------------------------------------------------------------------
	;	* 10

	fibArr				DWORD	50  DUP(?)
	
	;-----------------------------------------------------------------------
	;	* 11

	kArr				BYTE	50  DUP(0)


.CODE

main	PROC
	call	DrawTextColor				; * 1st Problem
	call	LinkingArrayItems			; * 2nd Problem
	;call	SimpleAddition				; * 3rd Problem
	;call	SimpleAdditionLoop			; * 4th Problem
	;call	Problem5					; * 5th Problem
	;call	Problem6					; * 6th Problem
	;call	Problem7					; * 7th Problem
	call	ColorMatrix					; * 8th Problem
	call	Problem9					; * 9th Problem
	
	mov		ecx,47
	mov		esi,OFFSET fibArr
	call	FibGen						; * 10th Problem

	; * 11th Problem:   Finding Multiples of K
	mov		ebx,2						; K = 2
	mov		ecx,50						; 50 elements
	mov		esi, OFFSET kArr			
	call	MultiplesOfK				; * 11th Problem
	mov		ebx,3						; K = 3
	call	MultiplesOfK				; * 11th Problem




	exit
main	ENDP
	
MultiplesOfK	PROC USES eax ebx ecx edi esi
L1:
	xor		edx,edx
	mov		eax,ecx
	div		ebx
	cmp		edx,0
	jne		Conitnue
	mov		BYTE PTR [esi+ecx-1],1
Conitnue:
	loop	L1

	ret
MultiplesOfK	ENDP


FibGen	PROC
	dec		ecx				; starting with 1 not 0 thus decrementing loops
	mov		ebx,0
	mov		edx,1
	xor		eax,eax
L1:
	add		eax,edx

	mov		ebx,edx
	mov		edx,eax

	mov		[esi],eax
	add		esi, 4			; to next Doubleword
	mov		eax,ebx
	loop	L1
	
	ret
FibGen	ENDP



Problem9	PROC
	;	recursive proc using loop
	mov		ecx,4
	mov		eax,0						; counter
	call	RecursiveProc				; * 9th Problem
	ret
Problem9	ENDP

RecursiveProc	PROC
	add		eax,1
	loop	RecursiveProc
	ret
RecursiveProc	ENDP

ColorMatrix		PROC
	call	Crlf
	mov		ecx,255
ColorMatrixLoop:
	mov		eax,ecx
	call	SetTextColor
	mov		al,"A"
	call	WriteChar
	loop	ColorMatrixLoop
	ret
ColorMatrix		ENDP



Problem7	PROC
	call	Clrscr
	mov		ecx,100
RandomScreenLoop:
	mov		eax,100
	call	Delay
	call	RandomScreenLocation		; * 7th Problem
	loop	RandomScreenLoop

	ret
Problem7	ENDP


Problem6	PROC
	mov		ecx,20
StringLoop:
	mov		eax,30						; string len
	mov		esi, OFFSET randomStringArr	; pointer to string loc
	call	RandomString				; * 6th Problem
	mov		edx, OFFSET randomStringArr
	call	Crlf
	call	WriteString
	loop	StringLoop
	ret
Problem6	ENDP


Problem5	PROC
	call	Randomize
	mov		ecx,50
RandLoop:
	mov		eax,100
	mov		ebx,-300
	call	BetterRandomRange			; * 5th Problem
	
	call	Crlf
	call	WriteInt
	
	loop	RandLoop
	
	ret
Problem5	ENDP


DrawTextColor	PROC
	mov		ecx, LENGTHOF textColors
	mov		esi, OFFSET	textColors
L1:
	mov		eax, textColors[ecx * TYPE textColors - TYPE textColors]
	call	SetTextColor
	mov		edx, OFFSET	testString
	call	WriteString
	loop	L1

	mov		eax, DefaultColor
	call	SetTextColor
	
	ret
DrawTextColor	ENDP

LinkingArrayItems	PROC
	mov		ecx,LENGTHOF links - start
	mov		edx,start
	mov		edi,OFFSET outChars
L1:
	mov		esi,links[edx * TYPE links]
	mov		al, chars[esi]
	mov		[edi],al
	inc		edi
	inc		edx
	loop	L1

	mov		outChars[char_size],0
	mov		edx,OFFSET outChars
	call	WriteString
	
	ret
LinkingArrayItems	ENDP


SimpleAddition	PROC
	call	Clrscr

	call	GetMaxXY
	shr		ax,1
	shr		dx,1
	mov		row,al
	mov		col,dl


	mov		edx,OFFSET calc_title
	CenteredTextMacro
	call	WriteString
	
	mov		edx,OFFSET prompt
	CenteredTextMacro
	call	WriteString
	
	mov		dh,row
	mov		dl,col
	inc		dh
	call	Gotoxy

	call	ReadInt
	mov		first_digit, eax

	inc		dh
	call	Gotoxy

	call	ReadInt
	mov		second_digit,eax
	add		eax,first_digit

	inc		dh
	call	Gotoxy


	call	WriteInt					;	Writes eax's value 
	
	inc		dh
	call	Gotoxy
	
	ret
SimpleAddition	ENDP

SimpleAdditionLoop	PROC
	mov		ecx,3
L1:
	call	WaitMsg
	call	SimpleAddition
	loop	L1
	ret
SimpleAdditionLoop	ENDP

BetterRandomRange	PROC
	sub		eax,ebx
	call	RandomRange
	add		eax,ebx
	ret
BetterRandomRange	ENDP

RandomString	PROC USES ecx
	mov		ecx,eax
L1:
	mov		eax,91
	mov		ebx,65
	call	BetterRandomRange
	mov		[esi],al
	inc		esi
	loop	L1
	mov		BYTE PTR [esi], 0				; null terminate
	ret
RandomString	ENDP



RandomScreenLocation	PROC

	call	GetMaxXY

	call	RandomRange				; rand row
	mov		row,al

	mov		al,dl
	call	RandomRange				; rand col
	mov		col,al

	mov		dh,row
	mov		dl,col
	call	Gotoxy

	mov		al,'X'
	call	WriteChar
	
	ret
RandomScreenLocation	ENDP


END		main

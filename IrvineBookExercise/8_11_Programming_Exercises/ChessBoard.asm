INCLUDE	Irvine32.inc

.DATA

	SqChar		BYTE	219
	square_cnt	=	8
	SqSize		=	3	; easily change board size with this variable
.CODE

DrawChessBoard	PROTO,
	SquareChar: DWORD,	;	square character
	NumSquare: DWORD,	;	Num of squres per row
	SizeOfSquare:DWORD	;	Size of a square in the board
	
main	PROC

	movzx	eax,SqChar
	INVOKE DrawChessBoard, eax , square_cnt, SqSize*2		;; SqSize*2 ; use an even number for a perfect square
	
	exit
main	ENDP

;-----------------------------------------------------
CalcLineSpace	PROC,
	SizeOfSquare:DWORD	;	Square Height
;
; Calculates amount stack space to reserve and Length of Square String.
; Returns: EAX = Stack space to reserver, ECX = Num of char per line [ColScale]
;-----------------------------------------------------
	;----------------------------
	;	calculating char space needed for a square in a line
	shr		SizeOfSquare,1
	mov		eax,5			; magic num 5 and `shr 1` so Squares look good
	mul		SizeOfSquare	; EAX = Num of char per line ; ColScale
	mov		ecx,eax			
	;----------------------------
	;	Calculation for doubleword alignment
	mov		ebx,4
	xor		edx,edx
	div		ebx
	mov		eax,ecx
	sub		eax,edx		; DWORD aligning
	add		eax,4		; DWORD alinging
	;----------------------------
	ret
CalcLineSpace	ENDP

;-----------------------------------------------------
DrawSquare	PROC,
	ASCII_Square:DWORD,		; String of square chars
	SizeOfSquare:DWORD,		; Height of the square
	Color:DWORD,			; Color of the square
	Col:DWORD,				; X
	Row:DWORD				; Y
;
; Draws a square in X,Y locaton.
; Returns: nothing
;-----------------------------------------------------

	pushad						;save registers
	mov		eax,Color
	call	SetTextColor
	mov		ecx,SizeOfSquare
l1:
	mov		dh,BYTE PTR [Row]
	mov		dl,BYTE PTR [Col]
	inc		Row
	call	Gotoxy

	mov		edx, ASCII_Square
	call	WriteString
	loop	l1	
	
	popad						;save registers
	ret
DrawSquare	ENDP



;-----------------------------------------------------
MakeCharLine	PROC,
	SquareStringPTR:DWORD,	; memory ptr for square char
	ColScale:DWORD,			; Length of chars
	SquareChar: DWORD		; char
;
; Fills memory with square characters.
; Returns: nothing
;-----------------------------------------------------

	pushad						;save registers
	;-----------------------------------
	;		Filling Char
	mov		esi,[SquareStringPTR]
	mov		eax,SquareChar
FillChar:
	mov		byte ptr [esi],al
	inc		esi
	loop	FillChar
	mov		byte ptr [esi],0
	;-----------------------------------
	popad						;save registers
	ret
MakeCharLine	ENDP



;-----------------------------------------------------
DrawChessBoard	PROC,
	SquareChar: DWORD,	;	square character
	NumSquare: DWORD,	;	Num of squres per row
	SizeOfSquare:DWORD	;	Size of a square in the board
	LOCAL	SquareStringPTR:DWORD, ColScale:DWORD
;
; Draws a chessboard on the console.
; Returns: nothing
;-----------------------------------------------------
	INVOKE	CalcLineSpace, SizeOfSquare
	sub		esp, eax
	mov		SquareStringPTR,esp
	mov		ColScale,ecx

	INVOKE	MakeCharLine, SquareStringPTR, ColScale, SquareChar

	;------------------------------------------------
	;		Draw the board
	mov		ecx,NumSquare
	mov		EBX,0					; Row
	mov		edx,gray
DrawOuterLoop:
	push	ecx
	mov		ecx,NumSquare
	mov		eax,0					; Col
	;------------------------
	;	InnerLoop
DrawInnerLoop:
	add		eax,ColScale			; Next Col
	xor		edx,white
	INVOKE	DrawSquare, SquareStringPTR, SizeOfSquare, edx, EAX, EBX
	loop	DrawInnerLoop
	;------------------------
	
	pop		ecx
	xor		edx,white
	add		EBX,SizeOfSquare		; Next Row
	loop	DrawOuterLoop
	;-------------------------------------------------
	ret
DrawChessBoard	ENDP




END	main
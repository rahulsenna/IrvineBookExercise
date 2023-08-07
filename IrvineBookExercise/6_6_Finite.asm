; Finite State Machine (Finite.asm)
; Validate signed numbers

INCLUDE Irvine32.inc
ENTER_KEY = 13

.DATA
InvalidInputMsg BYTE "Invalid input",13,10,0

.CODE
main	PROC

StateA:
	call	Clrscr
	call	Getnext
	cmp		al,'+'
	je		StateB
	cmp		al,'-'
	je		StateB

	call	IsDigit
	jz		StateC

	call	DisplayErrorMsg
	jmp		Quit

StateB:
	call	Getnext
	call	IsDigit
	jz		StateC
	call	DisplayErrorMsg
	jmp		Quit

StateC:
	call	Getnext
	call	IsDigit
	jz		StateC
	cmp		al,ENTER_KEY
	je		Quit
	call	DisplayErrorMsg
Quit:
	call Crlf
	exit
main	ENDP


;-----------------------------------------------
Getnext PROC
;
; Reads a character from standard input.
; Receives: nothing
; Returns: AL contains the character
;-----------------------------------------------
	call ReadChar		; input from keyboard
	call WriteChar		; echo on screen
	ret
Getnext ENDP

;-----------------------------------------------
DisplayErrorMsg PROC
;
; Displays an error message indicating that
; the input stream contains illegal input.
; Receives: nothing. 
; Returns: nothing
;-----------------------------------------------
	call Crlf
	push edx
	mov edx,OFFSET InvalidInputMsg
	call WriteString
	pop edx
	ret
DisplayErrorMsg ENDP

COMMENT !
;-----------------------------------------------
IsDigit	PROC
;
; Cheks if character in AL register is a valid digit.
; Receives: AL: char
; Returns:	ZF: Bool
;----------------------------------------------
	cmp		al,'0'
	jb		EndLabel
	cmp		al,'9'
	ja		EndLabel
	test	al,0			; Sets ZF=1
EndLabel:
	ret
IsDigit	ENDP
!


END		main
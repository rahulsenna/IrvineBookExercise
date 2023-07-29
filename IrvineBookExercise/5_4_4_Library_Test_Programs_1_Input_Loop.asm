; Library Test #1: Integer I/O (InputLoop.asm)
; Tests the Clrscr, Crlf, DumpMem, ReadInt, SetTextColor, 
; WaitMsg, WriteBin, WriteHex, and WriteString procedures.

INCLUDE Irvine32.inc

.DATA
	COUNT = 4
	BlueTextOnGray = blue + (lightGray * 16)
	DefaultColor = lightGray + (black * 16)

	arrayD SDWORD 12345678h,1A4B2000h,3434h,7AB9h
	prompt BYTE "Enter a 32-bit signed integer: ",0

.CODE
	main	PROC


	mov		eax,BlueTextOnGray
	call	SetTextColor

;---------------------------------------------------------------------
;						Dump Memory
	call	Clrscr						; clear the screen
	mov		esi,OFFSET arrayD
	mov		ebx,TYPE arrayD				; doubleword = 4 bytes
	mov		ecx,LENGTHOF arrayD			; number of units in arrayD
	call	DumpMem						; display memory

;---------------------------------------------------------------------
;						User Input Int
	call	Clrscr						; clear the screen
	mov		ecx,COUNT

L1: mov		edx,OFFSET prompt
	call	WriteString
	call	ReadInt						; input integer into EAX
	call	Crlf						; display a newlin
	
	call	WriteInt
	call	Crlf

	call	WriteHex
	call	Crlf

	call	WriteBin					; display in binary
	call	Crlf
	call	Crlf

	loop	L1							; repeat the loop

;---------------------------------------------------------------------
; 			Return the console window to default colors

	call 	WaitMsg 					; "Press any key..."
	mov 	eax,DefaultColor
	call 	SetTextColor
	call 	Clrscr

	exit 								; Exit (from SmallWin32.inc)
	; INVOKE	ExitProcess,0

	main	ENDP

END		main
INCLUDE	Irvine32.inc

COORD STRUCT
	X WORD ?
	Y WORD ?
COORD ENDS

SYSTEMTIME STRUCT
	 wYear WORD ?
	 wMonth WORD ?
	 wDayOfWeek WORD ?
	 wDay WORD ?
	 wHour WORD ?
	 wMinute WORD ?
	 wSecond WORD ?
	 wMilliseconds WORD ?
SYSTEMTIME ENDS


.DATA
	Days BYTE "Sun",0, "Mon",0, "Tue",0, "Wed",0, "Thu",0, "Fri",0, "Sat",0
	ALIGN DWORD
	sysTime SYSTEMTIME {}


	XYPos COORD <10,5>
	consoleHandle DWORD ? 
	colonStr BYTE ":",0
	AM_Str BYTE " AM",0
	PM_Str BYTE " PM",0
	isAM BYTE ?

	
	;------[10.1.8 Section Review]------------------------
	MyStruct STRUCT
		field1 word ?
		;align dword
		filed2 dword 20 dup(?)
	MyStruct ENDS

	myStruct1 MyStruct <>
	
	myStruct2 MyStruct <0>
	myStruct3 MyStruct <,20 dup(1)>

	myStructArr MyStruct 20 dup(<4,20 dup(2)>)


.CODE


;-----------------------------------------------------
Example		PROC
;
; This function does something
; Returns: nothing ... maybe something
;-----------------------------------------------------

	ret
Example		ENDP

main	PROC
	
	mov esi, 0
	mov ax, myStructArr[esi].field1
	mov esi, offset myStructArr
	add esi, type MyStruct*3
	mov ax, (MyStruct PTR [esi]).field1
	;------[10.1.8 Section Review END]------------------------


	; Get the standard output handle for the Win32 Console.
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov consoleHandle,eax
	; Set the cursor position and get the system time.
	INVOKE SetConsoleCursorPosition, consoleHandle, XYPos
	INVOKE GetLocalTime, ADDR sysTime
	

	movzx eax, sysTime.wDayOfWeek
	shl eax,2
	mov edx, offset Days
	add edx,eax
	call WriteString
	mov al,' '
	call WriteChar

	movzx eax, sysTime.wDay
	call WriteDec
	mov al,' '
	call WriteChar

	movzx eax, sysTime.wMonth
	call WriteDec
	mov al,' '
	call WriteChar

	movzx eax, sysTime.wYear
	call WriteDec
	mov al,' '
	call WriteChar


	; Display the system time (hh:mm:ss).
	movzx eax,sysTime.wHour ; hours
	;----------------------------------------
	; 12 hour
	xor edx,edx
	mov ebx,12
	div ebx
	
	cmp eax,1
	je PM
AM:
	mov isAM,1
	jmp C1
PM:
	mov isAM,0
C1:

	mov eax,edx
	;----------------------------------------

	call WriteDec
	mov edx,OFFSET colonStr ; ":"
	call WriteString
	movzx eax,sysTime.wMinute ; minutes
	call WriteDec
	call WriteString
	movzx eax,sysTime.wSecond ; seconds
	call WriteDec

	cmp isAM,1
	je WriteAM

WritePM:
	mov edx, offset PM_Str
	jmp C2
WriteAM:
	mov edx, offset AM_Str
C2:
	call WriteString


	call Crlf
	call WaitMsg ; "Press any key..."
	
	
	exit
main	ENDP


END		main
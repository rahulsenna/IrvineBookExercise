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

extern ExitProcess: proc
extern GetStdHandle: proc
extern SetConsoleCursorPosition: proc

extern GetLastError: proc
extern GetLocalTime: proc
extern WriteString: proc
extern WriteDec: proc

;extern WriteChar: proc


.DATA


	Days BYTE "Sun",0, "Mon",0, "Tue",0, "Wed",0, "Thu",0, "Fri",0, "Sat",0
	ALIGN DWORD
	sysTime SYSTEMTIME {}


	XYPos COORD <10,5>
	consoleHandle QWORD ? 
	colonStr BYTE ":",0
	AM_Str BYTE " AM",0
	PM_Str BYTE " PM",0
	SPC_Str BYTE " ",0

	isAM BYTE ?

	;------[10.1.8 Section Review]------------------------
	MyStruct STRUCT
		field1 word ?
		;align dword
		field2 dword 20 dup(?)
	MyStruct ENDS

	myStruct1 MyStruct <>
	
	myStruct2 MyStruct <0>
	myStruct3 MyStruct <,20 dup(1)>

	myStructArr MyStruct 20 dup(<4,20 dup(2)>)

.CODE


main	PROC
	mov rsi, 0
	mov ax, myStructArr[rsi].field1
	mov rsi, offset myStructArr
	add rsi, type MyStruct*3
	mov ax, (MyStruct PTR [rsi]).field1

	mov rax, type MyStruct
	mov rax, sizeof MyStruct
	mov rax, sizeof MyStruct.field2
	;------[10.1.8 Section Review END]------------------------

	;------------------------------------
	mov rcx, -11
	call GetStdHandle
	mov consoleHandle, rax
	;-----------------------------------------------------
	
	mov rcx,  consoleHandle
	mov edx, dword ptr [XYPos]
	call SetConsoleCursorPosition
	;-----------------------------------------------------
	mov rcx, OFFSET sysTime
	call GetLocalTime
	;-----------------------------------------------------
	movzx eax, sysTime.wDayOfWeek
	shl eax,2
	mov edx, offset Days
	add edx,eax
	call WriteString
	mov edx, offset SPC_Str
	call WriteString

	;-----------------------------------------------------
	movzx eax, sysTime.wDay
	call WriteDec
	mov edx, offset SPC_Str
	call WriteString

	movzx eax, sysTime.wMonth
	call WriteDec
	mov edx, offset SPC_Str
	call WriteString

	movzx eax, sysTime.wYear
	call WriteDec
	mov edx, offset SPC_Str
	call WriteString


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


;	call Crlf
;	call WaitMsg ; "Press any key..."
	


	mov rcx,69
	call ExitProcess

	ret
	
main	ENDP


END
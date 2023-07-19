.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

PROCEDURE		TEXTEQU		<PROC>
Sample			TEXTEQU		<"This is a Sample String", 0>
SetupESI		TEXTEQU		<mov	esi, OFFSET myArray>

.DATA
BackSpace		=	08h	 
SecondsInDay	=	24*60*60	

myArray			WORD	20	DUP(?)
ArraySize		=	($ - myArray)/2			; WORD is 2bytes long thus /2

myArray2		DWORD	30	DUP(?)			
ArraySize2		=	($ - myArray2)/4		; DWORD is 4bytes long thus /4

myString		BYTE	Sample


.CODE
main PROCEDURE
	mov		eax,5
	add		eax,6
	mov		ecx,BackSpace
	mov		ebx,SecondsInDay
	mov		edx,ArraySize
	lea		eax,myString
	SetupESI
	mov	edi, OFFSET myArray2

	INVOKE	ExitProcess,0

main ENDP
END main
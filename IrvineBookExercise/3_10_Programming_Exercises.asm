.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.DATA
A		=		53
B		=		32
C_VAL	=		97
D		=		23

answer	EQU		(A+B) - (C_VAL+D)

.CODE
main PROC
	mov		EAX,A
	mov		EBX,B
	mov		ECX,C_VAL
	mov		EDX,D
	add		EAX,EBX
	add		ECX,EDX
	sub		EAX,ECX
	mov		ESI,answer
	
	INVOKE	ExitProcess,0

main ENDP
END main
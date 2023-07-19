; 64bit AddVariables.asm - Chapter 3

;extern ExitProcess:		PROC
ExitProcess					PROTO

.data
firstval	QWORD	2000000h
secondval	QWORD	1111111h
thirdval	QWORD	2222222h

sum			QWORD	0

.code
main	PROC
	mov		rax,firstval
	add		rax,secondval
	add		rax,thirdval
	mov		sum,rax

	mov		rcx,0
	call	ExitProcess

main	ENDP

END

Fix needed in 64bit

* Set Entrypoint flag for linker
ProjectProperties -> Linker -> Advance -> Entry Point = main
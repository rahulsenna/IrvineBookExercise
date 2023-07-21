;		Pointers.asm

.386
.model	flat,stdcall
.stack	4096
ExitProcess		PROTO,dwExitCode:DWORD

;	Create user-defined types
PBYTE	TYPEDEF	PTR	BYTE		; pointer to bytes
PWORD	TYPEDEF	PTR	WORD		; pointer to words
PDWORD	TYPEDEF	PTR	DWORD		; pointer to double words

.DATA
arrayB		BYTE	10h,20h,30h,40h
arrayW		WORD	1,2,3,4
arrayD		DWORD	5,6,7,8

;	Create some pointer variables
ptr1	PBYTE	?
ptr2	PBYTE	arrayB
ptr3	PWORD	arrayW
ptr4	PDWORD	arrayD


.CODE
main	PROC

;	Use pointers to access data.
	
	mov		esi,ptr2
	mov		al,[esi]					; AL = 10h

	mov		esi,ptr3
	mov		ax,[esi]					; AX = 1

	mov		esi,ptr4
	mov		eax,[esi]					; EAX = 5

	mov		ptr1,esi

	INVOKE	ExitProcess,0

main	ENDP

END		main
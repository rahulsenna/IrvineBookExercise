;		4.4.5	Section Review 

.386
.model	flat,stdcall
.stack	4096
ExitProcess		PROTO,dwExitCode:DWORD

.DATA
	myBytes		BYTE	10h,20h,30h,40h
	myWords		WORD	8Ah,3Bh,72h,44h,66h
	myDoubles	DWORD	1,2,3,4,5
	myPointer	DWORD	myDoubles

.CODE
main	PROC
	
	mov		ebx,myPointer
	mov		eax,[ebx + TYPE DWORD * 4]

	; 5. -----------------------------------------------------
	mov		esi,OFFSET myBytes
	mov		al,[esi]				;	a.	AX  = 10h
	mov		al,[esi+3]				;	b.	EAX = 40h
	
	mov		esi, OFFSET myWords + 2
	mov		ax,[esi]				;	c.	AX	= 3Bh
	mov		edi,8
	mov		edx,[myDoubles + edi]	;	d.	EDX	= 3
	mov		edx,myDoubles[edi]		;	e.	EDX	= 3
	
	mov		ebx,myPointer			
	mov		eax,[ebx+4]				;	f.	EAX	= 2
	; 5. ---------------------END-----------------------------


	; 6. -----------------------------------------------------
	mov		esi,OFFSET myBytes
	mov		ax,[esi]				;	a.	AX  = 2010h
	mov		eax,DWORD PTR myWords	;	b.	EAX = 003B008Ah
	
	mov		esi, myPointer
	xor		eax,eax
	mov		ax,[esi+2]				;	c.	AX	= 0h
	mov		ax,[esi+6]				;	d.	AX	= 0h
	mov		ax,[esi-4]				;	e.	AX	= 44h
	; 6. ---------------------END-----------------------------


	INVOKE	ExitProcess,0
main	ENDP

END		main
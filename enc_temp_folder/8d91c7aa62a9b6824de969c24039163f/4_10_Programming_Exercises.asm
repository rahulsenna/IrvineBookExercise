;		4.10		Programming Exercises

.386
.model		flat,stdcall
.stack		4096

ExitProcess		PROTO,dwExitCode:DWORD

.DATA
	bigEndian		BYTE		12h,34h,56h,78h
	littleEndian	DWORD		?

.CODE
main		PROC
	mov		eax, DWORD PTR	bigEndian		; still big endian
	mov		ecx, LENGTHOF bigEndian
	mov		esi, OFFSET bigEndian
L1:
	mov		al, [esi]
	inc		esi
	mov		byte ptr [littleEndian+ecx-1], al
	loop	L1

	INVOKE	ExitProcess,0
main		ENDP

END		main
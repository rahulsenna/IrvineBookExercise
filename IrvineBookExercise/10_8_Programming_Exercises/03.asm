INCLUDE	Irvine32.inc

mMove32 MACRO src,dest
	push eax
	mov eax, src
	xchg dest,eax
	mov src,eax
	pop  eax
ENDM

.DATA
	one   DWORD 1
	two   DWORD 2

.CODE
main	PROC

	mMove32 one, two
	exit
main	ENDP


END		main
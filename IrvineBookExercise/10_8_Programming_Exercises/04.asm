INCLUDE	Irvine32.inc

mMult32 MACRO src,dest,res
	mov eax, src
	mul dest
	mov res,eax
ENDM

.DATA
	one   DWORD 5
	two   DWORD 2
	res   dword ?
.CODE
main	PROC

	mMult32 one, two,res
	exit
main	ENDP


END		main
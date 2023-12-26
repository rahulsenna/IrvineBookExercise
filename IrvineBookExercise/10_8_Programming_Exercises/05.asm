INCLUDE	Irvine32.inc

mReadInt MACRO size
	call ReadInt
IF size EQ 16
	mov res16,ax
ELSE
	mov res32,eax
ENDIF
ENDM

.DATA
	res16  WORD ?
	res32 DWORD ?
.CODE

main	PROC

	mReadInt 16 
	mReadInt 32 


	exit
main	ENDP


END		main
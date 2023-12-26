INCLUDE	Irvine32.inc

mWriteInt MACRO num
	
IF TYPE num EQ 4
	mov eax,num
ELSE
	movzx eax,num
ENDIF
	call WriteInt
	call Crlf
ENDM

.DATA
	num8   BYTE  233
	num16  WORD  16423
	num32 DWORD  4343234
.CODE

main	PROC
	mWriteInt num8
	mWriteInt num16
	mWriteInt num32

	exit
main	ENDP


END		main
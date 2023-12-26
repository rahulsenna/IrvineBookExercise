INCLUDE	Irvine32.inc

mReadKey MACRO ascii, scan
	call ReadChar
	mov ascii,al
	mov scan,ah
ENDM

.DATA
	ascii BYTE ?
	scan BYTE ?
.CODE

main	PROC

	mReadkey ascii, scan

	exit
main	ENDP


END		main
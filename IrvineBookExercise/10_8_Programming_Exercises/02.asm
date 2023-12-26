INCLUDE	Irvine32.inc

mWritestring  MACRO string,color

	mov eax,color  ;(blue * 16) ; white on blue
	call SetTextColor
	push edx
	mov edx, offset string
	call WriteString
	call Crlf
	pop edx
ENDM

.DATA
	myString db "Here is my string",0
.CODE

main	PROC
	mWritestring myString, red
	mWritestring myString, blue
	mWritestring myString, green
	mWritestring myString, white
	mWritestring myString, yellow


	exit
main	ENDP


END		main
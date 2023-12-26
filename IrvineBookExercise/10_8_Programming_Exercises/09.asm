INCLUDE	Irvine32.inc

mShiftDoublewords MACRO arrayName, direction, numberOfBits
	
	mov eax, 0
IFIDNI <direction>, <R>
	shrd arrayName,eax, numberOfBits
ELSE
	shld arrayName,eax, numberOfBits
ENDIF
ENDM

.DATA
	arr dword 010010001b
.CODE

main	PROC
	mShiftDoublewords arr, R, 1
	mShiftDoublewords arr, L,10
	exit
main	ENDP

END		main
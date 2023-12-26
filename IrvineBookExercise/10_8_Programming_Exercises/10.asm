INCLUDE	Irvine32.inc

add3 MACRO dest,src1,src2
	mov eax, src1
	add eax, src2
	mov dest,eax
ENDM

sub3 MACRO dest,src1,src2
	mov eax, src1
	sub eax, src2
	mov dest,eax
ENDM

mul3 MACRO dest,src1,src2
	push edx
	mov eax, src1
	mul src2
	mov dest,eax
	push edx
ENDM

div3 MACRO dest,src1,src2
	push edx
	xor edx,edx
	mov eax, src1
	div src2
	mov dest,eax
	push edx
ENDM

.DATA
	w SDWORD 2
	x SDWORD 4
	y SDWORD 5
	z SDWORD 3
	temp SDWORD  ?
.CODE

main	PROC
	div3 temp, x,w

	add3 temp, w, y ; temp = w + y
	mul3 x, temp, z ; x = temp * z

	exit
main	ENDP


END		main
INCLUDE Irvine32.inc

.DATA


.CODE
main		PROC

;	Challenge: Write a series of instructions that shift the lowest bit of AX into the highest bit
;	of BX without using the SHRD instruction. Next, perform the same operation using SHRD
;-----------------------------------------------------------	
	; Without SHRD
	mov		ax,00010101b
	mov		bx,0

	shr		ax,1
	rcr		bx,1
	; With SHRD
	mov		ax,00010101b
	mov		bx,0

	shrd	bx,ax,1


;	6. Challenge: One way to calculate the parity of a 32-bit number in EAX is to use a loop that
;	shifts each bit into the Carry flag and accumulates a count of the number of times the Carry
;	flag was set. Write a code that does this, and set the Parity flag accordingly.
;--------------------------------------------------------



;	Binary Multiplication

	;  3 * 8       2^3 = 8  == 8
	mov		eax,3
	shl		eax,3								; eax = 3*8

	;  3 * 9       2^3 = 8 + 2^0 = 1 == 9
	mov		eax,3
	mov		edx,eax
	shl		eax,3
	add		eax,edx								; eax = 3*9

	;  3 * 10       2^3 = 8 + 2^1 = 2 == 10
	mov		eax,3
	mov		edx,eax
	shl		eax,3								; 3 * 8 = 24
	shl		edx,1								; 3 * 2 = 6

	add		eax,edx								; eax = 3*10

	nop



	exit
main		ENDP

END			main
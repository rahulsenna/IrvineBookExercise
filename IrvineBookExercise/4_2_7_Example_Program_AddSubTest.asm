; Addition and Subtraction			(AddSubTest.asm)

.386
.model 	flat,stdcall
.stack 	4096
ExitProcess 	PROTO,dwExitCode:DWORD

.data
	val1 BYTE 10h
	val2 WORD 8000h
	val3 DWORD 0FFFFh
	val4 WORD 7FFFh

	a	byte	11000000b
	b	byte	11000001b
COMMENT !
	*** How the Hardware Detects Overflow ***

	OverFlowFlag = CarryFlag ^ CarryInBit
	---------------------------------------------------------
	Example 1

	Carry:     1
	a	byte	10000000b +
	b	byte	10000001b
	CarryInBit	0

	CarryFlag 1 and CarryInBit 0
	: OverFlowFlag = 1 ^ 0 = 1

	---------------------------------------------------------
	Example 2  
	Carry	   11
	a	byte	11000000b +
	b	byte	11000001b
	CarryInBit 	10

	CarryFlag 1 and CarryInBit 1
	: OverFlowFlag = 1 ^ 1 = 0
	---------------------------------------------------------
	
!

SomeVal		DWORD	1
.code

main 	PROC
	;   Loading memory address in registers
	xor		eax,eax
	mov		eax,OFFSET SomeVal
	lea		esi,SomeVal
	mov		eax,SomeVal

	; 	Overflow flag example
	mov		ax,val2
	add		ax,1


	mov		al,a
	add		al,b

	mov 	ax,07fffh
	add 	ax,1


	mov		al,-127
	neg		al

;	----------------------
;	4.2.8 Section Review
;	6.
	mov ax,7FF0h
	add al,10h		; a. CF = 1 SF = 0 ZF = 1 OF = 0 
	add ah,1		; b. CF = 0 SF = 1 ZF = 0 OF = 1
	add ax,2		; c. CF = 0 SF = 1 ZF = 0 OF = 0



	INVOKE 	ExitProcess,0

main 	ENDP

END 	main
; Calling a subroutine in 64-bit mode (CallProc_64.asm)
; Chapter 5 example

ExitProcess PROTO
WriteInt64 PROTO		; Irvine64 library
Crlf PROTO				; Irvine64 librar


.CODE

main	PROC
	sub		rsp,8			; Align the stack, stack is not aligned right now becaue _call_ instruction increments _rsp_ by 8, (main was called by OS)
	sub		rsp,20h			; shadow space

	mov		rcx,1
	mov		rdx,2
	mov		r8,3
	mov		r9,4

	call	AddFour

	call	WriteInt64

	mov		rcx,0
	call	ExitProcess

	
main	ENDP

AddFour		PROC
	mov		rax,rcx
	add		rax,rdx
	add		rax,r8
	add		rax,r9
	ret
AddFour		ENDP


END
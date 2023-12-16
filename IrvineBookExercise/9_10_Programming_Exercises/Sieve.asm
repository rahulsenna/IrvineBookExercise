INCLUDE	Irvine32.inc

.DATA
	N_PRIMES = 65000
	sieve_arr byte N_PRIMES dup(?)
.CODE


;-----------------------------------------------------
GenPrimes PROC,
	table: PTR BYTE,
	count: DWORD
;
; Generates prime numbers
; Returns: nothing
;-----------------------------------------------------
	; fill with zeros

	mov ecx,count
	shr ecx,2     ; divide by 4
	mov eax,0FFFFFFFFh
	mov edi,table
	rep stosd

	mov ecx,count
	mov esi,2
	mov edi,table

L1:
	mov eax,esi
	mul esi
	cmp eax,ecx    ; i*i <= N_Primes
	jg EndOfLoop
L2:
	mov BYTE PTR[edi+eax],0
	add eax,esi
	cmp eax,ecx
	jbe L2
	inc esi
	jmp L1
EndOfLoop:
	ret
GenPrimes ENDP

main	PROC
	INVOKE GenPrimes, ADDR sieve_arr, N_PRIMES

	; print prime numbers
	mov ecx,N_PRIMES
	mov esi,2
L1:
	cmp BYTE PTR [sieve_arr+esi],0ffh
	jne Continue
	mov eax,esi
	call WriteInt
	call Crlf
Continue:
	inc esi
loop	L1

	exit
main	ENDP


END		main
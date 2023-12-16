INCLUDE	Irvine32.inc

.DATA
	target BYTE "AAEBDCFBBC",0
	freqTable DWORD 256 DUP(0)
	arrow byte " -> ",0
.CODE


;-----------------------------------------------------
Get_frequencies	PROC,
	tgt: PTR BYTE,
	table: PTR DWORD
;
; This function does something
; Returns: nothing ... maybe something
;-----------------------------------------------------
	INVOKE Str_length, tgt
	mov ecx,eax
	mov esi, tgt
	mov edi,table
	xor eax,eax
L1:
	lodsb
	mov ebx,[edi+eax*4]
	inc ebx
	mov dword ptr [edi+eax*4],ebx

loop L1
	ret
Get_frequencies	ENDP

main	PROC
	INVOKE Get_frequencies, ADDR target, ADDR freqTable

	mov ecx,256
	; print freq table
L1:
	cmp [freqTable+ecx*4-4],0
	jle Continue
	mov eax,ecx
	dec eax
	call WriteChar
	mov edx, offset arrow
	call WriteString
	mov eax,[freqTable+ecx*4-4]
	call WriteInt
	call Crlf
Continue:

loop L1

	exit
main	ENDP


END		main
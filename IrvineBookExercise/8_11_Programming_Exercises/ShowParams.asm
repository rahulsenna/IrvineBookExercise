INCLUDE	Irvine32.inc

.DATA

	StackParamsHeader	BYTE	"Stack parameters:", 10, "---------------------------",10,0
.CODE


;-----------------------------------------------------
ShowParams		PROC,
	ParamCount:DWORD
;
; This function does something
; Returns: nothing ... maybe something
;-----------------------------------------------------

	mov		edx,OFFSET StackParamsHeader
	call	WriteString

	mov		ecx,ParamCount

;	esp = ebp, 
;	ebp+4= ret addr, 
;	ebp+8 = last push in calee, (MySample PROC)
;	ebp+12 = prevEBP, 
;	ebp+16 = prevRET addr,
;	ebp+20 = last push in calee's calee proc (main PROC)
	mov		esi,ebp
	add		esi,20
L1:
	mov		eax,esi
	call	WriteHex	; address
	
	mov		al,'='
	call	WriteChar
	
	mov		eax,[esi]
	call	WriteHex	; value
	call	Crlf
	
	add		esi,4
	loop	L1
	
	ret
ShowParams		ENDP

;-----------------------------------------------------
MySample PROC first:DWORD, second:DWORD, third:DWORD,f:DWORD
;
; Sample Proc
; Returns: nothing
;-----------------------------------------------------
	paramCount = 4
	INVOKE ShowParams, paramCount

	ret
MySample ENDP

main	PROC

	INVOKE MySample, 1234h, 5000h, 6543h,0B00B1E5h
	exit
main	ENDP


END		main
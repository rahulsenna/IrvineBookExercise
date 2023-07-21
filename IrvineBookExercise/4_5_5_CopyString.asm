;		CopyString.asm

.386
.model		flat,stdcall
.stack		4096

ExitProcess		PROTO,dwExitCode:DWORD

.DATA

	source		BYTE	"This is an example string!",0Ah,03D,0
	target		BYTE	SIZEOF source	DUP(?)

.CODE

main	PROC	
	mov		esi, OFFSET source
	mov		edi, 0					; using edi just for fun
	mov		ecx, LENGTHOF source

L1:
;	mov		al,source[edi]
	mov		al,[esi]
	mov		target[edi],al
	inc		esi
	inc		edi
	loop	L1


; -----------------4.5.6 Section Review Q.10-------------------------------
;				Fixing Infinite Loop

	mov		eax,0
	mov		ecx,10	; outer loop counter
	L01:
	push	ecx		; Saving ecx register on the stack so outer loops counter doesn't get overwritten
	mov		eax,3
	mov		ecx,5	; inner loop counter
	L02:
	add		eax,5
	loop	L02		; repeat inner loop
	pop		ecx		; Restoring outer loops counter
	loop	L01		; repeat outer loop
; ---------------4.5.6 Section Review Q.10--END----------------------------


	INVOKE	ExitProcess,0
	
main	ENDP

;	jmp only Jump to Label at current procedure
nonmain		PROC

jumptonon:
	mov		eax,69
nonmain		ENDP

END		main
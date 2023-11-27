INCLUDE Irvine32.inc

.CODE

PromptForInt PROC,
	array_size: DWORD,
	array_ptr: PTR DWORD,
	prompt_ptr: PTR byte

	mov ecx, array_size

	cmp ecx,0
	jle QUIT
	mov esi, array_ptr
L1:	
	mov edx,  prompt_ptr
	call WriteString

	call ReadInt
	mov [esi],eax
	add esi,4

	loop L1
QUIT:	
	ret
PromptForInt ENDP

END

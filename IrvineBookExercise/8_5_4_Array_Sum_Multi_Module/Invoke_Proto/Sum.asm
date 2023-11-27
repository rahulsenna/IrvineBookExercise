INCLUDE Irvine32.inc



.code

Sum_Array proc,
	array_size: dword,
	array_ptr: ptr dword,

	mov ecx, array_size

	cmp ecx,0
	jle L2
	mov esi, array_ptr
	xor eax,eax
L1:	
	add eax,[esi]
	add esi,4
	loop L1
L2:	
	ret



Sum_Array endp

END

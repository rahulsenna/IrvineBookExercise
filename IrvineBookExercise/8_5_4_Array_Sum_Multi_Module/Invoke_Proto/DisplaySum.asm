INCLUDE Irvine32.inc


.code

Display_Sum proc,
	sum: dword,
	prompt_ptr: ptr dword,

	mov edx, prompt_ptr
	call WriteString
	mov edx, sum
	call WriteInt
	ret

Display_Sum endp

END


INCLUDE Irvine32.inc

PromptForInt PROTO,
	array_size: DWORD,
	array_ptr: PTR DWORD,
	prompt_ptr: PTR BYTE

Sum_Array PROTO,
	array_size: DWORD,
	array_ptr: PTR DWORD


Display_Sum PROTO,
	sum: DWORD,
	prompt_ptr: PTR DWORD

.DATA

	num_count    = 3
	array       DWORD num_count DUP(?)
	prompt_q    BYTE  "Please enter a number: ",0
	prompt_a  BYTE  "Sum : ",0
	sum 	    DWORD ?

.CODE

Example proc USES ecx edx,
	p1:dword, p2:byte, p3:byte, p4:word
	LOCAL l1:dword, l2:byte, l3:byte, l4:word
	mov eax,p1
	mov l1,eax

	mov bl,p2
	mov l2,bl

	mov cl,p3
	mov l3,cl

	mov dx,p4
	mov l4,dx

	ret
Example endp

main PROC

	INVOKE Example, 20h, 0AAh, 0BBh, 0EEEEh

	INVOKE PromptForInt, num_count, OFFSET array, ADDR prompt_q
	INVOKE Sum_Array, num_count, ADDR array
	INVOKE Display_Sum, sum, ADDR prompt_a
	mov sum,eax

	exit

main ENDP

END main
INCLUDE Irvine32.inc

extern ExitProcess@4: PROC

extern PromptForInts@0: PROC
extern CalcSum@0: PROC
extern DisplaySum@0: PROC


.DATA
	num_count    = 3
	array       DWORD num_count DUP(?)
	prompt_q    BYTE  "Please enter a number: ",0
	prompt_a    BYTE  "Sum : ",0
	sum 	    DWORD ?

.CODE

main PROC

    push num_count
    push OFFSET array
    push OFFSET prompt_q
    call PromptForInts@0
    
    push num_count
    push OFFSET array
    call CalcSum@0

    push eax
    push OFFSET prompt_a
    call DisplaySum@0
    
    push 69
    call ExitProcess@4

    ret

main ENDP

END main



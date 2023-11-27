INCLUDE Irvine32.inc
.CODE

PromptForInts PROC
    
    push ebp
    mov ebp,esp

    mov ecx, [ebp+16]
    cmp ecx,0
    jle Quit

    mov edx, [ebp+8]
    mov esi, [ebp+12]
L1:
    call WriteString
    call ReadInt
    mov [esi],eax
    add esi,4
    loop L1
    
Quit:
    pop ebp
    ret 12

PromptForInts ENDP

END
INCLUDE Irvine32.inc

.CODE


CalcSum PROC
    push ebp
    mov  ebp,esp

    mov ecx,[ebp+12]
    cmp ecx,0
    jle Quit

    mov esi,[ebp+8]
    xor eax,eax
L1:
    add eax,[esi]
    add esi,4
    loop L1

Quit:
    pop ebp
    ret 8

CalcSum ENDP

END
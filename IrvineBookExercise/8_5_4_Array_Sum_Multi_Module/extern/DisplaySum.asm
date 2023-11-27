INCLUDE Irvine32.inc

.CODE
DisplaySum PROC
    push ebp
    mov ebp,esp

    mov edx,[ebp+8]
    call WriteString
    mov edx,[ebp+12]
    call WriteInt


    pop ebp
    ret 8

DisplaySum ENDP

END
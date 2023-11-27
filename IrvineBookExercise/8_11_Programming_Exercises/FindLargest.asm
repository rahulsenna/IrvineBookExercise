INCLUDE Irvine32.inc

.DATA

    arr1    DWORD   -88, 3,4,5,7,2,4,1,4,5,-1,-3
    cnt1    = ($-arr1)/4

    arr2    DWORD   -99,-65,-7,-54,-66,-22,-2
    cnt2    = ($-arr2)/4

.CODE

FindLargest PROTO,
    array: PTR DWORD, count: DWORD

main PROC
    INVOKE FindLargest, ADDR arr1, cnt1
    call	WriteInt
	call	Crlf

    mov     ecx,cnt2
    push    cnt2
    push    OFFSET arr2
    call    FindLargest

    call	WriteInt
	call	Crlf

    exit
main ENDP


;---------------------------------------------
FindLargest PROC,
    array: PTR DWORD, count: DWORD
    LOCAL   var1 :DWORD
; Finds and returns largest  signed doubleword (int) num
; Receives: [ebp+8]:dword = Pointer to Array, [ebp+12]:dword = array length
; Returns:  EAX
;---------------------------------------------
    pushad
    mov     esi,array
    mov     ecx,count
    mov     eax,[esi]
L1:
    cmp     [esi+ecx*4-4],eax
    jle      less
    mov     eax,[esi+ecx*4-4]
less:
    loop    L1

    mov     var1,eax
    popad
    mov     eax,var1
    ret

FindLargest ENDP

END main
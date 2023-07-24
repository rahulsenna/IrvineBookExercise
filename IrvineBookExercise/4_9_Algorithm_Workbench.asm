COMMENT !
4.9.2 Algorithm Workbench




4. Write code using byte operands that adds two negative integers and causes the Overflow
flag to be set.

5. Write a sequence of two instructions that use addition to set the Zero and Carry flags at the
same time.

6. Write a sequence of two instructions that set the Carry flag using subtraction.

7. Implement the following arithmetic expression in assembly language: EAX = –val2 + 7 –
val3 + val1. Assume that val1, val2, and val3 are 32-bit integer variables.

8. Write a loop that iterates through a doubleword array and calculates the sum of its elements
using a scale factor with indexed addressing.

9. Implement the following expression in assembly language: AX = (val2 + BX) –val4.
Assume that val2 and val4 are 16-bit integer variables.

10. Write a sequence of two instructions that set both the Carry and Overflow flags at the same time.

11. Write a sequence of instructions showing how the Zero flag could be used to indicate
unsigned overflow after executing INC and DEC instructions.
Use the following data definitions for Questions 12–18:
.data
myBytes BYTE 10h,20h,30h,40h
myWords WORD 3 DUP(?),2000h
myString BYTE "ABCDE"

12. Insert a directive in the given data that aligns myBytes to an even-numbered address.

13. What will be the value of EAX after each of the following instructions execute?
mov eax,TYPE myBytes ; a.
mov eax,LENGTHOF myBytes ; b.
mov eax,SIZEOF myBytes ; c.
mov eax,TYPE myWords ; d.
mov eax,LENGTHOF myWords ; e.
mov eax,SIZEOF myWords ; f.
mov eax,SIZEOF myString ; g.

14. Write a single instruction that moves the first two bytes in myBytes to the DX register. The
resulting value will be 2010h.

15. Write an instruction that moves the second byte in myWords to the AL register.

16. Write an instruction that moves all four bytes in myBytes to the EAX register.

17. Insert a LABEL directive in the given data that permits myWords to be moved directly to a
32-bit register.

18. Insert a LABEL directive in the given data that permits myBytes to be moved directly to a
16-bit register
!

.386
.model		flat,stdcall
.stack		4096

ExitProcess		PROTO,dwExitCode:DWORD

.CODE

main		PROC

;   1. Write a sequence of MOV instructions that will exchange the upper and lower words in a
;   doubleword variable named three.
;   ---------------------------------------------------------------------

.DATA
	three		DWORD		0AAAAFFFFh
.CODE

	mov		bx,WORD PTR [three]
	mov		cx,WORD PTR [three+2]
	mov		WORD PTR [three],cx
	mov		WORD PTR[three+2],bx

;   2. Using the XCHG instruction no more than three times, reorder the values in four 8-bit registers from the order A,B,C,D to B,C,D,A.
;	 ---------------------------------------------------------------------
    mov     al,'A'
    mov     bl,'B'
    mov     cl,'C'
    mov     dl,'D'

	xchg	al,dl
	xchg	al,bl
	xchg	bl,cl

;	3. Transmitted messages often include a parity bit whose value is combined with a data byte to
;	produce an even number of 1 bits. Suppose a message byte in the AL register contains
;	01110101. Show how you could use the Parity flag combined with an arithmetic instruction
;	to determine if this message byte has even or odd parity.
;	 ---------------------------------------------------------------------
	mov		al,01110101b
	add		eax,0					; Flag PE = 0, This message has _odd_ parity
	mov		ecx,0





	INVOKE	ExitProcess,0

main		ENDP
END		main
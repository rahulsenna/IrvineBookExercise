.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD


.DATA

; *2. Symbolic Integer Constant
SUNDAY		=		0
MONDAY		=		1
TUESDAY		=		2
WEDNESDAY	=		3
THURSDAY	=		4
FRIDAY		=		5
SATURDAY	=		6

WEEK		BYTE	SUNDAY,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY
WEEKDAYS	=	($ - WEEK)
; *2. Symbolic Integer Constant END


; *3. Data Definitions
	
largest8bitUnsingedInt 		BYTE 	0FFh		;	255 in decimal
largest8bitSingedInt 		SBYTE 	07Fh 		;	127 in decimal
smallest8bitSingedInt 		SBYTE 	080h    	;  -128 in decimal

largest16bitUnsingedInt 	WORD 	0FFFFh  	;	65535 in decimal
largest16bitSingedInt 		SWORD 	07FFFh 		;  	32767
smallest16bitSingedInt 		SWORD 	08000h 		;  -32768


largest32bitUnsingedInt 	DWORD 	0FFFFFFFFh  ;	4,294,967,296 in decimal
largest32bitSingedInt 		SDWORD 	07FFFFFFFh  ;  	2,147,483,647
smallest32bitSingedInt 		SDWORD 	080000000h  ;  -2,147,483,648


largest64bitUnsingedInt 	QWORD 	0FFFFFFFFFFFFFFFFh  ;	18,446,744,073,709,551,615 in decimal
largest64bitSingedInt 		SQWORD 	07FFFFFFFFFFFFFFFh  ;  	9,223,372,036,854,775,807
smallest64bitSingedInt 		SQWORD 	08000000000000000h  ;  -9,223,372,036,854,775,808



largest48bitUnsingedInt 	FWORD 	0FFFFFFFFFFFFh  	;	281,474,976,710,655 in decimal

packedBCD_VAL 				TBYTE 	080000000000000001234h ;
posVal						REAL8	1.5
bcdVal						TBYTE	?

rVal1						REAL4	-1.2
rVal2						REAL8	3.2E-260
rVal3						REAL10	4.6E+4096
; *3. Data Definitions END

; *4. Symbolic Text Constant

Greeting		EQU		"Hello World!",0
Greeting2		EQU		<"Hello Assembler!",0ah,0dh,0>
Greeting3		TEXTEQU	<"Hello Sailor!",0ah,0dh,0>

helloWorldString	BYTE	Greeting
helloSailorString	BYTE	Greeting3

; *4. Symbolic Text Constant END


.CODE
main PROC

; *1. Interger Expression Calculation
.DATA
	A		=		53
	B		=		32
	C_VAL	=		97
	D		=		23
	answer	EQU		(A+B) - (C_VAL+D)
.CODE
	mov		EAX,A
	mov		EBX,B
	mov		ECX,C_VAL
	mov		EDX,D
	add		EAX,EBX
	add		ECX,EDX
	sub		EAX,ECX
	mov		ESI,answer
; *1. Interger Expression Calculation END
	fld		posVal
	fbstp	bcdVal
	MOV		EDI,WEEKDAYS

	lea		eax, helloSailorString
	
	INVOKE	ExitProcess,0

main ENDP
END main
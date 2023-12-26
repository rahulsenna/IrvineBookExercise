; Drunkard's Walk (Walk.asm)
; Drunkard's walk program. The professor starts at 
; coordinates 25, 25 and wanders around the immediate area.
INCLUDE Irvine32.inc
WalkMax = 50
StartX = 25
StartY = 25

DrunkardWalk STRUCT
	path COORD WalkMax DUP(<0,0>)
	pathsUsed WORD 0
DrunkardWalk ENDS

DisplayPosition PROTO currX:WORD, currY:WORD
.data
	aWalk DrunkardWalk <>
.code
main PROC
	mov esi,OFFSET aWalk
	call TakeDrunkenWalk
	exit
main ENDP
;-------------------------------------------------------
TakeDrunkenWalk PROC
LOCAL currX:WORD, currY:WORD,lastDir:DWORD
;
; Takes a walk in random directions (north, south, east,
; west).
; Receives: ESI points to a DrunkardWalk structure
; Returns: the structure is initialized with random values
;-------------------------------------------------------
	pushad
	; Use the OFFSET operator to obtain the address of the
	; path, the array of COORD objects, and copy it to EDI.
	mov edi,esi
	add edi,OFFSET DrunkardWalk.path
	mov ecx,WalkMax ; loop counter
	mov currX,StartX ; current X-location
	mov currY,StartY ; current Y-location

	call Randomize
	mov eax,4 ; init dir
	call RandomRange
	mov lastDir,eax
Again:
	; Insert current location in array.
	mov ax,currX
	mov (COORD PTR [edi]).X,ax
	mov ax,currY
	mov (COORD PTR [edi]).Y,ax
	INVOKE DisplayPosition, currX, currY
	mov eax,100 ; choose a probabilty of 100
	call RandomRange
	mov ebx,lastDir
	.IF eax <= 50          ; 50% probablity continue dir
	nop				       ; unchanged
	.ELSEIF eax <= 60      ; 10% probabily reverse dir
		.IF ebx == 0       ; North
		 mov lastDir,1
		.ELSEIF ebx == 1 ; South
		 mov lastDir,0
		.ELSEIF ebx == 2 ; West
		 mov lastDir,3
		.ELSE            ; East (EBX = 3)
		 mov lastDir,2
		.ENDIF
	.ELSEIF eax <= 80          ; 20% probabily move LEFT
		.IF ebx == 0           ; North
		 mov lastDir,2         ; Going NORTH turn LEFT = WEST
		.ELSEIF ebx == 1       ; South
		 mov lastDir,3         ; Going SOUTH turn LEFT = EAST
		.ELSEIF ebx == 2       ; West
		 mov lastDir,1         ; Going WEST turn LEFT = SOUTH
		.ELSE                  ; East (EBX = 3)
		 mov lastDir,0         ; Going EAST turn LEFT = NORTH
		.ENDIF
	.ELSE             ; 20% probabily move right
		.IF ebx == 0 ; North
		 mov lastDir,3
		.ELSEIF ebx == 1 ; South
		 mov lastDir,2
		.ELSEIF ebx == 2 ; West
		 mov lastDir,0
		.ELSE ; East (EBX = 3)
		 mov lastDir,1
		.ENDIF
	.ENDIF

	.IF ebx == 0 ; North
		dec currY
	.ELSEIF ebx == 1 ; South
		inc currY
	.ELSEIF ebx == 2 ; West
		dec currX
	.ELSE ; East (EAX = 3)
		inc currX
	.ENDIF
	add edi,TYPE COORD ; point to next COORD
	;loop Again
	dec ecx
	cmp ecx,0
	jg Again

Finish:
	mov (DrunkardWalk PTR [esi]).pathsUsed, WalkMax
	popad
	ret
TakeDrunkenWalk ENDP

;-------------------------------------------------------
DisplayPosition PROC currX:WORD, currY:WORD
; Display the current X and Y positions.
;-------------------------------------------------------
.data
	commaStr BYTE ",",0
.code
	pushad
	movzx eax,currX ; current X position
	call WriteDec
	mov edx,OFFSET commaStr ; "," string
	call WriteString
	movzx eax,currY ; current Y position
	call WriteDec
	call Crlf
	popad
	ret
DisplayPosition ENDP
END main


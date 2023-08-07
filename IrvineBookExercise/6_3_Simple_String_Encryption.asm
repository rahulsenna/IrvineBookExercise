;	Application: Simple String Encription

INCLUDE	Irvine32.inc

.DATA
	prompt				BYTE		"Please enter plain text: ",0
	cipher_label		BYTE		"Cipher text:             ",0
	decrypt_label		BYTE		"Decrypted:               ",0

	input_string        BYTE        255 DUP(?)
	char_read           DWORD       ?
	encrypted_string    BYTE        255 DUP(?)
	KEY                 =           01011011b

.CODE

main		PROC

	xor		eax,eax
	mov		al,10001010b
	xor		al,01010101b
	;and		al,11111111b


	nop
;-----------------------------------------
;               Input
	mov     edx,OFFSET prompt
	call    WriteString
	mov     edx,OFFSET input_string
	mov     ecx,SIZEOF input_string
	call    ReadString
	mov     char_read,eax
	mov     input_string[eax],0
;-----------------------------------------
;               Encryption
	mov     ecx,eax
EncryptionLoop:
	xor     input_string[ecx-1],KEY
	loop    EncryptionLoop

	mov     edx,OFFSET cipher_label
	call    WriteString
	mov     edx,OFFSET input_string
	call    WriteString
	call    Crlf

;-----------------------------------------
;               Decryption
	mov     ecx,eax
DecryptionLoop:
	xor     input_string[ecx-1],KEY
	loop    DecryptionLoop

	mov     edx,OFFSET decrypt_label
	call    WriteString

	mov     edx,OFFSET input_string
	call    WriteString

	exit
main		ENDP

END	main
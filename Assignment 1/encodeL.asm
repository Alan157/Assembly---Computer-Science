;
;  HW3 ENCODE
;void encode(char code_array[], char msg[], char encoded_msg[]);
; original msg in -> char msg[]
; we put in encoded in -> char encoded_msg[]
; we take the code from char code_array[]


    .MODEL LARGE
    .STACK 100h
    .DATA
	   
	.CODE
	.386
	PUBLIC _encode
    _encode PROC FAR

	; BP+16 -> OFFSET code_array[]    ES:BX
	; BP+18 -> SEG  code_array[]  

	; BP+20 -> OFFSET msg[]           GS:SI
	; BP+22 -> SEG msg[]

	; BP+24 -> OFFSET encoded_msg[]   FS:DI
	; BP+26 -> SEG encoded_msg[]
    
	
	;save values 
    PUSH BP
	PUSH DI
	PUSH SI
	PUSH ES
    PUSH GS
	PUSH FS
	MOV BP,SP

	MOV ES,[BP+18]
	MOV BX,[BP+16]
	
	MOV GS,[BP+22]
	MOV SI,[BP+20]

	MOV FS,[BP+26]
	MOV DI,[BP+24]


	

	Encode:
	CMP Byte PTR GS:[SI],0 ; We check if we reached the end of the msg string
	JE EndOfMsg

	MOV BX,[BP+16]
	XOR AX,AX
	XOR DX,DX
	MOV AL,Byte PTR GS:[SI] ; AL=msg[0]
	ADD BX,AX               ; Code_array[0] is ES:[BX] now we want the Code_array[AH] -> SO ES:[BX+AH] 
	MOV DL,Byte PTR ES:[BX]
	MOV Byte PTR FS:[DI],DL ;Encoded_msg[0]=Code_array[AH]
	INC SI 
	INC DI

	JMP Encode
	EndOfMsg: ;We need to put NULL in the end of encoded msg
	MOV Byte PTR FS:[DI],0


    POP FS
	POP GS
	POP ES 
	POP SI
	POP DI
	POP BP 

	RET
 _encode ENDP
END


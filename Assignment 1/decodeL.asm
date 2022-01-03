;
;  HW3 DECODE
; extern void decode(char code_array[], char msg[], char decoded_msg[]);
; encoded msg in -> char msg[]
; we put in decoded in -> char decoded_msg[]
; we take the code from char code_array[]


    .MODEL LARGE
    .STACK 100h
    .DATA
	   

	.CODE
	.386
	PUBLIC _decode
    _decode PROC FAR

	; BP+16 -> OFFSET code_array[]    ES:BX
	; BP+18 -> SEG  code_array[]  

	; BP+20 -> OFFSET msg[]           GS:SI
	; BP+22 -> SEG msg[]

	; BP+24 -> OFFSET decoded_msg[]   FS:DI
	; BP+26 -> SEG decoded_msg[]
    
	
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


	

	Decode:
	CMP Byte PTR GS:[SI],0 ; We check if we reached the end of the encoded string
	JE EndOfMsg

	MOV BX,[BP+16]
	XOR AX,AX
	XOR CX,CX
	XOR DX,DX

	MOV AL,Byte PTR GS:[SI] ; AL=encoded msg[0]

	FindOriginal:
    CMP AL,Byte PTR ES:[BX] ;check the index to find out the correct output.
	JE Match
	INC BX ;We need the index
	INC CX
	JMP FindOriginal
	Match:
	              ; Code_array[0] is ES:[BX] now we want the Code_array[AH] -> SO ES:[BX+AH] 
	MOV Byte PTR FS:[DI],CL ;decoded_msg[0]=INDEX=BX
	INC SI 
	INC DI

	JMP Decode
	EndOfMsg: ;We need to put NULL in the end of decoded msg
	MOV Byte PTR FS:[DI],0


    POP FS
	POP GS
	POP ES 
	POP SI
	POP DI
	POP BP 

	RET
 _decode ENDP
END


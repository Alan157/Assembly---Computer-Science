; 
;
    .MODEL SMALL
    .STACK 100h
    .DATA
	;Var
N DB 3
ARR1 DB 0,0,0
ARR2 DB 0,0,0
     
                            
     .CODE
	 ProgStart:
     MOV AX,@DATA
     MOV DS,AX              ; Set DS to point to data segment

	 ;DI,SI Pointers to the Arrays.
     MOV DI,OFFSET ARR1 
	 MOV SI,OFFSET ARR2 

	 ToStart:

	 CMP N,0
	 JE ToEnd
	 MOV AL,N
	 MOV BYTE PTR[DI],AL
	 ADD AL,'0' ;For the ASCII CODE.
	 MOV BYTE PTR[SI],AL
	 DEC N  ;N--
	 INC DI ;DI ++
	 INC SI ;SI ++
	 JMP ToStart
     

	  ToEnd:
     MOV AH,4Ch              ; Set terminate option for int 21h
     INT 21h                 ; Return to DOS (terminate program)
                             ;
     END  ProgStart     ; Set "ProgStart:" as first executable statement







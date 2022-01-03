; 
;
    .MODEL SMALL
    .STACK 100h
    .DATA


	;Var
SUM DD 0    
ARR DW 1234,9999,1111,4444
T   DD 10   ; for div

	;Strings
DisplayString DB 'Last digit in the sum is:X',13,10, '$'
                            
     .CODE
	 ProgStart:
     MOV AX,@DATA
     MOV DS,AX              ; Set DS to point to data segment

	 .386
	 ;DI, pointer to the array.
     MOV DI,OFFSET ARR
	 
	 MOV  CX,4
	 LoopStart:
	 
	 MOV EAX,0
	 MOV AX,[DI] ;EAX=ARR[I]
	 MUL EAX ; EDX:EAX=EAX^2 
	 ADD SUM,EAX ; As we were told we assume that the size of EAX^2 is compatible in 32bit.
	 ADD DI,2

	 LOOP LoopStart

	 MOV EDX,0
	 MOV EAX,SUM 
	 DIV T ; EDX=EDX:EAX % T => EDX= 0:SUM % 10 => EDX= SUM%10// 

	 ADD EDX,'0'
	 MOV DisplayString[25],DL

		;to print the display string
	 MOV AH,9
	 MOV DX,OFFSET DisplayString
	 INT 21h

	  ToEnd:
     MOV AH,4Ch              ; Set terminate option for int 21h
     INT 21h                 ; Return to DOS (terminate program)
                             ;
     END  ProgStart     ; Set "ProgStart:" as first executable statement







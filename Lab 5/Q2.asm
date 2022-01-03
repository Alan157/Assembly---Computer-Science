; 
;
    .MODEL SMALL
    .STACK 100h
    .DATA


	;Var
N   DW 11    
ARR DW 8234h, 8678h, 0ff11h, 8111h, 8222h, 8333h, 8444h, 8555h, 8666h, 8777h, 8888h
T   DW 10
MSigned DW ?
MUnsigned DW ?

	;Strings
DisplayUnSigned DB 13,10, 'Max for Unsigned Array is:XXXXX',13,10, '$' ;28
DisplaySigned DB 13,10,'Max for Signed Array is: XXXXX',13,10, '$' ;26

                            
     .CODE
	 ProgStart:
     MOV AX,@DATA
     MOV DS,AX              ; Set DS to point to data segment

	
	 ;Algorithm to find MAXUNSIGNED

	 ;DI, pointer to the array.
     MOV DI,OFFSET ARR
	 
	 MOV CX, N
	 DEC CX
	 MOV AX,[DI] ;We assume that the first element in the array is the greatest. MAX=AX
	 ADD DI,2
	 MaxUnsigned:
	 CMP AX,[DI]   ;JUMP IF AX>[DI]
	 JA SkipSwap     ;JUMP IF AX>[DI]
	 

	 ;SWAP
	 MOV AX,[DI]
	 SkipSwap:
	 ADD DI,2
	 LOOP Maxunsigned ;Loop for N-1 iterations

	 ;Algorithm to find MAXSIGNED

	 ;DI, pointer to the array.
     MOV DI,OFFSET ARR

	 MOV CX, N
	 DEC CX
	 MOV DX,[DI] ;We assume that the first element in the array is the greatest. MAX=AX
	 ADD DI,2
	 Maxsigned: 
	 
	 CMP DX,[DI]   ;JUMP IF AX>[DI]
	 JG SkipSwapSigned

	 ;SWAP
	 MOV DX,[DI]
	 SkipSwapSigned:
	 ADD DI,2
	 LOOP Maxsigned ;Loop for N-1 iterations
	 
	 ;EXTRACTING MaxUnsigned to 5 diffrent numbers AX IS NOT GREATER THEN 99,999 |
	 
	 MOV MUnsigned,AX;
	 MOV MSigned,DX;
	 
	 ;~~~~~~~~~~~~~~~~~~~For Unsigned~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 MOV AX,Munsigned

	 MOV DX,0
	 DIV T ; AX=DX:AX/10 , DX=DX:AX%10; 
	 MOV DH,0
	 ADD DL,'0'
	 MOV DisplayUnsigned[32],DL
	 
	 MOV DX,0
	 DIV T ; AX=DX:AX/10 , DX=DX:AX%10; 
	 MOV DH,0
	 ADD DL,'0'
	 MOV DisplayUnsigned[31],DL

	 MOV DX,0
	 DIV T ; AX=DX:AX/10 , DX=DX:AX%10; 
	 MOV DH,0
	 ADD DL,'0'
	 MOV DisplayUnsigned[30],DL

	 MOV DX,0
	 DIV T ; AX=DX:AX/10 , DX=DX:AX%10; 
	 MOV DH,0
	 ADD DL,'0'
	 MOV DisplayUnsigned[29],DL

	 MOV DX,0
	 DIV T ; AX=DX:AX/10 , DX=DX:AX%10; 
	 MOV DH,0
	 ADD DL,'0'
	 MOV DisplayUnsigned[28],DL


	  MOV AX,MSigned



	 ;~~~~For POSITIVE/Negative signed~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 MOV AX,MSigned
	 CMP AX,0
	 JG Skip
	 NEG AX
	 MOV DisplaySigned[26],'-'


	 Skip:
	 MOV DX,0
	 IDIV T ; AX=DX:AX/10 , DX=DX:AX%10; 
	 MOV DH,0
	 ADD DL,'0'
	 MOV DisplaySigned[31],DL
	 
	 MOV DX,0
	 IDIV T ; AX=DX:AX/10 , DX=DX:AX%10; 
	 MOV DH,0
	 ADD DL,'0'
	 MOV DisplaySigned[30],DL

	 MOV DX,0
	 IDIV T ; AX=DX:AX/10 , DX=DX:AX%10; 
	 MOV DH,0
	 ADD DL,'0'
	 MOV DisplaySigned[29],DL

	 MOV DX,0
	 IDIV T ; AX=DX:AX/10 , DX=DX:AX%10; 
	 MOV DH,0
	 ADD DL,'0'
	 MOV DisplaySigned[28],DL

	 MOV DX,0
	 IDIV T ; AX=DX:AX/10 , DX=DX:AX%10; 
	 MOV DH,0
	 ADD DL,'0'
	 MOV DisplaySigned[27],DL






		;to print the display strings
	 MOV AH,9
	 MOV DX,OFFSET DisplayUnSigned
	 INT 21h

	 MOV AH,9
	 MOV DX,OFFSET DisplaySigned
	 INT 21h

	  ToEnd:
     MOV AH,4Ch              ; Set terminate option for int 21h
     INT 21h                 ; Return to DOS (terminate program)
                             ;
     END  ProgStart     ; Set "ProgStart:" as first executable statement







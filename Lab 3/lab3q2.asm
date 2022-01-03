; Add1.asm
;
    .MODEL SMALL
    .STACK 100h
    .DATA
		;vars
NUM         DW	?
DIG			DW	?
TEN			DB 10
REM			DW  ?
		;strings
EnterNumber DB 'Please Enter Number (from 00 up to 99):' ,13,10,'$' 
EnterDigit	DB 13,10,'Please Enter Digit (from 0 up to 9):' ,13,10,'$'
RoundDown	DB 13,10,'The result should be round down' ,13,10, '$'
RoundUp		DB 13,10,'The result should be round up' ,13,10, '$'
Equation	DB 13,10,'XX^2 mod X=X',13,10,'$'
Error		DB 13,10,'Division Error' ,13,10,'$'    
                            ;
     .CODE
     MOV AX,@DATA   ; DS can be written to only through a register
     MOV DS,AX      ; Set DS to point to data segment


									;start of the code enter number
     MOV AH,9       
     MOV DX,OFFSET EnterNumber  
     INT 21h                


									;This block receives number between 00 up to 99 from the user.
	 MOV AH,1				
	 INT 21h

	 MOV Equation[2],AL     ;We Insert the char of the first digit to our string equation

	 SUB AL,'0'
	 MOV AH,0
	 MOV NUM,AX
	 MOV AL,TEN
	 MUL NUM
	 MOV NUM,AX

	 MOV AH,1				
	 INT 21h

	 MOV Equation[3],AL		;We Insert the char of the second digit to our string equation

	 SUB AL,'0'
	 MOV AH,0
	 ADD NUM,AX

							
	 MOV AH,9       ; Set print option for int 21h
     MOV DX,OFFSET EnterDigit  ;  Set  DS:DX to point to EnterDigit
     INT 21h                ;  Print EnterDigit

				;This block receives digit between 0 up to 9 from the user.
	 MOV AH,1				
	 INT 21h

	 MOV Equation[11],AL		;We Insert the char of the digit to our string equation

	 SUB AL,'0'
	 MOV AH,0
	 MOV DIG,AX
	 
				;Check if digit is zero to prevent division by 0.	
	 			
	 CMP DIG,0
	 JE	 ErrorZero

		
				;CALC NUM^2/DIG (IF DIG NOT 0)
	 MOV AX,NUM 
	 MUL NUM	;DX:AX=AX(NUM)*NUM
	 DIV DIG	; NOW DX=NUM^2%DIG


	 MOV REM,DX
	 ADD DX,'0'
	 MOV Equation[13],DL		;We Insert the remainder of the equation


			   ;Print the equation string
     MOV AH,9       ; Set print option for int 21h
     MOV DX,OFFSET Equation  ;  Set  DS:DX to point to Equation
     INT 21h                ;  Print Equation


				;COMPARE THE REMINDER

	 MOV AX,REM  ;Its like AH*2
	 ADD AX,AX
				;If Reminder needed to be round up
	 CMP AX,DIG
	 JAE UP		;If Reminder needed to be round up
	 JL DOWN    ;If Reminder needed to be round down   ;JNB TO CHECK
	 
			
	

UP:	       ;ErrorZero label if the digit that was received is zero.
	 MOV AH,9
	 MOV DX,OFFSET RoundUp
	 int 21h
	 JMP ToEnd

DOWN:      ;ErrorZero label if the digit that was received is zero.
	 MOV AH,9
	 MOV DX,OFFSET RoundDown
	 int 21h
	 JMP ToEnd

ErrorZero: ;ErrorZero label if the digit that was received is zero.
	 MOV AH,9
	 MOV DX,OFFSET Error
	 int 21h


							;END
ToEnd:
     MOV AH,4Ch       ; Set terminate option for int 21h
     INT 21h       ; Return to DOS (terminate program)
     END  
  


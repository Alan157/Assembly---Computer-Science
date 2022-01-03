;
; Lab2q2.asm - Conditional response.
;
    .MODEL SMALL
    .STACK 100h
    .DATA
AskForGrade 	DB 13,10
				DB 'Please enter your garde:',13,10,'$'

GradeAmessage 	DB 13,10
				DB 'Very good',13,10,'$'	 

GradeBmessage  	DB 13,10
				DB 'Good',13,10,'$'	 

GradeCmessage 	DB 13,10 
				DB 'Not Good',13,10,'$'	 

GradeFmessage  	DB 13,10
				DB 'Very Bad. You Failed',13,10,'$'	 

ErrorMessage  	DB 13,10
				DB 'input Error!!!',10,13,'$'


                            ;
                            ;
     .CODE
ProgStart:
     MOV AX,@DATA             ; DS can be written to only through a register
     MOV DS,AX                ; Set DS to point to data segment
     MOV AH,9                 ; Set print option for int 21h
     MOV DX,OFFSET AskForGrade  ;  Ask for grade
     INT 21h                   ;  Print AskForGrade
     MOV AH,1                  ; DOS get character function #
     INT 21h                   ; Get a single character from keyboard
	 ;
	 CMP AL,'A'
	 JE  GradeA
	 CMP AL,'B'
	 JE  GradeB
     CMP AL,'C'      
	 JE  GradeC
	 CMP AL,'F'
	 JE  GradeF
	 
 Error:
     MOV DX,OFFSET ErrorMessage	 
	 JMP  DisplayGreeting 
	 
 GradeA:
     MOV DX,OFFSET GradeAmessage ;point display message for GradeA	 
	 JMP  DisplayGreeting 	 
	 
 GradeB:
     MOV DX,OFFSET GradeBmessage ;point display message for GradeB	 
	 JMP  DisplayGreeting 	
	  
 GradeC:
     MOV DX,OFFSET GradeCmessage ;point display message for GradeC	 
	 JMP  DisplayGreeting 	 
	 
 GradeF:
     MOV DX,OFFSET GradeFmessage ;point display message for GradeF
	 JMP  DisplayGreeting 	 	 
	 
DisplayGreeting:
     MOV AH,9                         ; Set print option for int 21h
     INT 21h                          ; Print  chosen message
     MOV AH,4Ch               ; Set terminate option for int 21h
     INT 21h                  ; Return to DOS (terminate program)
    END ProgStart
  
  
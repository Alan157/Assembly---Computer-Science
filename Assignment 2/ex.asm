;
;Hw2
;
    
    .MODEL SMALL
	.386
    .STACK 100h
    .DATA
	 
	;Var

m    DD 0   
rem  DD 0   
x    DD 0   
y    DD 0   
p    DD 0   
c    DD 0  
rpos DW 0 
spos DW 0
counter DB 0
TWO   DB 2
TDW   DW 10
TDD   DD 10
TTDD  DD 100
TWDD  DD 20
N DD 0


	;Strings
DisplayString DB 'Enter number N for sqrt (up to 12 digits):',13,10,'$'
Source DB 13 DUP(?), '$'
SaveSource DB 13 DUP(?), '$'
Result DB 13 DUP(?),13,10,'$' 
SqrtString DB 13,10,'Sqrt(','$' 


      .CODE
	  Start:
     MOV AX,@DATA
     MOV DS,AX             

	 
	 MOV AH,9
	 MOV DX,OFFSET DisplayString ;print display string
	 INT 21h

	;Get a string of numbers from the user
	 MOV DI,OFFSET SaveSource
	 MOV CX,12 ;(MAX DIGITS)
	 StartOfNum:
	 MOV AH,1
	 INT 21h

	 CMP AL,13
	 JE EndOfNum

	 MOV [DI],AL
	 INC DI
	 INC Counter ;Counter++
	
	 LOOP StartOfNum
	 EndOfNum:

	 ;check if the number is odd or even
	 XOR AX,AX
	 MOV AL,Counter 
	 DIV TWO ; AH=AX%2
	 CMP AH,0
	 JE CounterIsEven ;if counter%2==0 the number of digit is even



	 ;We have ODD number of digits in the original string
	 MOV DI,OFFSET SaveSource
	 MOV SI,OFFSET Source
	 XOR CX,CX
	 MOV CL,Counter
	 MOV AL,'0'
	 MOV [SI],AL
	 INC SI
	 CopyOdd:
	 MOV AL,[DI]
	 MOV [SI],AL
	 INC DI
	 INC SI 
	 Loop CopyOdd
	 JMP AddNull

	 ;We have EVEN number of digits in the original string
	 CounterIsEven:
	 MOV DI,OFFSET SaveSource
	 MOV SI,OFFSET Source
	 XOR CX,CX
	 MOV CL,Counter
	 CopyEven:
	 MOV AL,[DI]
	 MOV [SI],AL
	 INC DI
	 INC SI 
	 Loop CopyEven
	 

	 AddNull:
	 MOV AL,0
	 MOV [SI],AL

	 Calc:
	 ;check
	 XOR EAX,EAX
	 MOV SI,Spos  ;SI=SPOS
	 MOV AL,Source[SI]
	 CMP AL,0 ;CMP x?null
	 JE EndOfCalc     ;if Source[SI] exit the loop

	 ;1
	XOR EAX,EAX 
	MOV AL,Source[SI] ;AX=''
	SUB AL,'0' ;AX-48
	MUL TDW ;DX:AX=AX*10
	MOV N,EAX; 
	XOR EAX,EAX 
	MOV AL,Source[SI+1] ;AX=''
	SUB AL,'0' ;AX-48
	ADD EAX,N
	MOV m,EAX 

   ;2
	XOR EAX,EAX 
	XOR EDX,EDX
	MOV EAX,rem
	MUL TTDD ;EDX:EAX=rem*100
	ADD EAX,m
	MOV c,EAX ;c=rem*100+m


	;3
	MOV x,0
	MOV y,0

	;Whi(y<c)
	Whi:
	XOR EAX,EAX
	MOV EAX,c

	CMP EAX,y     ;while (c>y)
	JBE SkipWhi      ;y>c || y==c we jump
	
	INC x   ;x++
	XOR EAX,EAX
	XOR EDX,EDX
	MOV EAX,p
	MUL TWDD ;EDX:EAX=20*p
	ADD EAX,x
	MUL x ; EDX:EAX=x*EAX(20*p+x)
	MOV y,EAX ;y=EAX
	JMP Whi

	SkipWhi:

	;if(y>c)
	XOR EAX,EAX
	MOV EAX,c
	CMP EAX,y 
	JAE SkipIf 
	
	DEC x ;x--
	XOR EAX,EAX
	XOR EDX,EDX
	MOV EAX,p
	MUL TWDD ;EDX:EAX=20*p
	ADD EAX,x
	MUL x ; EDX:EAX=x*EAX(20*p+x)
	MOV y,EAX ;y=EAX

	SkipIf:

	;4
	XOR SI,SI
	MOV SI,rpos 
	XOR EAX,EAX
	MOV EAX,x
    ADD EAX,'0'
	MOV Result[SI],AL 
	
	;5
	ADD spos,2 ;spos+2
	INC rpos   ;rpos +1

	;rem=c-y
    XOR EAX,EAX
	MOV EAX,c ;EAX=C
	SUB EAX,y ; EAX=C-Y
	MOV rem,EAX ;rem
	;p=10*p+x 
	XOR EAX,EAX
	XOR EDX,EDX
	MOV EAX,p
	MUL TDD ;EDX:EAX=EAX*10=P*10
	ADD EAX,x ;EAX=p*10+x
	MOV p,EAX 

	JMP Calc ;Countinue the loop of while source[spos]!=NULL

	EndOfCalc:

	 MOV AH,9
	 MOV DX,OFFSET SqrtString ;print display string
	 INT 21h

	 MOV SI,0
	 PrintSaveSourceLoop:
	 CMP SaveSource[SI],0
	 JE EndOfPrint
	 MOV AH,2
	 MOV DL,SaveSource[SI]
	 INT 21h
	 INC SI;
     JMP PrintSaveSourceLoop

	 EndOfPrint:

	 MOV AH,2
	 MOV DL,')'
	 INT 21h

	 MOV AH,2
	 MOV DL,'='
	 INT 21h


     MOV AH,9
	 MOV DX,OFFSET Result ;print display string
	 INT 21h


	 
     MOV AH,4Ch              ; Set terminate option for int 21h
     INT 21h                 ; Return to DOS (terminate program)
                             ;
     END Start     ; Set "Start:" as first executable statement
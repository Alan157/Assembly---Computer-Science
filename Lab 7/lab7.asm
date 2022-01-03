;
;  lab7 ori and alan
;
    	.MODEL SMALL
    	.STACK 100h
    	.DATA
	    
		;Vars
		Stack_Size      DW (?)
		Counter         DW  0
	    Num1			DD (?)
		Num2			DD (?)
		Sum1			DD (?)
		Sum2			DD (?)
		Ten             DD 10
		;Strings
	Menu   DB 'Please enter two numbers (1-4,294,967,295)',13,10,'$'
	Amicable DB 13,10,'Amicable Numbers',13,10,'$'
    NotAmicable DB 13,10,'Not Amicable Numbers',13,10,'$'
	.CODE
    .386


	
     


;------- getNum ---------------------------------------------
	getNum  PROC  NEAR
	    ;We Store num ESI
		PUSH ESI
	
		XOR	    ESI,ESI
		MOV     CX,11
		Build:
		XOR		EAX,EAX
     	MOV 	AH,1            
     	INT 	21h
		CMP     AL,13
		JE      EndBuild

		XOR EBX,EBX
		MOV  BL,AL
		SUB  BL,'0'

		;NUM*10 +input
		MOV EAX,ESI
		MUL TEN ;EDX:EAX=NUM*10
		MOV ESI,EAX

		ADD ESI,EBX ;ESI=NUM 
		Loop	Build

		EndBuild:
	   
		MOV AX,SI
		SHR ESI,16
		MOV DX,SI

		POP ESI
		 
               RET
       getNum  ENDP
;-------End getNum ----------------------------------------------

;------ PNum ---------------------------------------------------
	Pnum  PROC  NEAR
	;Sum will be saved in EBX
	;X will be saved in ESI
	
    		;POP EAX  ;EAX=X
			PUSH ESI ;We save ESI
			MOV ESI,EAX 

			XOR EBX,EBX
			ADD EBX,1 
			CMP ESI,1
			JE  EndAlgo
			MOV ECX,2
			

			StartAlgo:
			CMP ESI,ECX
			JE EndAlgo

			MOV EDX,0
			MOV EAX,ESI 
			DIV ECX ;EDX=EDX:EAX%ECX
			CMP EDX,0
			JNE NotDivider
			ADD EBX,ECX

			NotDivider:
			INC ECX
			JMP StartAlgo

			EndAlgo:


			;MOV AX,WORD PTR [EBX]
			;MOV DX,WORD PTR [EBX+2] 
			SumIs1:

			MOV AX,BX
		    SHR EBX,16
		    MOV DX,BX

			POP ESI

     		RET
	Pnum ENDP
;-------End PNum -----------------------------------------------
Main:
     	MOV AX,@DATA
		MOV DS,AX

		MOV AH,9
		MOV DX,OFFSET Menu
		INT 21H

		;input First number
		CALL getNum
		MOV Word Ptr Num1,DX
		SHL Num1,16
		XOR EBX,EBX
		MOV BX,AX
		ADD Num1,EBX
		
		

		;input Second Number
	    CALL getNum
		MOV Word Ptr Num2,DX
		SHL Num2,16
		XOR EBX,EBX
		MOV BX,AX
		ADD Num2,EBX
	

		;First sum
		XOR EAX,EAX 
		MOV EAX,Num1
		CALL Pnum
		MOV Word Ptr Sum1,DX
		SHL Sum1,16
		XOR EBX,EBX
		MOV BX,AX
		ADD Sum1,EBX
	


		;Check sum1 with num2 
		MOV EAX,Sum1
		CMP EAX,Num2
		JNE NotAm


		;First sum
		XOR EAX,EAX 
		MOV EAX,Num2
		CALL Pnum
		MOV Word Ptr Sum2,DX
		SHL Sum2,16
		XOR EBX,EBX
		MOV BX,AX
		ADD Sum2,EBX


		;Check sum2 with num1
		MOV EAX,Sum2
		CMP EAX,Num1
		JNE NotAm


		MOV AH,9
		MOV DX,OFFSET Amicable
		INT 21H
		JMP toEnd

	
		NotAm:
		MOV AH,9
		MOV DX,OFFSET NotAmicable
		INT 21H
		

        toEnd:
      	MOV 	AH,4Ch          ; Set terminate option for int 21h
     	INT 	21h             ; Return to DOS (terminate program)
	END		Main
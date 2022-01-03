;
;  lab11 ori and alan
; double  avg_pows (double arr[], int size);
   	.MODEL SMALL
    .STACK 100h
    .DATA
	    
	 SUM      DQ 0 ;We return double
     TMP      DQ 0 ; 
	.CODE
    _avg_pows PROC NEAR
	PUBLIC _avg_pows
	
	
	;save values 
	PUSH BP
	PUSH SI
	MOV BP,SP 

	; double arr[]=[BP+6]
	; int n = [BP+8]


	MOV SI,[BP+6]
	MOV CX,[BP+8] ;size of array.

	RunOnArray:
	FLD QWORD ptr[SI]  ; ST[0]=arr[i]
	FLD QWORD ptr[SI] ; ST[1]=arr[i]
	FMUL  ; ST[1] =ST[1]*ST[0]=arr[i]*arr[i] ->// pop the stack so ST[0] is our our "powed" arr[i]
	FLD SUM
	FADD ; ST[0]=SUM+ST[1] ->the next arr[i]^2 that we want to add
	FSTP SUM
	ADD SI,8
	LOOP RunOnArray

	FLD SUM ; We want to return in ST[0] our sum
	FIDIV WORD PTR[BP+8] ; ST[0] = SUM/size. doesnt pop the stack so we return.


	POP SI
	POP BP
	RET
_avg_pows ENDP
END


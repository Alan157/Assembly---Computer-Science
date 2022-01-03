;
;  HW4 - ori and alan


	


    .MODEL SMALL
    .STACK 100h
    .DATA
	  ;vars
	 x_i1 DQ 0 ;to save the original X_i in single
	 x_i2 DQ 0 ;to save the original X_i in approx
	 plush DQ 0 ;save the p+h function return
	 minush DQ 0 ; save the p-h function return
	 num    DQ 104576.0
	 temph  DQ 0
	 fd1    DQ 0
	 fd2    DQ 0
	 two    DQ 2.0
	 tempi  DQ 1.23456789
	.CODE
	.386
	.387

	;extern double single_partial_derivative(double (*obj_f)(double x[]),int i, double x[], double h);
	PUBLIC _single_partial_derivative
    _single_partial_derivative PROC NEAR

	;[BP+6] -> double (*obj_f)(double x[]) -> 2bytes
	;[BP+8] -> int i -> 2bytes
	;[BP+10] -> double x[] -> 2bytes 
	;[BP+12] -> double h ->8bytes 
    
	
	;save values 
    PUSH BP
	PUSH DI
	MOV BP,SP

	;Loop to save the original x_i and also to edit him
	XOR CX,CX
	MOV DI,[BP+10]

	FindX_i1:
	CMP CX,[BP+8]
	JE WeFoundX_i1
	INC CX
	ADD DI,8
	JMP FindX_i1

	WeFoundX_i1:
	FLD QWORD PTR [DI] ; DI is the pointer to X_i ,ST[0]=X_i
	FST QWORD PTR x_i1 ;x_i= ST[0] with out popping the stack 
	FLD QWORD PTR [BP+12] ;ST[0]=h, ST[1]=x_i
	FADD  ;ST[1]=x_i+h +POP ->ST[0]=x_i+h
	FSTP QWORD PTR [DI] ;Now the x_i in the array is x_i+h 

    PUSH WORD PTR [BP+10]
	CALL [BP+6] ;we called the function with the x_i+h array adress 
	FSTP QWORD PTR plush  ;the returned value is double in st[0] we store it and pop to plush (plus h)
	POP WORD PTR [BP+10]

	
	FLD QWORD PTR x_i1 ;ST[0]=X_i
	FSUB QWORD PTR [BP+12] ;ST[0]=x_i-h
	FSTP QWORD PTR [DI]
	PUSH WORD PTR [BP+10]
	CALL [BP+6]
	FSTP QWORD PTR minush
	POP WORD PTR [BP+10]
	;We want to save the original array
	FLD QWORD PTR x_i1 
	FSTP QWORD PTR [DI]

	FLD QWORD PTR plush ;ST[0]= plush
	FSUB QWORD PTR minush ; ST[0]=plush-minush
	FLD QWORD PTR [BP+12] ;ST[0] =h , ST[1]=plush-minush
    FADD QWORD PTR [BP+12] ;ST[0]=2h
	FDIV  ; ST[1]=ST[1]/ST[0] + POP ->ST[0]=plush-minush/2h
	
	POP DI
	POP BP
	RET
 _single_partial_derivative ENDP


 ;extern double approx_partial_derivative(double (*obj_f)(double x[]),int i, double x[]);	

 PUBLIC _approx_partial_derivative
    _approx_partial_derivative PROC NEAR

	;[BP+6] -> double (*obj_f)(double x[]) -> 2bytes
	;[BP+8] -> int i -> 2bytes
	;[BP+10] -> double x[] -> 2bytes 
    
	
	;save values 
    PUSH BP
	PUSH DI
	MOV BP,SP

	;Loop to save the original x_i and also to edit him
	XOR CX,CX
	MOV DI,[BP+10]

	FindX_i2:
	CMP CX,[BP+8]
	JE WeFoundX_i2
	INC CX
	ADD DI,8
	JMP FindX_i2

	WeFoundX_i2:
	FLD QWORD PTR [DI] ; DI is the pointer to X_i ,ST[0]=X_i
	FST QWORD PTR x_i2 ;x_i= ST[0] with out popping the stack 
	FDIV QWORD PTR num ; ST[0]= x_i/num
	FABS ;|ST[0]|=ST[0]
	FSTP temph ;We have not the defined starting h

	PUSH QWORD PTR temph
	PUSH WORD PTR [BP+10]
	PUSH WORD PTR [BP+8]
	PUSH WORD PTR [BP+6]

	CALL _single_partial_derivative
	FSTP fd2 

	POP WORD PTR [BP+6]
	POP WORD PTR [BP+8]
	POP WORD PTR [BP+10]
	POP QWORD PTR temph

	;2

	approx:
	;a
    FLD QWORD PTR fd2
	FSTP QWORD PTR fd1 ; fd1=fd2

	;b
	FLD QWORD PTR temph
	FDIV two ;ST[0]=h/2.0
	FSTP QWORD PTR temph ; h=h/2.0

	;c

	PUSH QWORD PTR temph
	PUSH WORD PTR [BP+10]
	PUSH WORD PTR [BP+8]
	PUSH WORD PTR [BP+6]

	CALL _single_partial_derivative
	FSTP fd2 

	POP WORD PTR [BP+6]
	POP WORD PTR [BP+8]
	POP WORD PTR [BP+10]
	POP QWORD PTR temph

	;d
	FLD QWORD PTR fd1
	FDIV num ;ST[0]=fd1/104576.0
	FABS   ;ST[0]=|fd1/104576.0|

	FLD QWORD PTR fd1 
	FLD QWORD PTR fd2

    ;ST[2]=|fd1/104576.0| 
	;ST[1]=fd1
	;ST[0]=fd2

	FSUB 
	;ST[1]=ST[1]-ST[0] + POP -> 
	;ST[0]=fd1-fd2 
	FABS 

	;ST[0]=|fd1-fd2|
	;ST[1]=|fd1/104576.0| 

	FCOM ;Set flags for ST[0]-ST[1]
	;We want that ST[0]-ST[1]<0 

	FSTSW AX
	SAHF

	JB approxend
	JMP approx
	
	approxend:
	FLD QWORD PTR fd2


	POP DI
	POP BP
	RET
 _approx_partial_derivative ENDP

END


;
;  lab9 ori and alan
;extern void sum_col(int n, int m, long int *matrix[], long int new_col[]); 
; mat NxM

    .MODEL LARGE
    .STACK 100h
    .DATA
	    
	 Nsize      DW (0)
	 Msize		DW (0)

	.CODE
	.386
	PUBLIC _sum_col
    _sum_col PROC FAR

	
	
	;save values 
    PUSH BP
	PUSH DI
	PUSH SI
	PUSH ES
    PUSH GS
	PUSH FS
	MOV BP,SP
;now we can address the values the were sent.
	
;BP+16 =n
;BP+18 =m
;BP+20 =Mat offset     -DI                  
;BP+22 =Mat seg        -GS 
; MAT GS:DI
;BP+24 =New_col offset ->SI
;BP+26 =New_col seg -> ES
; New_COl ES:SI
;Algorithem is: new_col[i]=E(j=0~n-1)mat[j][i] , 0<=j<=n-1 , 0<=i<=m-1
	
    MOV AX,[BP+18]
	MOV Msize,AX

	MOV AX,[BP+16]
	MOV Nsize,AX

 ;Initliaze NEW_COL
	MOV CX,Msize ;CX=m
    MOV SI,[BP+24] ;Offset
	MOV ES,[BP+26] ;Seg
	ZeroMe:
	MOV Dword PTR ES:[SI],0
	ADD SI,4
	LOOP ZeroMe

 ;Start Sum each row
 ;Exter Loop running on the rows 
 
 MOV CX,Nsize
 MOV DI,[BP+20] ;offset to matrix
 MOV GS,[BP+22] ;segment to the matrix


 RunOnMat:
 MOV DX,0
 MOV BX,[BP+24] ;Offset to new_col and the segment stays at ES
 MOV ES,[BP+26] ;Seg

MOV SI,GS:[DI]	;OFFSET TO n ROW OF METRIX
MOV FS,GS:[DI+2];SEG OF THE ROW

 RunOnRow:
 CMP DX,Msize
 JE  NewRow
 MOV EAX,FS:[SI]
 ADD ES:[BX],EAX
 ADD SI,4 
 ADD BX,4 
 INC DX
 JMP RunOnRow

 NewRow:
 ADD DI,4
 LOOP RunOnMat

    POP FS
	POP GS
	POP ES 
	POP SI
	POP DI
	POP BP 

	RET
_sum_col ENDP
END


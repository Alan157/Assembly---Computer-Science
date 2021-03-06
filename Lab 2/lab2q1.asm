;
; hello4.asm - Conditional response.
;
    .MODEL SMALL
    .STACK 100h
    .DATA
TimePrompt DB 'Is it 12 after noon (y/n)?',13,10,':$'
GoodAfternoonMessage DB 13,10
         DB 'Good afternoon, world!',13,10,'$'
GoodMorningMessage DB 13,10
         DB 'Good morning, world!',13,10,'$'
		 ErrorMassage DB,13,10
		 DB 'Input Error',13,10,'$'
                            ;
                            ;
     .CODE
ProgStart:
     MOV AX,@DATA              ; DS can be written to only through a register
     MOV DS,AX                 ; Set DS to point to data segment
     MOV AH,9                  ; Set print option for int 21h
     MOV DX,OFFSET TimePrompt  ;  Set  DS:DX to point to TimePrompt
     INT 21h                   ;  Print TimePrompt
     MOV AH,1                  ; DOS get character function #
     INT 21h                   ; Get a single character from keyboard
     CMP AL,'y'                ; AL has input. Compare with 'y'
     JE  IsAfternoon           ; If AL = 'y' then go to IsAfternoon
     CMP AL,'Y'                ; Compare with 'Y'
     JE  IsAfternoon           ; If AL = 'Y' then go to IsAfternoon
	 CMP AL,'n'                ; AL has input. Compare with 'n'
     JE  IsMorning             ; If AL = 'n' then go to IsMorning
     CMP AL,'N'                ; Compare with 'N'
     JE  IsMorning             ; If AL = 'N' then go to IsMorning

ErrorMassageLabel:
	 MOV DX, OFFSET ErrorMassage		; print error message
	 JMP DisplayGreeting
IsMorning:
     MOV  DX,OFFSET GoodMorningMessage  ; Point display message to morning
     JMP  DisplayGreeting               ; Avoid following code
IsAfternoon:
     MOV  DX,OFFSET GoodAfternoonMessage ; Point display message to afternoon
DisplayGreeting:
     MOV AH,9                         ; Set print option for int 21h
     INT 21h                          ; Print  chosen message
     MOV AH,4Ch               ; Set terminate option for int 21h
     INT 21h                  ; Return to DOS (terminate program)
    END ProgStart
  
  

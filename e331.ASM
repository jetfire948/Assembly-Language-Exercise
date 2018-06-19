ASSUME  CS:CODE,DS:DATA,SS:STACK
DATA    SEGMENT
        ARRAY1 DW 100 DUP(0)
        ARRAY2 DW 100 DUP(0)
DATA    ENDS
STACK   SEGMENT
        DW 100 DUP(0)
STACK   ENDS
CODE    SEGMENT
MAIN    PROC FAR
        MOV AX,DATA
        MOV DS,AX
        MOV AX,STACK
        MOV SS,AX
        MOV SP,200 
        CALL SUB8
        CALL SUB9 
        CALL SUB10     
        CALL SUB11
        MOV AH,0
        INT 16H
MAIN    ENDP
SUB8    PROC NEAR
        PUSH AX
        PUSH BX
        PUSH DX
        LEA DI,ARRAY1
        XOR CX,CX
AA2:    MOV AH,1
        INT 21H
        CMP AL,30H
        JC AA5
        CMP AL,3AH    
        JNC AA1
        ADD CX,CX        
        MOV BX,CX
        ADD CX,CX
        ADD CX,CX
        ADD CX,BX
        AND AX,0FH
        ADD CX,AX
        JMP AA2
AA3:    MOV [DI],CX
        INC DI
        INC DI
        MOV CX,0            
AA4:    MOV AH,0FFH         
        MOV [DI],AX
        INC DI
        INC DI
        JMP AA2
AA5:    CMP CX,0              
        JZ AA4
        JMP AA3
AA6:    MOV [DI],CX
        INC DI
        INC DI
        MOV CX,0            
AA1:    CMP CX,0           
        JNZ AA6
        MOV AH,0FFH
        MOV [DI],AX
        POP DX
        POP BX
        POP AX
        RET                 
SUB8    ENDP
SUB9    PROC NEAR               
        SUB CX,CX
        PUSH AX
        PUSH BX
        PUSH DX
        MOV AX,'='
        MOV AH,0FFH
        PUSH AX
        INC CX
        LEA DI,ARRAY1
        LEA SI,ARRAY2    
BB1:    MOV AX,[DI]
        INC DI
        INC DI
        CMP AH,0FFH
        JNC BB2
        MOV [SI],AX
        INC SI
        INC SI
BB3:    JMP BB1 
BB2:    CMP AL,'('
        JZ BB4         
        CMP AL,')'      
        JZ BB5               
        CMP AL,'='         
        JZ BB6
BB11:   MOV BP,SP
        CMP AL,'+'
        JZ BB7  
        CMP AL,'-'
        JZ BB7
        CMP AL,'*'
        JZ BB9
        CMP AL,'/'
        JZ BB9
BB4:    PUSH AX
        INC CX
        JMP BB1
BB5:    POP AX
        DEC CX
        CMP AL,'('
        JZ BB1
        MOV [SI],AX
        INC SI
        INC SI
        JMP BB5
BB7:    CMP BYTE PTR [BP],'+'
        JZ BB12
BB8:    CMP BYTE PTR [BP],'-'
        JZ BB12
BB9:    CMP BYTE PTR [BP],'*'
        JZ BB12
BB10:   CMP BYTE PTR [BP],'/'
        JZ BB12
        JMP BB4    
BB12:   POP BX
        DEC CX
        MOV [SI],BX
        INC SI
        INC SI
        JMP BB11 
BB6:    POP AX
        MOV [SI],AX
        INC SI
        INC SI
        LOOP BB6
        POP DX
        POP BX
        POP AX
        RET
SUB9    ENDP
SUB10   PROC NEAR
        PUSH AX
        PUSH BX
        PUSH DX    
        LEA SI,ARRAY2
PP1:    MOV AX,[SI]
        INC SI
        INC SI
        CMP AH,0FFH
        JZ PP2
        PUSH AX
        JMP PP1 
PP2:    CMP AL,'='
        JZ PP7
        POP BX
        POP DX
        CMP AL,'+'
        JZ PP3
        CMP AL,'-'
        JZ PP4
        CMP AL,'*'
        JZ PP5
        CMP AL,'/'
        JZ PP6 
PP3:    ADD DX,BX
        PUSH DX
        JMP PP1
PP4:    SUB DX,BX
        PUSH DX 
        JMP PP1
PP5:    MOV AX,DX
        MUL BX
        PUSH AX
        JMP PP1          
PP6:    MOV AX,DX
        MOV DX,0
        DIV BX
        PUSH AX
        JMP PP1 
PP7:    POP CX          
        POP DX
        POP BX
        POP AX
        RET                  
SUB10   ENDP
SUB11   PROC NEAR           
        PUSH AX
        PUSH BX
        PUSH DX
        CMP CX,10000
        JNC A12
        CMP CX,1000
        JNC A4
        CMP CX,100
        JNC A6
        CMP CX,10
        JNC A8
        JMP A10
A12:    MOV DL,-1
A3:     SUB CX,10000
        INC DL
        JNC A3
        ADD CX,10000
        OR DL,30H
        MOV AH,2
        INT 21H
A4:     MOV DL,-1
A5:     SUB CX,1000
        INC DL
        JNC A5
        ADD CX,1000
        OR DL,30H
        MOV AH,2
        INT 21H
A6:     MOV DL,-1
A7:     SUB CX,100
        INC DL
        JNC A7
        ADD CX,100
        OR DL,30H
        MOV AH,2
        INT 21H
A8:     MOV DL,-1
A9:     SUB CX,10
        INC DL
        JNC A9
        ADD CX,10
        OR DL,30H
        MOV AH,2
        INT 21H
A10:    MOV DL,CL
        OR DL,30H
        MOV AH,2
        INT 21H
        POP DX
        POP BX
        POP AX
        RET        
SUB11   ENDP
CODE    ENDS
END     MAIN
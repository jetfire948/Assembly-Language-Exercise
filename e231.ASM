DATAS SEGMENT
STR     DB 'PLEASE INPUT A STRING:$'  
BUF     DB 20        
        DB 0       
        DB 20 DUP (0)              
CRLF    DB 0AH,0DH,"$"
CHARSTR DB 'INPUT A CHAR: $'
CHAR    DB 0
DATAS   ENDS
CODES   SEGMENT
ASSUME  CS:CODES,DS:DATAS
START:  MOV AX,DATAS
        MOV DS,AX
        LEA DX,STR    
        MOV AH,9
        INT 21H
        MOV AH,10
        LEA DX,BUF
        INT 21H
        LEA DX,CRLF
        MOV AH,9
        INT 21H
        LEA DX,CHARSTR
        MOV AH,9
        INT 21H
        LEA DX,CHAR
        MOV AH,1
        INT 21H
        MOV CHAR,AL
        LEA DX,CRLF
        MOV AH,9
        INT 21H
        MOV CL,BUF+1  
        LEA SI,BUF+2  
NEXT:   MOV DL,[SI]
        CMP DL,CHAR
        JZ SHOW1
        MOV CH,3
        MOV BX,-1
        JZ SHOW
        INC SI 
        DEC CL 
        JNZ NEXT
        MOV AH,4cH
        INT 21H
SHOW1:  CMP CL,BUF+1
        JZ  HEAD
        CMP CL,1
        JZ  TAIL
MID:    MOV CH,3
        MOV BX,-1
        JMP SHOW
HEAD:   MOV CH,2
        MOV BX,0
        JMP SHOW
TAIL:   MOV CH,2
        MOV BX,-1
        JMP SHOW
SHOW:   MOV AH,2
        MOV DL,[SI+BX]
        INT 21H
        INC BX
        DEC CH
        JNZ SHOW
        MOV AH,4CH
        INT 21H
CODES   ENDS
        END START
;PROGRAMA PARA MULTIPLICAR DOS NUMEROS DE DOS DIGITOS


        .MODEL  SMALL

        .CODE
        ORG     0000    ;ASEGURAR DESPLAZAMIENTO 0000 PARA EL CS
        JMP     MAIN

;Definiendo datos
SEG_DAT:
        MOV     AX,@DATA
        MOV     DS,AX     ;registro de segmento de datos
        RET


;Mostrar mensaje
VIS_MENSAJE:
        MOV     AH,09H     ;mostrar el mensaje
        INT     21H
        RET

;Ingresar el numero
INGRESO:
        MOV     AH,01H       ;entrada de caracter con salida
        INT     21H
        RET
  
  
 
  
;Funcion para obtener digito

INGRESODIG:
	XOR	BX,BX
	MOV	AH,01H
	INT	21H 
	CMP AL, 30H           ;se compara si los numeros ingresados a operar
	JB  VERIFICAR         ;esta entre 0 y 9
	CMP AL, 39H
	JA  VERIFICAR             
	             
	  AND	AL,0FH
	
	ADD	BL,AL
	
	RET

;funcion para salir
SALIR:  MOV     AH,4CH
        INT     21H
	RET

;funcion para verificar si es ascii
BINASCII:       
	LEA     SI,ASCVAL        ;puntero de indice
        MOV     CX,5
        MOV     AL,00H
C10:    MOV     [SI],AL
        INC     SI            ;incrementa el puntero
        LOOP    C10
        MOV     CX,10
        LEA     SI,ASCVAL+4
        MOV     AX,BINVAL
C20:    CMP     AX,CX
        JB      C30
        XOR     DX,DX
        DIV     CX
        OR      DL,30H
        MOV     [SI],DL
        DEC     SI
        JMP     C20
C30:    OR      AL,30H
        MOV     [SI],AL
        RET                    
   
;Funciones de operaciones

;multiplicacion
MULTIPLI:
    
    XOR AX,AX
    MOV AH,0
	MOV	AL,N1
    MUL N2
    
    	MOV	    BINVAL,AX
	CALL	BINASCII 

	MOV	DX,OFFSET MRES
	CALL    VIS_MENSAJE
	MOV	DX,OFFSET ASCVAL
	CALL    VIS_MENSAJE
	CALL MET_MENU 
	
	
	
	
;suma
SUM: 
	 XOR AX,AX        ;limpia el registro
	 MOV AL,N1
	 ADD AL,N2
	 MOV SUMA, AL
	 
	 MOV	    BINVAL,AX
	CALL	BINASCII
	
	
	MOV	DX,OFFSET MRES2
	CALL    VIS_MENSAJE
	MOV	DX,OFFSET ASCVAL
	CALL    VIS_MENSAJE  
	CALL MET_MENU
	 
	
;resta
RESTT:   
	
	
	
	 XOR AX,AX         
	 MOV  AL, N1
  
       
        SUB  AL,N2
        MOV  RESTA,AL
       
       
    MOV	    BINVAL,AX
	CALL	BINASCII
	
	
	MOV	DX,OFFSET MRES3
	CALL    VIS_MENSAJE
	MOV	DX,OFFSET ASCVAL
	CALL    VIS_MENSAJE  
	CALL MET_MENU
	   
	
;division
DIVISIN:   
    
     XOR AX,AX        
        
     MOV BL,N2
     MOV AL,N1
     DIV BL
     MOV DIVISN,AL   
         
         
    MOV	    BINVAL,AX
	CALL	BINASCII
	
	
	MOV	DX,OFFSET MRES4
	CALL    VIS_MENSAJE
	MOV	DX,OFFSET ASCVAL
	CALL    VIS_MENSAJE
	CALL MET_MENU    
   
   
   
   
;programa inicial
MAIN:   CALL    SEG_DAT ;Se llama el segmento de datos

    
 
   
	
CICLOING:			;se muestran las instrucciones del programa
    MOV     DX,OFFSET MMEN 
	CALL    VIS_MENSAJE   
 
VERIFICAR: CALL MULTI 		

MULTI:                  ;ciclo que se repite hasta salir
  
    MOV     DX,OFFSET MN1	;Se ingresa el primer numero
	CALL    VIS_MENSAJE
    CALL    INGRESODIG                                           
                                              
    
	MOV	N1,BL		;Se ingresa el segundo numero

    MOV	DX,OFFSET MN2
	CALL    VIS_MENSAJE
    CALL    INGRESODIG
   
        
	MOV	N2,BL            
	
	CALL MET_MENU
;*********************

AVISO:
    MOV     DX,OFFSET MSN_AVISO
    CALL    VIS_MENSAJE
	CALL    MET_MENU


MET_MENU:	
	
    MOV     DX,OFFSET MENU
	CALL    VIS_MENSAJE  
	
	CALL INGRESO 
	
	CMP AL, 31H
	JB  AVISO           ;comparar si es menor de 1
	CMP AL, 36H
	JA  AVISO           ;comparar si es mayor de 6
	
	
	
    
    CMP AL,31H
    JE  MULTIPLI        ;JE compara el num ingresado si es igual
    
       
	CMP AL,32H
	JE  SUM        
	
	
	CMP AL,33H
	JE  RESTT  
	
	
	
	CMP AL,34H
	JE  DIVISIN 
	
	CMP AL, 35H
	JE  VERIFICAR
	  

	CMP AL, 36H
	JE  SALIR 
    
    

	
;************************************
        MOV	DX,OFFSET MSALIR
        CALL    VIS_MENSAJE
        CALL    INGRESO
        CMP     AL,'S'
        JE      SALIR
        JMP     CICLOING

                
        .DATA           ;Definiendo datos
N1      DB      ?
N2      DB      ?
RES     DW      ? 
SUMA    DB      ?
RESTA   DB      ?
DIVISN  DB      ?
MODULO  DB      ?
UNI     DB      ?
DECE    DB      ?
MMEN    DB      10,10,13,'PROGRAMA PARA MULTIPLICAR NUMEROS DE DOS DIGITOS $'
MN1     DB      10,10,13,'INGRESAR NUMERO 1 (DOS DIGITOS): $'
MN2     DB      10,13,'INGRESAR NUMERO 2 (DOS DIGITOS): $'
MRES    DB      10,10,13,'Multiplicacion: $'    
MRES2   DB      10,10,13,'Suma: $'
MRES3   DB      10,10,13,'Resta: $'
MRES4   DB      10,10,13,'Division: $'
MENU    DB      10,10,13,'1-MULTIPLICACION 2-SUMA 3-RESTA 4-DIVISION 5-INGRESAR NUMEROS NUEVOS 6-SALIR: $'  
MSN_AVISO   DB      10,10,13, 'Numero incorrecto $'

MSALIR  DB      10,10,13,'DIGITE <S> PARA SALIR: $'
ASCVAL  DB      5 DUP(00H),'$'
BINVAL  DW      0000
       
       .STACK   ;SEGMENTO DE PILA
               
               
               
        END
ÿ
ÿ

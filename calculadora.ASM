;PROGRAMA PARA HACER OPERACIONES BASICAS CON DOS NUMEROS DE UN DIGITO


        .MODEL  SMALL

        .CODE
        ORG     0000    ;ASEGURAR DESPLAZAMIENTO 0000 PARA EL CS
        JMP     MAIN

;Definiendo datos
SEG_DAT:
        MOV     AX,@DATA
        MOV     DS,AX     ;registro de segmento de datos
        RET

;Ingresar el numero
INGRESO:
        MOV     AH,01H       ;entrada de caracter con salida
        INT     21H
        RET

;Funcion para salir
SALIR:  MOV     AH,4CH
        INT     21H
	RET

;Funcion para verificar ASCII
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
   
;Funciones de las operaciones	
   
SUMA: ; SUMAR
	 XOR AX,AX        ;reset de AH y AL
	 MOV AL,N1
	 ADD AL,N2
	 
	 MOV	    BINVAL,AX
	CALL	BINASCII
	
	
	MOV	DX,OFFSET MRES
	MOV     AH,09H     ;mostrar el mensaje
    INT     21H
	MOV	DX,OFFSET ASCVAL
	MOV     AH,09H     ;mostrar el mensaje
    INT     21H
	CALL MET_MENU
	 
	
RESTA:   
	;RESTA 
	
	
	 XOR AX,AX          ;reset de AH y AL
	 MOV  AL, N1
  
       
        SUB  AL,N2
       
       
    MOV	    BINVAL,AX
	CALL	BINASCII
	
	
	MOV	DX,OFFSET MRES2
	MOV     AH,09H     ;mostrar el mensaje
    INT     21H
	MOV	DX,OFFSET ASCVAL
	MOV     AH,09H     ;mostrar el mensaje
    INT     21H
	CALL MET_MENU                 

	
MULTIPLICACION:  ;MULTIPLICAR
    
    XOR AX,AX
    MOV AH,0
	MOV	AL,N1
    MUL N2
    
    	MOV	    BINVAL,AX
	CALL	BINASCII 

	MOV	DX,OFFSET MRES3
	MOV     AH,09H     ;mostrar el mensaje
    INT     21H
	MOV	DX,OFFSET ASCVAL
	MOV     AH,09H     ;mostrar el mensaje
    INT     21H
	CALL MET_MENU 
	
DIVISION:   
;DIVISION
    
     XOR AX,AX          ;reset de AH y AL
        
     MOV BL,N2
     MOV AL,N1
     DIV BL          
         
         
    MOV	    BINVAL,AX
	CALL	BINASCII
	
	
	MOV	DX,OFFSET MRES4
	MOV     AH,09H     ;mostrar el mensaje
    INT     21H
	MOV	DX,OFFSET ASCVAL
	MOV     AH,09H     ;mostrar el mensaje
    INT     21H
	CALL MET_MENU    
   
   
   
   
;Programa inicial
MAIN:   CALL    SEG_DAT ;Se llama el segmento de datos

    
 
   
	
CICLOING:			;se muestran las instrucciones del programa
    MOV     DX,OFFSET MNOM
    MOV     AH,09H     ;mostrar el mensaje
    INT     21H
    
    MOV     DX,OFFSET MMEN 
	MOV     AH,09H     ;mostrar el mensaje
    INT     21H   
 
VERIFICAR: CALL MULTI 		

MULTI:                  ;ciclo que se repite hasta salir
  
    MOV     DX,OFFSET MN1	;Se ingresa el primer numero
	MOV     AH,09H     ;mostrar el mensaje
    INT     21H
    XOR	BX,BX
	MOV	AH,01H
	INT	21H 
	CMP AL, 30H           ;se compara si los numeros ingresados a operar
	JB  VERIFICAR         ;esta entre 0 y 9
	CMP AL, 39H
	JA  VERIFICAR             
	             
	AND	AL,0FH
	
	ADD	BL,AL                                           
                                              
    
	MOV	N1,BL		;Se ingresa el segundo numero

    MOV	DX,OFFSET MN2
	MOV     AH,09H     ;mostrar el mensaje
    INT     21H
    XOR	BX,BX
	MOV	AH,01H
	INT	21H 
	CMP AL, 30H           ;se compara si los numeros ingresados a operar
	JB  VERIFICAR         ;esta entre 0 y 9
	CMP AL, 39H
	JA  VERIFICAR             
	             
	AND	AL,0FH
	
	ADD	BL,AL
   
        
	MOV	N2,BL            
	
	CALL MET_MENU
;--------------------------------------------------

AVISO:
    MOV     DX,OFFSET MSN_AVISO
    MOV     AH,09H     ;mostrar el mensaje
    INT     21H
	CALL    MET_MENU


MET_MENU:	
	
    MOV     DX,OFFSET MENU
	MOV     AH,09H     ;mostrar el mensaje
    INT     21H  
	
	CALL INGRESO 
	
	CMP AL, 31H
	JB  AVISO           ;comparar si es menor de 1
	CMP AL, 36H
	JA  AVISO           ;comparar si es mayor de 6
	
	
	
    
    CMP AL,31H
    JE  SUMA        ;JE compara el num ingresado si es igual
    
       
	CMP AL,32H
	JE  RESTA        
	
	
	CMP AL,33H
	JE  MULTIPLICACION  
	
	
	
	CMP AL,34H
	JE  DIVISION 
	
	CMP AL, 35H
	JE  VERIFICAR
	  

	CMP AL, 36H
	JE  SALIR 
    
    

	
;----------------------------------------------------
        MOV	DX,OFFSET MSALIR
        MOV     AH,09H     ;mostrar el mensaje
        INT     21H
        CALL    INGRESO
        CMP     AL,'S'
        JE      SALIR
        JMP     CICLOING

                
        .DATA           ;Definiendo datos
N1      DB      ?
N2      DB      ? 
MNOM    DB      10,13,'ANDRES GRANDA PIEDRAHITA - SANTIAGO ORDONNEZ $'
MMEN    DB      10,10,13,'CALCULADORA DE 1 DIGITO $'
MN1     DB      10,10,13,'INGRESAR NUMERO 1: $'
MN2     DB      10,13,'INGRESAR NUMERO 2: $'
MRES    DB      10,10,13,'Suma: $'    
MRES2   DB      10,10,13,'Resta: $'
MRES3   DB      10,10,13,'Multiplicacion: $'
MRES4   DB      10,10,13,'Division: $'
MENU    DB      10,10,13,'SELECCIONAR UNA OPCION:',10,13,'(1)SUMA',10,13,'(2)RESTA',10,13,'(3)MULTIPLICACION',10,13,'(4)DIVISION',10,13,'(5)INGRESAR NUMEROS NUEVOS',10,13,'(6)SALIR',10,13,'-> $'  
MSN_AVISO   DB      10,10,13, 'Numero incorrecto $'

MSALIR  DB      10,10,13,'DIGITE <S> PARA SALIR: $'
ASCVAL  DB      5 DUP(00H),'$'
BINVAL  DW      0000
       
       .STACK   ;SEGMENTO DE PILA
               
               
               
        END
ÿ
ÿ

.model small
.stack 64
.data

numero1 db 0
numero2 db 0
suma db 0
resta db 0
multiplicacion db 0
division db 0

msgn1 db 10,13, "Ingrese el primer numero de 1 digito: "'$'
msgn2 db 10,13, "Ingrese el segundo numero de 1 digito: "'$'
msgsum db 10,13, "(1) Suma" '$'
msgres db 10,13, "(2) Resta" '$'
msgmul db 10,13, "(3) Multiplicacion" '$'
msgdiv db 10,13, "(4) Division" '$'

.code
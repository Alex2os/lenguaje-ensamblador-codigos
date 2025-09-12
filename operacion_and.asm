org 100h

; cargamos los numeros en los registros
mov al, 0111b ; numero 7 en binario    
mov bl, 1011b ; numero 11 en binario    

and al, bl ; usamos la instruccion and para comparar los dos numeros. 
  
; el resultado que esperamos en este caso es el 3

mov mensaje, al    ; movemos o copiamos el valor del registro al al de la variable mensaje.
add mensaje, '0'   ; convertimos el numero a su equivalente en ascii

mov dl, mensaje ; movemos el valor de mensaje al registro de DL
mov ah, 02h ; especificamos que queremos la funcion para imprimir en el registro ah
int 21h ; realizamos una interrupcion para imprimir

; parte para salir del programa
mov ah, 4Ch ; especificamos que queremos la funcion para terminar el programa
int 21h ; realizamos la interrupcion
                                                             
; variable que usamos para el resultado
mensaje db 0                                       

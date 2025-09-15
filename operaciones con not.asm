org 100h

; cargamos los numeros en los registros   

mov al, 0011b ; numero 3 en binario    
mov bl, 0100b ; numero 4 en binario    

and al, bl ; usamos la instruccion or para comparar los dos numeros. 
not al


; el resultado que esperamos en este caso es el 255  
     
mov bx, 10 ; usaremos este registro para dividir entre 10.
mov cx, 0 ; ponemos cero en la el registro cx. este nos ayudara con la cantidad de digitos. y el loop

conversion_decimal: ; aqui lo que se hace es sacar los numeros que ya tenemos despues de las operaciones para tenerlos  

    xor dx, dx ; limpiamos el registro de dx para realizar la division de forma correcta
    div bx ; dividimos ax entre 10
    push dx ; guardamos lo que resta en el stack o pila
    inc cx ; incrementamos la cantidad
    test ax, ax ; checamos si el cociente es cero. 
    jnz conversion_decimal ; en caso de que este no sea cero, entonces se sigue el loop.

; print digits
imprimir_digitos:
    pop dx ; obtenemos el ultimo digito guardado
    add dl, '0' ; lo convertimos a su equivalente en ASCII
    mov ah, 02h
    int 21h ; imprimimos
    loop imprimir_digitos ; imprimimos los numeros hasta terminar el loop

; parte para salir del programa
mov ah, 4Ch ;
int 21h 
                                                                          

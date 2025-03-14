.data
    mensajeSolicitarCantidad: .asciiz "Ingrese la cantidad de n�meros a comparar (m�nimo 3, m�ximo 5): "  # Mensaje para solicitar la cantidad de n�meros
    mensajeError: .asciiz "Cantidad inv�lida. Debe ser entre 3 y 5.\n"  # Mensaje de error si la cantidad no es v�lida
    mensajeIngresarNumero: .asciiz "Ingrese un n�mero: "  # Mensaje para solicitar un n�mero
    mensajeMenor: .asciiz "El n�mero menor es: "  # Mensaje para mostrar el n�mero menor
    saltoLinea: .asciiz "\n"  # Salto de l�nea

.text
.globl main

main:
    # Solicitar la cantidad de n�meros a comparar
    li $v0, 4                   # Prepara la syscall para imprimir cadena (c�digo 4)
    la $a0, mensajeSolicitarCantidad  # Carga la direcci�n del mensaje en $a0
    syscall                     # Ejecuta la syscall para imprimir el mensaje

    li $v0, 5                   # Prepara la syscall para leer un entero (c�digo 5)
    syscall                     # Ejecuta la syscall, el entero le�do se almacena en $v0
    move $t0, $v0               # Guarda la cantidad de n�meros en $t0

    # Verificar si la cantidad es v�lida (entre 3 y 5)
    li $t1, 3                   # Carga el valor m�nimo permitido (3) en $t1
    li $t2, 5                   # Carga el valor m�ximo permitido (5) en $t2
    blt $t0, $t1, errorCantidad  # Si la cantidad es menor que 3, salta a errorCantidad
    bgt $t0, $t2, errorCantidad  # Si la cantidad es mayor que 5, salta a errorCantidad

    # Pedir el primer n�mero y asumirlo como el menor
    li $v0, 4                   # Prepara la syscall para imprimir cadena (c�digo 4)
    la $a0, mensajeIngresarNumero  # Carga la direcci�n del mensaje en $a0
    syscall                     # Ejecuta la syscall para imprimir el mensaje

    li $v0, 5                   # Prepara la syscall para leer un entero (c�digo 5)
    syscall                     # Ejecuta la syscall, el entero le�do se almacena en $v0
    move $t3, $v0               # Guarda el primer n�mero como el menor en $t3

    # Loop para leer los siguientes n�meros y encontrar el menor
    li $t4, 1                   # Inicializa el contador de n�meros ingresados en 1 (ya ingresamos 1)

loop:
    bge $t4, $t0, mostrarMenor  # Si ya se ingresaron todos los n�meros, salta a mostrarMenor
    
    # Pedir n�mero
    li $v0, 4                   # Prepara la syscall para imprimir cadena (c�digo 4)
    la $a0, mensajeIngresarNumero  # Carga la direcci�n del mensaje en $a0
    syscall                     # Ejecuta la syscall para imprimir el mensaje

    li $v0, 5                   # Prepara la syscall para leer un entero (c�digo 5)
    syscall                     # Ejecuta la syscall, el entero le�do se almacena en $v0
    move $t5, $v0               # Guarda el n�mero ingresado en $t5

    # Comparar con el menor actual
    bge $t5, $t3, continuar     # Si el n�mero ingresado no es menor, salta a continuar
    move $t3, $t5               # Si es menor, actualiza el menor en $t3

continuar:
    addi $t4, $t4, 1            # Incrementa el contador de n�meros ingresados
    j loop                      # Salta de vuelta al inicio del loop

mostrarMenor:
    # Mostrar mensaje "El n�mero menor es: "
    li $v0, 4                   # Prepara la syscall para imprimir cadena (c�digo 4)
    la $a0, mensajeMenor         # Carga la direcci�n del mensaje en $a0
    syscall                     # Ejecuta la syscall para imprimir el mensaje

    # Mostrar el n�mero menor
    li $v0, 1                   # Prepara la syscall para imprimir un entero (c�digo 1)
    move $a0, $t3               # Mueve el n�mero menor a $a0
    syscall                     # Ejecuta la syscall para imprimir el n�mero menor

    # Imprimir un salto de l�nea
    li $v0, 4                   # Prepara la syscall para imprimir cadena (c�digo 4)
    la $a0, saltoLinea           # Carga la direcci�n del salto de l�nea en $a0
    syscall                     # Ejecuta la syscall para imprimir el salto de l�nea

    j fin                       # Salta a fin para terminar el programa

errorCantidad:
    # Mostrar mensaje de error
    li $v0, 4                   # Prepara la syscall para imprimir cadena (c�digo 4)
    la $a0, mensajeError         # Carga la direcci�n del mensaje de error en $a0
    syscall                     # Ejecuta la syscall para imprimir el mensaje de error
    j main                      # Salta de vuelta a main para solicitar la cantidad nuevamente

fin:
    li $v0, 10                  # Prepara la syscall para terminar el programa (c�digo 10)
    syscall                     # Ejecuta la syscall para terminar el programa
.data
    mensajeSolicitarCantidad: .asciiz "Ingrese la cantidad de n�meros de Fibonacci a generar: "  # Mensaje para solicitar la cantidad de n�meros
    mensajeError: .asciiz "Cantidad inv�lida. Debe ser mayor a 0.\n"  # Mensaje de error si la cantidad no es v�lida
    mensajeResultado: .asciiz "La serie de Fibonacci es: "  # Mensaje para mostrar la serie de Fibonacci
    mensajeSuma: .asciiz "\nLa suma de la serie es: "  # Mensaje para mostrar la suma de la serie
    espacio: .asciiz " "  # Espacio para separar los n�meros en la serie
    saltoLinea: .asciiz "\n"  # Salto de l�nea

.text
.globl main

main:
    # Solicitar la cantidad de n�meros de la serie
    li $v0, 4                   # Prepara la syscall para imprimir cadena (c�digo 4)
    la $a0, mensajeSolicitarCantidad  # Carga la direcci�n del mensaje en $a0
    syscall                     # Ejecuta la syscall para imprimir el mensaje

    li $v0, 5                   # Prepara la syscall para leer un entero (c�digo 5)
    syscall                     # Ejecuta la syscall, el entero le�do se almacena en $v0
    move $t0, $v0               # Guarda la cantidad de n�meros en $t0

    # Verificar si la cantidad es v�lida (mayor a 0)
    blez $t0, errorCantidad     # Si la cantidad es menor o igual a 0, salta a errorCantidad

    # Inicializar valores de Fibonacci
    li $t1, 0                   # Primer n�mero de la serie (F0)
    li $t2, 1                   # Segundo n�mero de la serie (F1)
    move $t3, $t1               # Variable temporal para calcular el siguiente n�mero
    li $t4, 0                   # Inicializar suma total de la serie

    # Mostrar mensaje "La serie de Fibonacci es: "
    li $v0, 4                   # Prepara la syscall para imprimir cadena (c�digo 4)
    la $a0, mensajeResultado    # Carga la direcci�n del mensaje en $a0
    syscall                     # Ejecuta la syscall para imprimir el mensaje

    # Loop para generar la serie de Fibonacci
    li $t5, 0                   # Inicializa el contador de n�meros generados

fibonacci_loop:
    bge $t5, $t0, mostrarSuma   # Si se generaron todos los n�meros, salta a mostrarSuma
    
    # Imprimir el n�mero actual de la serie
    li $v0, 1                   # Prepara la syscall para imprimir un entero (c�digo 1)
    move $a0, $t1               # Mueve el n�mero actual de Fibonacci a $a0
    syscall                     # Ejecuta la syscall para imprimir el n�mero

    # Agregar espacio entre n�meros
    li $v0, 4                   # Prepara la syscall para imprimir cadena (c�digo 4)
    la $a0, espacio             # Carga la direcci�n del espacio en $a0
    syscall                     # Ejecuta la syscall para imprimir el espacio

    # Sumar al total
    add $t4, $t4, $t1           # Suma el n�mero actual de Fibonacci al total en $t4

    # Calcular siguiente n�mero en la serie
    add $t3, $t1, $t2           # F(n) = F(n-1) + F(n-2), resultado en $t3
    move $t1, $t2               # Actualiza F(n-1) con el valor de F(n)
    move $t2, $t3               # Actualiza F(n) con el valor de F(n+1)
    
    # Incrementar contador
    addi $t5, $t5, 1            # Incrementa el contador de n�meros generados
    j fibonacci_loop            # Salta de vuelta al inicio del loop

mostrarSuma:
    # Mostrar mensaje "La suma de la serie es: "
    li $v0, 4                   # Prepara la syscall para imprimir cadena (c�digo 4)
    la $a0, mensajeSuma          # Carga la direcci�n del mensaje en $a0
    syscall                     # Ejecuta la syscall para imprimir el mensaje

    # Imprimir la suma total
    li $v0, 1                   # Prepara la syscall para imprimir un entero (c�digo 1)
    move $a0, $t4               # Mueve la suma total a $a0
    syscall                     # Ejecuta la syscall para imprimir la suma

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
.data
matriz:     .byte 1, 2, 3, 4   
            .byte 5, 6, 7, 8    
            .byte 9, 10, 11, 12
            .byte 13, 14, 15, 16    
tam:        .byte 4              // Única variable para filas y columnas
suma:       .byte 0

.text
.global _start

_start:
    ldr r0, =tam               // Cargar dirección de tam
    ldr r2, =matriz             
    ldr r3, =suma               
    ldrb r4, [r0]               // r4 = tam (filas)
    mov r5, r4                  // r5 = tam (columnas)
    mov r6, #0                  // i = 0
    mov r8, #0                  // suma = 0

recorrer_filas:
    cmp r6, r4                  // Comparar i con tam
    bge fin
    mov r7, #0                  // j = 0

recorrer_columnas:
    cmp r5, r4                  // Comparar j con tam
    bge siguiente_fila

    cmp r6, r7                  // Saltar elementos de la diagonal
    beq no_sumar
    blt check_par
    beq check_par
    //bgt check_par //descomentar si queremos arriba o abajo,bgt inferiores y blt superiores, nunca pueden ir colapsados)
    b no_sumar

check_par:
    mov r9, r6
    add r9, r9, #1
    add r9, r9, r7
    add r9, r9, #1
    and r9, r9, #1
    cmp r9, #1
    bne no_sumar
    b sumar

sumar:
    mla r9, r6, r5, r7          // Índice = i * tam + j
    lsl r9, r9, #0              // Byte offset (no multiplicar)
    ldrb r9, [r2, r9]           // Cargar elemento de la matriz
    add r8, r8, r9              // Acumular suma
    b continuar_columnas

no_sumar:
    // No sumar

continuar_columnas:
    add r7, r7, #1              // j++
    b recorrer_columnas

siguiente_fila:
    add r6, r6, #1              // i++
    b recorrer_filas

fin:
    strb r8, [r3]               // Guardar resultado en suma
    bx lr
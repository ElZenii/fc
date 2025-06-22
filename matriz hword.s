.data
matriz:     .hword 1, 2, 3, 4   // fila 1
            .hword 5, 6, 7, 8    // fila 2
            .hword 9, 10, 11, 12
            .hword 13, 14, 15, 16    // fila 3
tam:      .hword 4

suma:       .hword 0

.text
.global _start

_start:
    ldr r0, =tam
    ldr r2, =matriz
    ldr r3, =suma
    ldrh r4, [r0]            // r4 = filas
    mov r5, r4              //columnas = r4
    mov r6, #0              // i = 0
    mov r8, #0              // suma = 0

recorrer_filas:
    cmp r6, r4
    bge fin
    mov r7, #0              // j = 0

recorrer_columnas:
    cmp r7, r5
    bge siguiente_fila

    cmp r6, r7             
    beq sumar
    blt check_par
    beq check_par
    bgt check_par
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
    mla r9, r6, r5, r7      // i*cols + j (índice)
    lsl r9, r9, #1          // multiplicar por 4 (tamaño hword)
    ldrh r9, [r2, r9]        // carga el valor
    add r8, r8, r9          // suma += valor
    b continuar_columnas

no_sumar:
    // No sumar, solo continuar

continuar_columnas:
    add r7, r7, #1
    b recorrer_columnas

siguiente_fila:
    add r6, r6, #1
    b recorrer_filas

fin:
    strh r8, [r3]
    bx lr
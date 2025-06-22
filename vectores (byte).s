.data
vec1:    .byte    1,2,3,4,5
vec2:    .byte    5,1,3,2,1
vec3:    .byte    3,1,5,2,1    
resul:   .byte    0,0,0,0,0
tam:     .byte    5

.text
.global main
main:    
    ldr  r4, =resul        
    ldr  r0, =tam
    ldrb r0, [r0]           
    ldr  r1, =vec1          
    ldr  r2, =vec2          
    ldr  r3, =vec3         
    stmdb sp!, {r4}         
    bl suma_vec             
    ldmia sp!, {r4}
    mov lr, #0
    bx lr

suma_vec:    
    stmdb sp!, {r4,r5,r6,r7,r8}     
    ldr r4, [sp, #20]      
    mov r7, #3              //variable multplicadora
    mov r8, #7              //variable multplicadora

suma_vec_bucle:    
    subs r0, r0, #1         
    blt fin_bucle           
    mov r5, #0              
    ldrb r6, [r1], #1       
    add r5, r5, r6         
    ldrb r6, [r2], #1       
    mul r6, r6, r8          
    sub r5, r5, r6          
    ldrb r6, [r3], #1       
    mul r6, r6, r7         
    add r5, r5, r6          
    strb r5, [r4], #1      
    b suma_vec_bucle        

fin_bucle:    
    ldmia sp!, {r4,r5,r6,r7,r8}      
    bx lr
                   
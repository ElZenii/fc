//4*vec1-3*vec2+vec3-vec4

.data
	vec1:   .hword 1,2,3,4
	vec2:	.hword 5,6,7,8
	vec3:	.hword 124,136,148,160
	vec4:	.hword 5,6,7,8

	resul:	.hword -1,-1,-1,-1
	tam:	.hword 4

.text
	.global main
		main:
			ldr r5,=resul	
			ldr r0,= tam
			ldrh r0,[r0]
			ldr r1,=vec1
			ldr r2,=vec2
			ldr r3,=vec3
			ldr r4,=vec4
			stmdb sp!,{r5}
			bl suma_vec
			ldmia sp!, {r5}
			mov lr,#0
			bx lr
		
	suma_vec:	stmdb sp!,{r5,r6,r7,r8,r9}
			ldr r5,[sp,#20]
			mov r8,#4
			mov r9,#3

	suma_vec_bucle:	subs r0,r0,#1
			blt fin_bucle
			mov r6,#0
			ldrh r7,[r1],#2
			mul r7,r7,r8
			add r6,r6,r7
			ldrh r7,[r2],#2
			mul r7,r7,r9
			sub r6,r6,r7
			ldrh r7,[r3],#2
			add r6,r6,r7
			ldrh r7,[r4],#2
			sub r6,r6,r7
			strh r6,[r5],#2
			b suma_vec_bucle
			
	fin_bucle:	ldmia sp!,{r5,r6,r7,r8,r9}
			bx lr

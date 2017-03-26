	.data			#Variables que vamos a usar en el programa.
a:	.word	24		#La etiqueta a toma el valor arbitrario.
c:	.word 	54		#La etiqueta c toma el valor arbitrario.

	.text			#Empezamos a generar instrucciones.
	lw	$t0, a		#Guardamos en t0 el valor de a.
	lw	$t1, c		#Guardamos en t1 el valor de c. 
	beqz	$t0, fin	#Si un número es 0, termina el programa.
	beqz	$t1, fin
	beq	$t0, $t1, fin	#Cuando es el mismo número.
	j	gcd		#Ninguno es 0 así que procedemos a calcular.
	
gcd:	beq	$t0, 1, fin	#Ya no tiene caso ir al loop, ya sabemos que son primos relativos.
	bgt	$t0, $t1, swap	#Hacemos un swap para siempre tener en un registro el menor.
s:	div	$t2, $t1, $t0	#División entera del menor con el mayor.
	mul 	$t3, $t2, $t0	#Multiplicamos al cociente con el divisor..
	sub 	$t4, $t1, $t3	#Hacemos la resta, si es cero, entonces t0 sí divide a t1
	beqz	$t4, fin	#El módulo es cero, por lo tanto t0 divide a t1,
	move	$t1, $t4	#No es múltiplo, entonces guardamos el residuo.
	j	gcd
	

swap:	move	$t9, $t0	#t9 = t0
	move	$t0, $t1	#t0 = t1
	move	$t1, $t9	#t1 = t9
	j 	s
	
fin:	move	$v0, $t0	#Guardamos en $v0 el MCD, el valor que está en $t0.

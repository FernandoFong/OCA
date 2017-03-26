	.data			#Variables que vamos a usar en el programa.
a:	.word	7		#La etiqueta a toma el valor arbitrario.
c:	.word 	3		#La etiqueta c toma el valor arbitrario.

	.text			#Empezamos a generar instrucciones.
	lw	$t0, a		#Guardamos en t0 el valor de a.
	lw	$t1, c		#Guardamos en t1 el valor de c.
	blt	$t1, $t0, swap	#Hacemos un swap para que el menor siempre se encuentre en $t0.
main:	move	$t2, $t0	#Copiamos el divisor.
	li	$t3, 1		#Creamos un contador que es el que nos dice el cociente.
while:	sub	$t4, $t1, $t2	#Hacemos la resta para saber si nos estamos acercando al número.
	bgt	$t4, $t0, cont	#Vamos al loop puesto que todavía es mayor por t0 unidades.
	j 	quit
cont:	add	$t2, $t2, $t0	#Si t2 = nt0, en esta línea se vuelve t2= (n+1)t0.
	addi	$t3, $t3, 1	#t3++
	j	while

swap:	move	$t9, $t0	#t9 = t0
	move	$t0, $t1	#t0 = t1
	move	$t1, $t9	#t1 = t9
	j 	main

quit:	move	$v0, $t3	#Guardamos en v0 el cociente.
	move	$v1, $t4	#Guardamos en v1 el residuo.	
	

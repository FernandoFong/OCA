#Fong Baeza Luis Fernando Yang Gonzalez Chavez Maria Fernanda.
	.data
n: 	.word	7	#La base que queremos obtener como potencia.	
op1:	.word	16807	#El numero que deseamos verificar.
uno:	.word 	1	#Resultado positivo.
muno:	.word 	-1	#Resultado negativo.

	.text
	lw	$t0, n		#Guardamos la base.
	lw	$t1, op1	#El número deseado a saber si es o no potencia de n.
	beq	$t1, 1, pos	#El uno es potencia de todo número.
	ble	$t1, $t0, nega	#Cuando recibimos algo entre uno y la base.
	lw	$t2, n		#Ya sabemos que no fue uno, así que tenemos que empezar a buscar un probable.
main:	blt	$t2, $t1, eleva	#Aquí es donde le sumamos n veces la potencia, que es como hacer nxn.
	beq	$t2, $t1, pos	#Sí era potencia de n.
	bgt	$t2, $t1, nega	#No fue potencia de n.
	
	
eleva:	lw 	$t3, uno	#Empezamos la suma.
do:	add 	$t2, $t2, $t0	#Le sumamos n.
	addi	$t3, $t3, 1	#Incrementamos el contador.
	bne	$t3, $t0, do	#Volvemos a iterar.
	j	main
		
pos: 	lw	$v0, uno	#Asignamos a el resultado uno porque si resultó ser potencia de n.
	break	100

nega:	lw	$v0, muno	#No hace falta el break por ser la última instrucción.
	.data
x:	.word	5
y:	.word 	4

	.text
main: 	lw	$a0, x		#1.Pasamos los argumentos.
	lw	$a1, y		#1.Pasamos los argumentos.
	jal	mist_1		#Invocamos a la subrutina. 
	j 	finmain		#El programa termina.
#mist_1 recibe como argumentos, $a0 y $a1.
mist_1:	#Preambulo mist_1.
	subi	$sp, $sp, 24	#1.Reservamos memoria para el marco.
	sw 	$ra, 16($sp)	#3.Guardamos ra.
	sw	$fp, 20($sp) 	#4.Guardar fp.
	addi	$fp, $sp, 20	#4.Establecer $fp.
	
	move	$s0, $a0	#Cargamos en una variable global el exponente.
	move 	$t0, $a1	#Copiamos el primer argumento de main.
	li	$t1, 1		#Constante uno.
	
loop_1:	beqz	$s0, end_1	#Llegamos al caso base.
	#Invocacion de mist_0.
	move	$a0, $t0	#Se pasa el argumento $a0.
	move 	$a1, $t1	#Se pasa el argumento $a1.
	jal	mist_0		#Llamamos a miist_0 con los argumentos a0 y a1.
	#Regreso de mist_0.
	move	$t1, $v0	#Copiamos el valor de retorno de mist_0 v0.
	subi	$s0, $s0, 1	#Restamos uno al exponente.
	j	loop_1		#Volvemos a iterar.
end_1:	#Conclusion mist_1.
	lw	$ra, 16($sp)	#Recorremos ra 16 lugares desde el sp.
	lw	$fp, 20($sp)	#Quitamos el frame pointer y lo llevamos al pasado.
	addi	$sp, $sp, 24	#Descarga el marco de la pila.
	move	$v0, $t1	#Se regresa el resultado en $v0.
	jr	$ra		#Regresamos al registro que llama a esta subrutina.
#mist_0 regresa como argumentos $a0 y $a1.
mist_0:	#Preambulo mist_0.
	subi	$sp, $sp, 24	#1.Reservamos memoria para el marco.
	sw	$ra, 16($sp)	#3.Guardamos ra.
	sw	$fp, 20($sp) 	#3.Guradar fp.
	addi	$fp, $sp, 20	#4.Marcamos donde esta fp actualmente por la llamada a mist_0.
	
	lw	$ra, 16($sp) 	#Descarga el return adress.
	lw	$fp, 20($sp)	#Descargamos el frame pointer, quitamos el marco.
	addi	$sp, $sp, 24	#Borramos el marco y lo llevamos al anterior.
	#Conclusion mist_0.
	mult	$a0, $a1
	mflo	$v0		#Se regresa el resultado en $v0.
	jr	$ra		#Regresamos al que nos llamo.
	#Regeso de mist_0.
finmain:nop			#No se ejecutan mas operaciones.
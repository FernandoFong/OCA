		.data
pila:		.space	1024	
operacion:	.space	1024
actual:		.space	1024		
suma:		.asciiz	"+"
resta:		.asciiz	"-"
multiplicacion:	.asciiz	"*"
divicion:	.asciiz	"/"
salir:		.asciiz	"exit\n"
op:		.asciiz	"\n$"
		.text
main:
		la	$t0,operacion	#Guardamos los buffers
		la	$s0,pila
borraBuffer:	#borramos el buffer de lectura para que el anterior no interfiera con las nuevas operaciones
		lb	$t1,($t0)	# Todo esto sera para dejar el buffer vacio en caso de que tenga algo guardado
		beq	$t1,'\0',lectura#si llegamos al final empezamos con las operaciones
		sb	$t7,($t0)	#movemos el caracter para que ya no haya nada en ese espacio de memoria
		addi	$t0,$t0,1		
		j	borraBuffer		
lectura:	li	$v0,4		#Llamada para imprimir el promp
		la	$a0,op			
		syscall					
		li	$v0,8		#Llamada para leer de la terminal un string que sera nuestra operacion
		la	$a0,operacion		
		li	$a1,1024		
		syscall		
		subi	$sp,$sp,24	#hacemos el marco referente a la subritina del equals
		sw	$ra,16($sp)		
		sw	$fp,20($sp)		
		addi	$fp,$sp,20	
		move	$s3,$a0		#se comparara si la cadena es igual a "exit" con lo  cual terminara la ejecucion
		la	$a1,salir	#se carga la cadena "exit"
		jal	equals		#se manda a llamar la subrutina
		bgtz	$v0,exit	#si tenemos que la cadena introcucida es igual a "exit" entonces terminamor la ejecuion

#como no salio de la ejecucion empezamos con la calculadora
calculadora:
		la	$s2,($s3)
operacionActual:la	$s1,actual
for:		lb	$t0,($s2)
		beq	$t0,'\n',comparar
		beq	$t0,'\0',r
		beq	$t0,' ', comparar
		sb	$t0,($s1)
		addi	$s2,$s2,1
		addi	$s1,$s1,1
		j	for
		
comparar:	#comparamos con cada string para saber que operacion sera, en caso de no ser una operacion se convierte el caracter a numero	
		addi	$s2,$s2,1	#avanzamos un caracter
		la	$a0,actual	#cargamos la operacion actual
		
		la	$a1,suma	#comparamos para saber si es una suma, en cuyo caso vamos al codigo que sumara
		jal	equals
		bgtz 	$v0 ,sumar

		la	$a1,resta	#comparamos si hace una resta y si lo hace saltamos al codigo adecuado
		jal	equals
		bgtz 	$v0 ,restar	

		la	$a1,multiplicacion#comparamos si hace una multiplicacion y si lo hace saltamos al codigo adecuado
		jal	equals
		bgtz 	$v0 ,multiplica

		la	$a1,divicion	#comparamos si hace una divicion y si lo hace saltamos al codigo adecuado
		jal	equals
		bgtz 	$v0 ,divide

		jal	str_to_int		
		sw	$v0,($s0)
		addi	$s0,$s0,4
		#limpiar el buffer de la opracion actual para la siguiente
borraBuffer2:	la	$s5,actual		#recorremos le buffer actual y en cada iteracion remplazamos
while2:		lb	$t1,($s5)		#el caracter en dicha pocicion por el caracter vacio
		beq	$t1,'\0',operacionActual	
		sb	$t7,($s5)		
		addi	$s5,$s5,1		
		j	while2			

r:		#imprimimos el resultado y regresamos al main para la siguinte operacion
		li	$v0,1
		lw	$a0,($s0)
		syscall		
		j	main
		
sumar:		subi	$s0,$s0,4
		lw	$s4,($s0)
		subi	$s0,$s0,4
		lw	$s3,($s0)
		add	$s4,$s4,$s3
		sw	$s4,($s0)	
		j	borraBuffer2

restar:		subi	$s0,$s0,4
		lw	$s4,($s0)
		subi	$s0,$s0,4
		lw	$s3,($s0)
		sub	$s4,$s3,$s4
		sw	$s4,($s0)
		j	borraBuffer2

multiplica:	subi	$s0,$s0,4
		lw	$s4,($s0)
		subi	$s0,$s0,4
		lw	$s3,($s0)
		mul	$s4,$s4,$s3
		sw	$s4,($s0)
		j	borraBuffer2
		
divide:		subi	$s0,$s0,4	#segmento del codigo que hace lo referente a la divicio
		lw	$s4,($s0)
		subi	$s0,$s0,4
		lw	$s3,($s0)
		div	$s4,$s3,$s4
		sw	$s4,($s0)
		j	borraBuffer2

exit:		li	$v0,10		# llamada al sistema que termina la ejecucion
		syscall				

#rutina que convierte a entero un string
str_to_int:
		move		$v0, $zero		# Poner el resultado en cero
		move		$v1, $a0		# Apuntador al final de la cadena
		li		$t0, 10			# Cargar inmediato 10 (usado para convertir el numero)
					
							## Verificar si es positivo o negativo
		lb		$t1, ($v1)		# Cargar primer carcater
		bne		$t1, '-', loop		# Si el primer caracter es '-' 
		li		$t2, 1			# Cargar 1 en $t2 (El numero es negativo)
		addi		$v1, $v1, 1		# Siguiente caracter
	
loop:	
		lb		$t1, ($v1)		## Cargar siguiente carcater

		beq		$t1, ' ', end		## Si el carcater es espacio, salto de linea o nulo, fin de la rutina
		beq		$t1, '\n', end		
		beq		$t1, '\0', end		
							## Verificar errores
		tlti		$t1, '0'		# El caracter no es un numero
		tgei		$t1, ':'		# El carcater no es un numero	

		mult		$v0, $t0		# Multiplicar el resultado por 10
		mflo		$v0			# Recuperar el resultado del producto

		subi		$t1, $t1, '0'		## Convertir el caracter en entero
		add		$v0, $v0, $t1		# Agregar la unidad al resultado
	
		addi		$v1, $v1, 1		# Apuntar a siguiente carcater
		j		loop			# Repetir proceso
			
end:		bne		$t2, 1, return		## Si el número era negativo
		neg		$v0, $v0		## Cambiar el signo del resultado
	
return:		jr		$ra			# Fin de la rutina

#rutina que compara dos string para saber i son iguales 
equals:	
		subi	$sp,$sp,24	#creamos el nuevo marco	
		sw	$fp,16($sp)		
		addi	$fp,$fp,20		
		li	$t0,0		#guardamos la constante cero
while:		lb	$t1,($a0)	#guardamos los caracteres 
		lb	$t2,($a1)	
		beqz	$t1,true	#si termina la primer cadena decimos que son iguales
		bne	$t1,$t2,false	#si ha caracteres distintos decimos que es falce
		addi	$a1,$a1,1	#recorremos el caracter al siguiete
		addi	$a0,$a0,1	
		j	while		#iteramos

false:		addi	$v0,$t0,0		
		j	ret			
true	:	addi	$v0,$t0,1		
ret:		lw	$fp,16($sp)		
		addi	$sp,$sp,24		
		jr	$ra	
			
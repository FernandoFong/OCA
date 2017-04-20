	.data
mens:	.asciiz	"$"
help:	.asciiz	"help"
rev:	.asciiz	"rev"
cat:	.asciiz "cat"
exit:	.asciiz "exit"
buffer:	.space 	1024

	.text
	li 	$v0, 4		#Direccion donde inicia la cadena con la operacion a realizar.
	la	$a0, mens	#Apuntamos al bit inicial de mens.
	syscall			#Llamada al systema que realiza lo que este en v0.
	li	$v0, 8		#Se actualiza lo deseado.
	la	$a0, buffer	#Guardamos el apuntador de la cadena.
	li	$a1, 1024	#Le damos el tamaño de la cadena.
	syscall			#Llamamos al sistema.
	la	$t0, buffer	#Cargamos la cadena en t0.
loop:	lb	$t1, ($t0)	#Donde inicia la cadena.
	beq	$t1, '\n', del	#Hacemos la comparacion con el salto de linea.
	beq	$t1, '\0', del	#Brincamos en caso de no tener salto de linea.
	addi	$t0, $t0, 1	#Adelantamos a el caracter.
	j	loop		#Como no es el que buscamos, hacemos el salto incondicional.
	
del:	sb	$zero, ($t0) 	#Eliminamos el caracter de salto por un final.

	li	$v0, 13		#Llamamos el codigo para abrir el archivo.
	la	$a0, buffer	#Cargamos el archivo a leer en la direccion de memoria en buffer.
	li	$a1, 0		#Le decimos que solo va a ser de lectura con la bandera.
	syscall			#Llamamos al sistema.
	move	$t0, $v0	#Movemos el archivo.
	sb	$zero,buffer+4
lect:	li	$v0, 14		#Cargamos la instruccion.
	move 	$a0, $t0	#Guardamos el archivo.
	la	$a1, buffer	#Guardamos la direccion del archivo.
	li	$a2, 4		#Le damos un tamaño al archivo.
	syscall			#Llamada sistema.
	move	$t1, $v0	#Guardamos la long. del archivo
	li	$v0, 4		#Le decimos que imprima.
	la	$a0, buffer	#Le decimos que leer.
	syscall			#Llamada sistema.
	li	$t2, 4		#Caracteres que leemos.
	blt	$t1, $t2, end	#Ya terminamos de leer las cadenas en el programa.
	j 	lect		#Como no hemos terminado, volvemos a leer los 4 bytes.
	
end:	li	$v0, 16		#Cerramos el archivo.
	move	$a0, $t0	#Marcamos al descriptor.
	syscall			#Llamada sistema.
	li	$v0, 10		#Terminamos el programa. 
	syscall			#Llamada al programa.
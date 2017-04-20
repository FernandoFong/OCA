	.data
mens:	.asciiz	"$"		#Simulamos a la línea de comandos en la terminal.
help:	.asciiz	"help"		#Cadena que simula al comando en terminal.
rev:	.asciiz	"rev"		
cat:	.asciiz "cat"
exit:	.asciiz "exit\n"
buffer:	.space 	1024		#Reservamos este espacio para leer el archivo o archivos de texto.

	.text
	la	$t9, exit	#Cargamos en $t9 el apuntador a la cadena "exit".
	la	$t8, cat	#Cargamos en $t8 el apuntador del comando "cat". 
	la	$t7, rev	#Cargamos en $t7 el apuntador del comando "rev".
	la	$t6, help	#Cargamos en $t6 el apuntador del comando "help".
loop:	li	$v0, 4		#Le decimos al sistema la operación a realizar.
	la	$a0, mens	#Vamos a imprimir lo que simula la línea de comandos.
	syscall			#Hacemos la llamada al sistema para imprimir "$" esperando el comando.
	li	$v0, 8		#Le decimos al sistema que vamos a leer una cadena.
	la	$a0, buffer	#Guardamos el apuntador al tamaño de la cadena.
	li	$a1, 1024	#Suponemos el tamaño de la cadena.
	syscall			#Llamada al sistema que hace la lectura de la entrada.
	la	$t0, buffer	#Cargamos en $t0 el apuntador a la cadena leída.
	j	extcmp		#Vamos a suponer que el comando escrito es exit, vamos a verificarlo.		
	#Comparamos que el comando sea exit.
	lb   	$t1, ($t0)	#Leemos el byte con el que empieza la cadena.
extcmp:
while:	lb	$t2, ($t9)	#Cargamos en un temporal el byte a comparar.
	bne	$t1, $t2, cont	#Saltamos a intentar con otro comando.
	beq	$t1, $zero,true	#Ya terminamos de leer las cadenas.
	addi	$t0, $t0, 1	#Adelantamos el apuntador al caracter de la cadena.
	addi	$t9, $t9, 1	#Adelantamos el apuntador al caracter de la cadena.
	j 	while		#Regresamos al loop.
	
cont:	
	
true:	li	$v0, 10		#Vamos a terminar el programa puesto que el comando escrito fue exit.
	syscall			#Llamada al sistema.

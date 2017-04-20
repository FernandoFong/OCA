	.data
promt:	.asciiz	">"		#Caracter para imprimir y esperar la entrada.
stack:	.space	120		#Espacio reservado para la pila.
input:	.space	1024		#Tamaño máximo de cadena.

	.text
loop1:	la 	$a0, prompt	
	li	$v0, 1
	syscall
	li	$v0, 4
	syscall
	j 	loop1
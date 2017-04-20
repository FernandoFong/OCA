	#Programa que compara dos cadenas en ensamblador.
	.data
cad1:	.asciiz	"Jajaja"	#La cadena hola.
cad2:	.asciiz	"Hola"		#La cadena hola\0.
	
	.text
	la	$s0, cad1	#Cargamos el argumento en a0.
	la	$s1, cad2	#Cargamos el argumento en a1.
while:	lb   	$t1, ($s0)	#Cargamos en un temporal el byte a comparar.
	lb	$t2, ($s1)	#Cargamos en un temporal el byte a comparar.
	bne	$t1, $t2, false	#Saltamos si no son iguales los bytes.
	beqz	$t0, true	#Ya terminamos de leer las cadenas.
	addi	$s0, $s0, 1	#Adelantamos el apuntador al caracter de la cadena.
	addi	$s1, $s1, 1	#Adelantamos el apuntador al caracter de la cadena.
	j 	while		#Regresamos al loop.
	
true:	li	$v0, 1		#La operación fue positiva.
	j	end		#Brincamos al fin del programa.
false:	break			#Simplemente terminamos el programa.
end:	nop			#No hacemos nada.
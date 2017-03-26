	.data			#Valores que vamos a usar.
n:	.word	10		#La etiqueta n toma el valor de 10.

	.text			#Empezamos a ensamblar.
	lw	$t0,n		#Guardamos en t0 el valor de la etiqueta n.
	add	$v0, $t0, 0	#Hacemos la suma de lo que hay en t0 con 0 para no afectar el valor, simula una copia.
	

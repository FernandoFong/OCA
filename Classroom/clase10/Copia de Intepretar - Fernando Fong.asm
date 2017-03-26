#Fong Baeza Luis Fernando Yang Gonzalez Chavez Maria Fernanda.
	.data

x: 	.half 8		  		# El codigo de x es: 0100110
y: 	.word 32 			# El codigo de y es: 1000111
 
	.text
	
etiqueta1: 				#1111000100000100:
  
 	lw $t1 y
  	lw $t0 x
 	li $a0 0			
 	
etiqueta2: 				#1011100010011010:
 
 	blez $t1 etiqueta3
 	sub $t1 $t1 $t0
 	addi $a0 $a0 1 			
 	j etiqueta2
 	
etiqueta3: 				#1011110110000100:
#      -Aqui dejo de ensamblar-
 	move $v0, $a0	

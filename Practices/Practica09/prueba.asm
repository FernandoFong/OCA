	.data
dato:	.word	1
	.text
	lw	$01, dato
loop:	beq	$01, $00, end
	subi	$01, $01, 1
	j 	loop
end:	add	$02, $01, $00

#Question 6
.data
	primeiro: .word 5
	segundo: .word 3 
	RESULT: .word
	repet: .word 1 #repet � a vari�vel que vou utilizar para demarcar o n�mero de repeti��es
.text
	#Recebendo os dois inteiros da mem�ria e guardando nos registradores
	lw $t0, primeiro
	lw $s1, primeiro
	lw $t1, segundo
	
	#Recebe a vari�vel auxiliar
	lw $s0, repet
	
	#Descobrindo se � negativo
	blt $t1, $zero, negativo#se t1 for menor que zero 
	
	positivo:#Se o n�mero for positivo, vamos fazer um la�o de repeti��o somando
	add $t0, $t0, $s1
	addi $s0, $s0, 1
	bne $t1, $s0, positivo ##repete a instru��o positivo caso t1 for igual a s0 
	beq $t1, $s0, resultado #pula pra resultado caso o que estiver no registrador $t1 for igual ao  que tem na vari�vel 'segundo'
	
	negativo:#Se o segundo numero for negativo, vamos fazer um la�o de repeti��o subtraindo
	sub  $t0, $t0, $s1
	addi $s0, $s0, -1
	bne $t1, $s0, negativo #repete a instru��o negativo caso t1 for igual a s0 
	beq $t1, $s0, resultado #pula pra resultado caso o que estiver no registrador $t1 for igual ao  que tem na vari�vel 'segundo'
	
	#Armazenando o resultado na vari�vel RESULT
	resultado:
	sw $t0, RESULT
	
	li $v0, 10 #encerro o programa
	syscall

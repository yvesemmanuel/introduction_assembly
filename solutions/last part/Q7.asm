#Question 7
.data
	#Três inteiros dos lados
	primeiro: .word 2
	segundo: .word 3
	terceiro: .word 4
	r: .word #Variável para armazenar o resultado
.text
	#Recebe os três lados
	lw $t0, primeiro
	lw $t1, segundo
	lw $t2, terceiro
	
	#Soma do primeiro com segundo
	add $s0, $t0, $t1
	
	#Soma do segundo com terceiro
	add $s1, $t1, $t2
	
	#Soma do primeiro com terceiro
	add $s2, $t0, $t2
	
	#Definindo se é ou não um triângulo
	bge $t0, $s1, nao # se t0 for maior ou igual a s1
	bge $t1, $s2, nao # se t1 for maior ou igual a s2
	bge $t2, $s0, nao # se t2 for maior ou igual a s0
	
	#Definindo se é equilátero
	bne $t0, $t1, noEq #Se o lado 0 é igual o lado 1
	bne $t0, $t2, isoc #Se o lado 0 é igual o lado 2
	
	#É equilátero
		addi $t3, $zero, 1
		sw $t3, r #Adiciono a 'r' o valor 1 (equilátero)
		li $v0, 10
		syscall
	
	#Não é equilátero
	noEq:
	
	#Definindo se é isósceles
	bne $t0, $t2, noIso #Defino se os lados não averiguados anteriormente são iguais
	
	#É isósceles
	isoc:
		addi $t3, $zero, 2
		sw $t3, r #Adiciono a 'r' o valor 2 (isósceles)
		li $v0, 10
		syscall
	#Não é isósceles
	noIso:
	#Se não é isósceles nem equilátero o triângulo é escaleno
		addi $t3, $zero, 3
		sw $t3, r #Adiciono a 'r' o valor 3 (escaleno)
		li $v0, 10
		syscall
	#Não é um triângulo
	nao:
		addi $t3, $zero, 0
		sw $t3, r #Adiciono a 'r' o valor 0 (não triângulo)
		li $v0, 10
		syscall
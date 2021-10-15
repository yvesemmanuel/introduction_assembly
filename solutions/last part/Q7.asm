#Question 7
.data
	#Tr�s inteiros dos lados
	primeiro: .word 2
	segundo: .word 3
	terceiro: .word 4
	r: .word #Vari�vel para armazenar o resultado
.text
	#Recebe os tr�s lados
	lw $t0, primeiro
	lw $t1, segundo
	lw $t2, terceiro
	
	#Soma do primeiro com segundo
	add $s0, $t0, $t1
	
	#Soma do segundo com terceiro
	add $s1, $t1, $t2
	
	#Soma do primeiro com terceiro
	add $s2, $t0, $t2
	
	#Definindo se � ou n�o um tri�ngulo
	bge $t0, $s1, nao # se t0 for maior ou igual a s1
	bge $t1, $s2, nao # se t1 for maior ou igual a s2
	bge $t2, $s0, nao # se t2 for maior ou igual a s0
	
	#Definindo se � equil�tero
	bne $t0, $t1, noEq #Se o lado 0 � igual o lado 1
	bne $t0, $t2, isoc #Se o lado 0 � igual o lado 2
	
	#� equil�tero
		addi $t3, $zero, 1
		sw $t3, r #Adiciono a 'r' o valor 1 (equil�tero)
		li $v0, 10
		syscall
	
	#N�o � equil�tero
	noEq:
	
	#Definindo se � is�sceles
	bne $t0, $t2, noIso #Defino se os lados n�o averiguados anteriormente s�o iguais
	
	#� is�sceles
	isoc:
		addi $t3, $zero, 2
		sw $t3, r #Adiciono a 'r' o valor 2 (is�sceles)
		li $v0, 10
		syscall
	#N�o � is�sceles
	noIso:
	#Se n�o � is�sceles nem equil�tero o tri�ngulo � escaleno
		addi $t3, $zero, 3
		sw $t3, r #Adiciono a 'r' o valor 3 (escaleno)
		li $v0, 10
		syscall
	#N�o � um tri�ngulo
	nao:
		addi $t3, $zero, 0
		sw $t3, r #Adiciono a 'r' o valor 0 (n�o tri�ngulo)
		li $v0, 10
		syscall
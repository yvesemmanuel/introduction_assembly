.data
	
	array1: .word 2, 4, 7, 17, 25, 26, 3 # o programa funciona com qualquer array de 1 a 100, contanto que a variavel 
	array1Size: .word 7	# array1Size seja alterada de acordo com o tamanho do array, pelo próprio usuário
	array2: .word
	array2Size: .word 0
	space: .asciiz " "

.text
	
	main:
		la $s0, array1 #endereco do primeiro array
		la $s1, array2 #endereco do segundo array
		lw $t3, array2Size # t3 armazenara o tamanho do segundo array
		lw $t4, array1Size # t4 armazena o tamanho do primeiro array
		
		addi $t0, $zero, 0 #usarei esse registrador para indice do array1
		addi $t1, $zero, 0 #registrador para indice do array 2
		
		sll $t5, $t4, 2 #multiplica t4 por 4
		
		
		for: #iteracao pelo array
			beq $t0, $t5, indexReset
			
			lw $t6, array1($t0)
			
			beq $t6, 2, isPrime
			beq $t6, 3, isPrime
			
			li $t2, 2 # vai checar se numero é primo
			
			checkIsPrime: #funcao para verificar se o numero é primo
				beq $t2, $t6, isPrime
				
				div $t6, $t2
				
				mfhi $s2
				
				beq $s2, 0, continue
				
				addi $t2, $t2, 1
				j checkIsPrime
			
			continue:
				addi $t0, $t0, 4 # i++
				j for
		
	
		indexReset: #reseta o index do array 1 e array 2
			li $t0, 0 
			li $t1, 0
			
		print1: #printa o array 1
			beq $t0, $t5, continue2
			
			lw $t6, array1($t0) # t6 = array[i]
			
			addi $t0, $t0, 4
			
			li $v0, 1 
			move $a0, $t6
			syscall #printando o numero
			
			li $v0, 4
			la $a0, space #printando o espaco
			syscall
			

			j print1
		
		continue2:
			sll $t5, $t3, 2
			
			
			addi $a0, $0, 0xA #printando uma nova linha
			addi $v0, $0, 0xB
			syscall
			
		
		print2: #printando o segundo array
			beq $t1, $t5, exit 
			
			lw $t6, array2($t1) # t6 = array[i]
			
			addi $t1, $t1, 4
			
			li $v0, 1 
			move $a0, $t6
			syscall #printando o numero
			
			li $v0, 4
			la $a0, space #printando o espaco
			syscall
			

			j print2
	
	exit:
		li $v0, 10
		syscall #parando execucao
		
	isPrime:
		addi $t3, $t3, 1 #bloco de codigo que armazena o valor primo no segundo array
		
		sw $t6, array2($t1)
		
		addi $t1, $t1, 4
			
		j continue
		
		
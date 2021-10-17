.data

	array: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 # array a ser utilizado
				
	space: .asciiz " " # um espaço para ajudar no print no terminal (teste para ver se o codigo esta funcionando
			   # corretamente)
			   # para essa questao temos que: array[10] = {0,1,2,3,4,5,6,7,8,9} = i

.text
	main:
		la $s0, array #endereco do array
		addi $t0, $zero, 0 #indice
		
	
		for:
			beq $t0, 40, indexReset # i < 10
			
			lw $t1, array($t0) # t1 = array[i]
			
			
			div $t2, $t1, 2	# t2 = t1/2
			mfhi $t2 # t2 = resto da divisao
		
			beq $t2, 0, even # if i % 2 == 0
			
			j else
			continue:
				addi $t0, $t0, 4 # i++
			j for
	
		
		indexReset:
			li $t0, 0 # reseta o indice para printar o array

		print:
			beq $t0, 40, exit
			
			lw $t6, array($t0) # t6 = array[i]
			
			addi $t0, $t0, 4
			
			li $v0, 1 
			move $a0, $t6
			syscall #printando o numero
			
			li $v0, 4
			la $a0, space #printando o espaco
			syscall
			

			j print
	exit: 
		li $v0, 10
		syscall # parando a execucao
		
	even:
		addi $t3, $t0, 4 # t3 = i + 1
		
		lw $t4, array($t3) #t4 = array[i+1]
		add $t1, $t1, $t4 #array[i] = array[i] + array[i + 1]
		sw $t1, array($t0)
		
		j continue
		
	else:
		sll $t1, $t1, 1 #array[i] = array[i] * 2
		sw $t1, array($t0)
		j continue
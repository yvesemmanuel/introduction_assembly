.data

	idadeJoao: .word 20
	idadePedro: .word 20
	velho: .asciiz "Joao e mais velho que Pedro"
	novo: .asciiz "Pedro e mais velho que Joao"
	igual: .asciiz "Eles tem a mesma idade"
	
.text
	main: 
		lw $t0, idadeJoao
		lw $t1, idadePedro
		li $t2, 1 # verificar condicional
		
		slt $t3, $t1, $t0 # idadePedro < idadeJoao
		beq $t3, $t2, joaoVelho
		
		slt $t3, $t0, $t1 # idadeJoao < idadePedro
		beq $t3, $t2, pedroVelho
		
		
		li $v0, 4
		la $a0, igual
		syscall
		
		end:
			li $v0, 10
			syscall
		
		joaoVelho:
			
			li $v0, 4
			la $a0, velho
			syscall 
			j end

		pedroVelho:
		
			li $v0, 4
			la $a0, novo
			syscall 
			j end
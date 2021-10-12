.text
	li $a0, 20 # $a0 is the argument to the function, i.e, N Fibonacci term
	
	Fibonacci:
		bgt $a0, 1, Recursion # if N > 1 -> Recursion
		move $v0, $a0 # $v0 = N
		jr $ra # jump to the return address, i.e, copies the content of $ra to the PC
	
	Recursion:
		addi $sp, $sp, -12 # allocating 3 registers (slots of memory) to the stack
		sw $ra, 0($sp) # save $ra as the first register
		sw $a0, 4($sp) # save $a0 as the second register (storing N)
		
		addi $a0, $a0, -1 # compute N - 1
		jal Fibonacci # call the function to N - 1, but save the return address to $ra
		sw $v0, 8($sp) # store $v0 (value returned from function)
		
		lw $a0, 4($sp) # restore N
		sub $a0, $a0, 2 # compute N - 2
		jal Fibonacci # call the function to N - 2, but save the return address to $ra
		
		lw $t0, 8($sp) # store Fibonacci result, i.e, $t0 = F[N ]
		add $v0, $t0, $v0 # return result, i.e, $v0 = $t0
		
		lw $ra, 0($sp) # restore $ra
		addi $sp, $sp, 12 # clean the stack
		jr $ra # jump to the return address

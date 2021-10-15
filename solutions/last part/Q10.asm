.data
	enterN: .asciiz "N = "
	outputTerm: .ascii "Fibonacci[N]="
	N: .word 0
.text
	# input message
	li $v0, 4
	la $a0, enterN
	syscall
	# input 'N'
	li $v0, 5
	syscall
	# storing value into variable 'N'
	sw $v0, N
	
	lw $a0, N # storing 'N' into $a0
	j Fibonacci
	
	Fibonacci:
		bgt $a0, 1, Recursion # if N > 1 -> Recursion
		addi $v0, $zero, 1 # else return 1
		beqz $ra, Exit # when $ra is zero end program else continue
		jr $ra  # return to Recursion
	
	Recursion:
		addi $sp, $sp, -16 # allocating 4 registers in stack
		sw $a0, 0($sp) # save $a0 = N to the stack
		sw $ra, 4($sp) # save return address to stack

		addi $a0, $a0, -1 # compute N - 1
		jal Fibonacci # call the function to N - 1
		sw $v0, 8($sp) # $v0 = Fibonacci(N-1), save to stack

		lw $a0, 0($sp) # restore N
		addi $a0, $a0, -2  # compute N - 2
		jal Fibonacci # call the function to N - 2
		sw $v0, 12($sp) # $v0 = Fibonacci(N-2), save to stack

		lw $t0, 8($sp) # $t0 = Fibonacci(N - 1)
		lw $t1, 12($sp) # $t1 = Fibonacci(N - 2)
		lw $ra, 4($sp)
		addi $sp, $sp, 16  # clean stack

		add $v0, $t0, $t1  # $v0 = Fibonacci(N - 1) + Fibonacci(N - 2)

		beqz $ra, Exit # when $ra is zero end program else continue
		jr $ra # jump to return address

Exit:
	# ouput message
	li $v0, 4
	la $a0, outputTerm
	syscall
	
	# output term
	li $v0, 1
	move $a0, $t0
	syscall

	li $v0, 10
	syscall

.data
	enterA: .asciiz "a = "
	enterB: .asciiz "b = "
	outputSum: .ascii "a + b = "
	a: .word 0
	b: .word 0
	sum: .word 0
.text
	# input a message
	li $v0, 4
	la $a0, enterA
	syscall
	# input a
	li $v0, 5
	syscall
	# store a value into variable a
	sw $v0, a
	
	# input b message
	li $v0, 4
	la $a0, enterB
	syscall
	# input b
	li $v0, 5
	syscall
	# store b value into variable b
	sw $v0, b
	
	lw $a0, a # storing a into $a0
	lw $a1, b # storing b into $a1
	
	# check a <= b conditon
	slt $t0, $a1, $a0 # $t0 = b < a
	bne $t0, $zero, return1 # if a > b -> return1
	
	# if a <= b, make the sum
	jal findSum # calling the sum function
	sw $v0, sum
	
	# output message
	li $v0, 4
	la $a0, outputSum
	syscall
	# output sum
	li $v0, 1
	lw $a0, sum
	syscall
	
	# end of the program
	jal Exit
		

findSum:
	addi $sp, $sp, -8 # allocating 2 registers to the stack
	sw $ra, 0($sp) # the first is the return address
	sw $s0, 4($sp) # the second is the 'a' value
	
	# base case
	move $v0, $a1 # $v0 = $a1 = b
	beq $a0, $a1, sumDone # if a == b, return b
	
	# findSum(a + 1, b) and recurse
	move $s0, $a0 # storing $a0 into the stack
	addi $a0, $a0, 1 # computer a = a + 1
	jal findSum # recursion
	
	add $v0, $s0, $v0 # $v0 = a + findSum(a + 1, b)
	
	sumDone:
		lw $ra, 0($sp) # restore $ra
		lw $s0, 4($sp) # restore $a0 to $s0
		addi $sp, $sp, 8 # clean up the stack
		jr $ra # return from the function

return1: # if a > b, store 1 at $v1 and kill the program
	li $v1, 1	
	jal Exit

Exit:
	# kill the program
	li $v0, 10
	syscall

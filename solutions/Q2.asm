.data
.text
	# check the input, store the result into register $s0
	li $t0, 11 # $t0 = a
	li $t1, 15 # $t1 = b
	
	beq $t0, $zero, StoreB # if a = 0 -> break, store b
	Loop:
		beq $t1, $zero, StoreA # if b = 0, break, store a
		sgt $t2, $t0, $t1 # c = a > b
		bne $t2, $zero, If # if c = 0 -> subtract from B
		
		j Else # if a == b or a < b -> subract from A
		
		
	StoreB:
		addi $s0, $t1, 0
		j Exit
	
	StoreA:
		addi $s0, $t0, 0
		j Exit
	
	If:	# if a < b -> b -= a
		sub $t0, $t0, $t1
		j Loop
		
	Else:	# if a >= b -> a -= b
		sub $t1, $t1, $t0
		j Loop
		
	Exit:	# kill the program
		li $v0, 10
		syscall
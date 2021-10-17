.data
	String: .asciiz "EntradA"
	formatedString: .asciiz 
.text
	la $v0, String
	jal Length # calculate String's length
	addi $a3, $a0, 0 # $a3 = len(String)
	
	jal Lowercase # set characters to lower case
	
	la $a0, String
	li $t0, 0 # index i to iterate over String (String[i])
	BubbleSort:
		addi $t1, $t0, 1 # index j to iterate over String (String[i + 1])
		
		add $t2, $t0, $a0 # $t2 = i + base_address (index of i character)
		lb $s0, 0($t2) # $s0 = String[i] (String[i] is a byte character)
		whileJ:
			beq $t1, $a3, ExitWhileJ # if j == length -> ordering finish
			
			add $t2, $t1, $a0 # $t2 = j + base_address (index of i + 1 character)
			lb $s1, 0($t2) # s1 = String[j] (String[j] is a byte character)
			
			slt $t3, $s1, $s0 # $t3 = String[j] < String[i], i.e, $t3 = String[i + 1] < String[i]
			beqz $t3, noSwap # if String[i + 1] >= String[i] -> don't swap String[i] and String[j]
			
			# if String[j] < String[i], swap String[i] and String[j]
			addi $t4, $s0, 0
			la $s0, 0($s1) 
			sb $t4, 0($t2) 
			
			noSwap:
				addi $t1, $t1, 1 # j += 1
		j whileJ # go back if there is characters left to order
		
		ExitWhileJ:
			sb $s0, formatedString($t0) # formatedString[i] = $s0
			addi $t0, $t0, 1 # i = i + 1
			beq $t0, $a3, Exit # if i == length -> Exit
			
	j BubbleSort # check ordering	

Lowercase:
	WhileUppercase:
		add $t1, $t0, $v0 # $t1 = i + base_address
		lb $t2, 0($t1) # $t2 = String[i]
		
		slti $t3, $t2, 97 # $t3 = String[i] < 97 (+97 are ASCII lowercase characters)
		beq $t3, $zero, alreadyLower # if String[i] < 97 (i.e, String[i] is lowercase) -> alreadyLower
		
		addi $t3, $t2, 32 # get lowercase character
		sb $t3, 0($t1) # $a0[i] = $t2 - 32 (set to lowercase)
		
		alreadyLower:	
			addi $t0, $t0, 1 # i = i + 1
			beq $t0, $a3, loweringDone # if i == len(String) -> lowering characters done
	j WhileUppercase # go back if there is characters left to lower

	loweringDone: # when process done,
		jr $ra # go back to the main process

Length:
	li $a0, 0 # $a0 = 0, this reg will be used to store the count of characters
	ForCharacter:
		add $t1, $a0, $v0 # $t1 = i + base_address
		lb $t2, 0($t1) # $t1 = String[i]
		
		beqz $t2, lengthDone # if String[i] == NULL -> end of string
		
		addi $a0, $a0, 1 # i = i + 1
	j ForCharacter # check next character
	
	lengthDone:
		jr $ra

Exit:
	li $v0, 4
	la $a0, formatedString
	syscall
	
	li $v0, 10
	syscall
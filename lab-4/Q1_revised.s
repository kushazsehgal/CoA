    .data
i1: .asciiz "Enter four positive integers n, a, r and m :\n"
o1: .asciiz "Matrix A :\n\n"
o2: .asciiz "Final determinant of the matrix A is : "
e1: .asciiz "Please enter positive integers only.\n"
nl: .asciiz "\n"
sp: .asciiz " "

    .text
########### Program Variables #############
# n, a, r, m :          $s0, $s1, $s2, $s5
# final determinant :   $s4
# array address :       $s3
###########################################
    .globl main
main:
    jal		initStack		# jump to initStack and save position to $ra
    
    li      $v0, 4
    la      $a0, i1
    syscall             # input prompt
    
    li      $v0, 5
    syscall
    move    $s0, $v0   # cin >> n

    li      $v0, 5
    syscall
    move    $s1, $v0   # cin >> a

    li      $v0, 5
    syscall
    move    $s2, $v0  # cin >> r

    li      $v0, 5
    syscall
    move    $s5, $v0  # cin >> m
    
    jal     sanity_check

    mul     $a0, $s0, $s0 # a0 = n * n
    jal     mallocInStack 
    move    $s3, $v0      # s3 = address of array

    jal     FillMatrix    # assign gp in the matrix

    li      $v0, 4
    la      $a0, o1
    syscall                 # A printing

    jal     PrintMatrix     # print matrix


    li      $v0, 4
    la      $a0, o2
    syscall                 # determinant output prompt

    move    $a0, $s0
    move    $a1, $s3
    jal     Determinant     # determinant function call

    move    $s4, $v0        # s4 = value of determinant
    
    li      $v0, 1
    move    $a0, $s4
    syscall                 # determinant value printing

    li      $v0, 4
    la      $a0, nl
    syscall                 # cout << endl

    mul     $t0, $s0, $s0
    mul     $t0, $t0, 4
    add     $sp, $sp, $t0   # deallocating matrix A

    b	    exit            # safely terminate the program

FillMatrix:
	move    $t3, $s3  # $t3 <-- Address of Matrix
	move    $t0, $zero  # $t0 <-- 0 (current index pointer)
	move    $t1, $s1 # $t1 <-- a
	mul     $t2, $s0, $s0 # $t2 <-- ending point index (n*n) 
	
  assign_loop:
	beq     $t0, $t2, assign_loop_end # if(current idx == end pointer) end the loop
	
  assign: # else come to assign loop
	sw      $t1, 0($t3) # store the surrent gp term to the memory

	addi	$t3, 4      # increasing the current pointer
	addi    $t0, 1      # moving the current pointer by one

	mul 	$t1, $t1, $s2	 # t1 = t1 * r % m
	div		$t1, $s5			
	mfhi	$t1					
			
	b		assign_loop			# branch to loop

  assign_loop_end:
	j		$ra	

PrintMatrix:
	move    $t3, $s3  # $t3 <-- Address of A
	mul     $t2, $s0, $s0 # $t2 <-- ending point index (n*n) 
	move    $t0, $zero  # $t0 <-- 0 current pointer

  print_loop:
	beq     $t0, $t2, print_loop_end  # if current pointer == end pointer end the loop

  print: # else print the respective element
	li		$v0, 1
	lw		$a0, 0($t3)
	syscall

	addi	$t3, 4
	addi    $t0, 1

	div		$t0, $s0			
	mfhi	$t4					
	
	beq		$t4, $zero, NewLine # if one row has printed then print a new line 
    
    Space: # else print a space for the next character
        la  $a0, sp
        b	PrintChar
    NewLine:
        la  $a0, nl
    PrintChar:
        li	$v0, 4
        syscall
        b	print_loop
        
  
  print_loop_end:
	j		$ra	
	
Determinant:
    move    $t0, $ra    # store $ra temporarily
    jal     initStack   # initialise sp and fp
    move    $t1, $a0    # store n temporarily
    
    move    $a0, $t0    # push old ra to stack (fp-4)
    jal     pushToStack
    move    $a0, $s0    # push old s0 to stack (fp-8)
    jal     pushToStack
    move    $a0, $s1    # push old s1 to stack (fp-12)
    jal     pushToStack
    move    $a0, $s2    # push old s2 to stack (fp-16)
    jal     pushToStack
    move    $a0, $s3    # push old s3 to stack (fp-20)
    jal     pushToStack
    move    $a0, $s4    # push old s4 to stack (fp-24)
    jal     pushToStack
    move    $a0, $s5    # push old s5 to stack (fp-28)
    jal     pushToStack

    move    $s0, $t1    # store n in $s0
    move    $s1, $a1    # store A base address in $s1
    li      $s2, 0      # initial column index = 0

    # allocate memory for A'
    addi    $t0, $s0, -1    # $t0 = n - 1
    mul     $a0, $t0, $t0   # $a0 = (n-1)*(n-1)
    jal     mallocInStack   # call mallocInStack with argument n-1*n-1
    move    $s3, $v0        # store return value, i.e. base address of A' in $s3

    li      $s4, 0      # initialise current sum to 0
    li      $s5, 1      # initialise current sign to +1

    bgt     $s0, 1, RFC # if(n > 1) recursive function call

Determinant_base_case: 
    lw      $s4, 0($s1)     # for n=1 answer is the single matrix element itself

Determinant_return:
    addi    $t0, $s0, -1    # $t0 = n - 1
    mul     $t0, $t0, $t0   # $t0 = (n-1)*(n-1)
    mul     $t0, $t0, 4     # $t0 = 4*(n-1)*(n-1)
    add     $sp, $sp, $t0   # deallocate A'

    move    $t0, $s4        # temporarily store the sum to return

    jal     popFromStack
    move    $s5, $v0        # restore $s5
    jal     popFromStack
    move    $s4, $v0        # restore $s4
    jal     popFromStack
    move    $s3, $v0        # restore $s3
    jal     popFromStack
    move    $s2, $v0        # restore $s2
    jal     popFromStack
    move    $s1, $v0        # restore $s1
    jal     popFromStack
    move    $s0, $v0        # restore $s0
    jal     popFromStack
    move    $ra, $v0        # restore $ra

    move    $v0, $t0        # store the sum to return in $v0

    lw      $fp, 0($sp)     # restore frame pointer
    addi    $sp, $sp, 4     # restore stack pointer

    jr      $ra             # return

Cofactor_Matrix: # (n, A, col, A')
    move    $t0, $s0
    move    $t1, $zero          # col = 0
    addi    $t2, $zero, 1       # row = 0
    move    $t4, $s3            # t4 <-- address of the cofactor matrix
  cofactor_loop:                # loop on col
    beq     $t1, $t0, cofactor_loop_end         # if col value becomes n then we end the loop
    beq     $t1, $s2, col_increment_and_loop    # if col value equals the specified cofactor value then we skip the computation and run the loop
    cofector_inner_loop:        # loop on row
      beq   $t2, $t0, col_increment_and_loop    # if row value becomes n then we return to the outer loop
      mul   $t3, $t2, $t0                       
      add   $t3, $t3, $t1       # t3 = row * n + col
      mul   $t3, $t3, 4         # t3 *= 4
      add   $t3, $t3, $s1       # t3 <-- address of A[row][col]
      lw    $t3, 0($t3)         # t3 <-- A[row][col]
      sw    $t3, 0($t4)         # store the value of t3 to the cofactor matrix
      addi  $t4, $t4, 4         # increase the cofactor matrix pointer
      addi  $t2, $t2, 1         # row++
      b		cofector_inner_loop # goto the inner loop
    col_increment_and_loop:
      li    $t2, 1              # row = 1
      addi  $t1, $t1, 1         # col++
      b     cofactor_loop       # goto cofactor_loop
  cofactor_loop_end:
    jr      $ra

RFC:
    move    $s2, $zero # current coloumn
  RFC_loop:
    beq     $s2, $s0, Determinant_return # if the current coloumn reaches the end then we simply return the determinant value
    
    jal     Cofactor_Matrix # calling the cofactor matrix function 

    addi    $a0, $s0, -1    # a0 = n-1
    move    $a1, $s3        # a1 = address of the cofactor matrix
    jal     Determinant     # calculate the determinant of the cofactor
    mul     $t0, $s2, 4     
    add     $t1, $s1, $t0
    lw      $t0, 0($t1)     # t0 <-- value at A[0][col]
    mul     $t1, $t0, $v0   # t1 <-- t0 * det(cofactor matrix)
    mul     $t1, $t1, $s5   # t1 <-- t1 * sign
    mul     $s5, $s5, -1    # reversing the sign
    add     $s4, $s4, $t1   # sum = sum + t1
    addi    $s2, $s2, 1     # col++
    b		RFC_loop        # run the loop again

sanity_check:               # check if all the given inputs are greater than zero or not
    ble     $s0, $zero, error
	ble     $s1, $zero, error
	ble     $s2, $zero, error
	ble		$s5, $zero, error
	j		$ra

initStack:                  # store the old frame pointer in the stack
    addi    $sp, $sp, -4
    sw      $fp, 0($sp)
    move 	$fp, $sp
    jr      $ra

mallocInStack:              # assign a specified amount of memory for storing an array and return its address in $v0
    mul     $a0, $a0, 4
    sub     $sp, $sp, $a0
    move    $v0, $sp
    jr      $ra

pushToStack:                # push the specified element to the stack
    addi    $sp, $sp, -4
    sw      $a0, 0($sp)
    jr      $ra

popFromStack:               # pop element from the stack and return its value in $v0
    lw      $v0, 0($sp)
    add     $sp, $sp, 4
    jr      $ra

error:
    li      $v0, 4
    la      $a0, e1
    syscall             # print the error message and go to main for taking the values again
    b		main

exit:
    li      $v0, 10
    syscall

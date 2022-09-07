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

    li      $v0, 1
    move    $a0, $s0
    syscall                 ###

    move    $a0, $s0
    move    $a1, $s3
    jal     Determinant     # determinant function call

    # ##################
    # li      $v0, 4
    # la      $a0, i1
    # syscall  
    ##################

    move    $s4, $v0        # s4 = value of determinant
    

    li      $v0, 1
    move    $a0, $s4
    syscall                 # determinant value printing

    li      $v0, 4
    la      $a0, nl
    syscall

    mul     $t0, $s0, $s0
    mul     $t0, $t0, 4
    add     $sp, $sp, $t0

    b	    exit

FillMatrix:
	move    $t3, $s3  # $t3 <-- Address of Matrix
	move    $t0, $zero  # $t0 <-- 0
	move    $t1, $s1 # $t1 <-- a
	mul     $t2, $s0, $s0 # $t2 <-- ending point index (n*n) 
	
  assign_loop:
	beq     $t0, $t2, assign_loop_end
	b       assign
	
  assign_loop_end:
	j		$ra	

  assign:
	sw      $t1, 0($t3)

	addi	$t3, 4
	addi    $t0, 1

	mul 	$t1, $t1, $s2	
	div		$t1, $s5			
	mfhi	$t1					
			
	b		assign_loop			# branch to loop


PrintMatrix:
	move    $t3, $s3  # $t3 <-- Address of A
	mul     $t2, $s0, $s0 # $t2 <-- ending point index (n*n) 
	move    $t0, $zero  # $t0 <-- 0

  print_loop:
	beq     $t0, $t2, print_loop_end
	b		print
	
  print_loop_end:
	j		$ra	

  print:
	li		$v0, 1
	lw		$a0, 0($t3)
	syscall

	addi	$t3, 4
	addi    $t0, 1

	div		$t0, $s0			# $t0 / $t1
	mfhi	$t4					# $t3 = $t0 mod $t1 
	
	beq		$t4, $zero, NewLine
    
    Space:
        la  $a0, sp

    PrintChar:
        li	$v0, 4
        syscall
        b	print_loop
        
    NewLine:
        la  $a0, nl
        b	PrintChar
	
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
    jal     mallocInStack   # call mallocInStack with argument n*n
    move    $s3, $v0        # store return value, i.e. base address of A' in $s3

    li      $s4, 0      # initialise current sum to 0
    li      $s5, 1      # initialise current sign to +1

    bgt     $s0, 1, RFC # if(n > 1) recursive function call

Determinant_base_case:
    # li      $v0, 4
    # la      $a0, i1
    # syscall  
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

    #################
    li      $v0, 4
    la      $a0, i1
    syscall  
    #################

    jr      $ra             # return

Cofactor_Matrix: # (n, A, col, A')
    move    $t0, $s0
    move    $t1, $zero # col
    addi    $t2, $zero, 1 # row
    move    $t4, $s3
  cofactor_loop:
    beq     $t1, $t0, cofactor_loop_end
    beq     $t1, $s2, col_increment_and_loop
    cofector_inner_loop:
      beq   $t2, $t0, col_increment_and_loop
      mul   $t3, $t2, $t0
      add   $t3, $t3, $t1
      mul   $t3, $t3, 4
      add   $t3, $t3, $s1
      lw    $t3, 0($t3)
      sw    $t3, 0($t4)
      addi  $t4, $t4, 4
      addi  $t2, $t2, 1
      b		cofector_inner_loop
    col_increment_and_loop:
      li    $t2, 1
      addi  $t1, $t1, 1
      b     cofactor_loop
  cofactor_loop_end:
    jr      $ra

RFC:
    #################
    # li      $v0, 4
    # la      $a0, i1
    # syscall  
    #################
    move    $s2, $zero # current coloumn
  RFC_loop:
    beq     $s2, $s0, Determinant_return
    jal     Cofactor_Matrix
    addi    $a0, $s0, -1
    move    $a1, $s3
    jal     Determinant
    mul     $t0, $s2, 4
    add     $t1, $s1, $t0
    lw      $t0, 0($t1)
    mul     $t1, $t0, $v0
    mul     $t1, $t1, $s5
    mul     $s5, $s5, -1
    add     $s4, $s4, $t1  
    addi    $s2, $s2, 1  
    b		RFC_loop

sanity_check:
    ble     $s0, $zero, error
	ble     $s1, $zero, error
	ble     $s2, $zero, error
	ble		$s5, $zero, error
	j		$ra

initStack:
    addi    $sp, $sp, -4
    sw      $fp, 0($sp)
    move 	$fp, $sp
    jr      $ra

mallocInStack:
    mul     $a0, $a0, 4
    sub     $sp, $sp, $a0
    move    $v0, $sp
    jr      $ra

pushToStack:
    addi    $sp, $sp, -4
    sw      $a0, 0($sp)
    jr      $ra

popFromStack:
    lw      $v0, 0($sp)
    add     $s0, $sp, 4
    jr      $ra

error:
    li      $v0, 4
    la      $a0, e1
    syscall
    b		main

exit:
    li      $v0, 10
    syscall
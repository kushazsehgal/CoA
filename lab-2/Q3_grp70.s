################################################
# Assignment 2 - CS31001
# Q3. Compute matrices A and B as described and display the matrices
# Team Details - 
# Kushaz Sehgal - 20CS30030
# Jay Kumar Thakur - 20CS30024
#################################################

# Declaring String Prompts
    .data
prompt1:                                    # Prompt for taking m, n, a, r
    .asciiz "Enter four positive  numbers m, n, a and r:\n"
error:                                      # error prompt if any of given numbers are negative
    .asciiz "Error : number(s) is/are negative!\n\n"
promptA:                                    # prompt to display A
    .asciiz "Matrix A :\n\n"        
promptB:                                    # prompt to display B
    .asciiz "Matrix B :\n\n"
tab:
    .asciiz "\t"                           
newline:
    .asciiz "\n"

# Instructions Start Here
# main : Program Variables -
# $fp points to top of stack
# fp :  0($fp)
# m  : -4($fp)
# n  : -8($fp)  
# a  : -12($fp)
# r  : -16($fp)
# $s0 : points to first element of Matrix A
# $s1 : points to first element of Matrix B


    .text
    .globl main

main:

    jal     initStack                       # call initStack to set up stack and frame pointer
    move    $s0, $sp                        # save stack pointer in $s0

    # printing input prompt     
    la      $a0,prompt1                     # loads address of prompt1 in first argument register
    li      $v0,4                           # system call to print string (printing prompt1)
    syscall

    #Reading all integers

    li      $v0,5                           # system call to read integer
    syscall
    move    $a0,$v0                         # $v0 stores m, which is moved to $a0
    jal		pushToStack			            # link and jump to pushToStack
    

    li      $v0,5                           # system call to read integer
    syscall
    move    $a0,$v0                         # $v0 stores n, which is moved to $a0
    jal		pushToStack			            # link and jump to pushToStack

    li      $v0,5                           # system call to read integer
    syscall
    move    $a0,$v0                         # $v0 stores a, which is moved to $a0
    jal		pushToStack			            # kink and jump to pushToStack

    li      $v0,5                           # system call to read integer
    syscall
    move    $a0,$v0                         # $v0 stores r, which is moved to $a0
    jal		pushToStack			            # link and jump to pushToStack

    # Checking numbers are positive
    bltz    $s0,negative_error              # if $s0 < 0, branch to negative error (m is negative)
    bltz    $s1,negative_error              # if $s1 < 0, branch to negative error (n is negative)
    bltz    $s2,negative_error              # if $s2 < 0, branch to negative error (a is negative)
    bltz    $s3,negative_error              # if $s3 < 0, branch to negative error (r is negative)

    # Allocating Memory for Matrix A
    lw      $t0,-4($fp)                     # t0 <--- M[fp - 4] a0 stores m
    lw      $t1,-8($fp)                     # t1 <--- M[fp - 8] a1 stores n
    mul     $a0,$t0,$t1                     # $a0 = m*n
    jal     mallocInStack                   # link then jumping to allocating memory to Matrix A
    move    $s0,$v0                         # storing address of first element of Matrix A in $s0

    # Allocating Memory for Matrix B
    lw      $t0,-4($fp)                     # t0 <--- M[fp - 4] a0 stores m
    lw      $t1,-8($fp)                     # t1 <--- M[fp - 8] a1 stores n
    mul     $a0,$t0,$t1                     # $a0 = m*n
    jal     mallocInStack                   # link then jumping to allocating memory to Matrix B
    move    $s1,$v0                         # storing address of first element of Matrix B in $s0
    
    # filling Values in Matrix A
    jal     fillA                           # link then jumping to fillA to populate matrix A

    # Calling Transpose
    move    $a0,$s0                         # $a0 points to first element of Matrix A
    move    $a1,$s1                         # $a1 points to first element of Matrix B
    lw      $a2,-4($fp)                     # $a2 <--- M[fp - 4] a0 stores m
    lw      $a3,-8($fp)                     # $a3 <--- M[fp - 8] a1 stores n
    jal     transpose                       # link and jump to transpose with corresponding arguments


    la      $a0,promptA                     # loads address of promptA in first argument register
    li      $v0,4                           # system call to print string (printing promptA)
    syscall
    
    # Printing Matrix A
    move    $a0,$s0                         # $a0 points to first element of Matrix A
    lw      $a1,-4($fp)                     # $a1 <--- M[fp - 4] a1 stores m
    lw      $a2,-8($fp)                     # $a2 <--- M[fp - 8] a2 stores n
    jal     printMatrix                     # link and jump to printMatrix with corresponding arguments

    la      $a0,promptB                     # loads address of promptB in first argument register
    li      $v0,4                           # system call to print string (printing promptB)
    syscall

    # Printing Matrix B
    move    $a0,$s1                         # $a0 points to first element of Matrix B
    lw      $a1,-8($fp)                     # $a2 <--- M[fp - 4] a1 stores n
    lw      $a2,-4($fp)                     # $a3 <--- M[fp - 8] a2 stores m
    jal     printMatrix                     # link and jump to printMatrix with corresponding arguments

    # Calling Free Stack
    b		freeStack				        # b to freeStack
    
fillA:
    li      $t0,0                           # initializing $t0 to 0
    lw      $t1,-4($fp)                     # t1 <--- M[fp - 4] t0 stores m
    lw      $t2,-8($fp)                     # t2 <--- M[fp - 8] t1 stores n
    mul     $t3,$t1,$t2                     # $t3 = m*n
    move    $a0,$s0                         # $a0 points to first element of Matrix A
    lw      $a1,-12($fp)                    # $a1 <--- M[fp - 12] a1 stores a
    lw      $a2,-16($fp)                    # $a2 <--- M[fp - 16] a2 stores r
    b		Aloop			                # branch to Aloop
Aloop:
    sw      $a1,0($a0)                      # store value in matrix element
    mul     $a1,$a1,$a2                     # value = value * r
    addi    $a0,-4                          # a0 points to next element in matrix
    addi    $t0,$t0,1                       # $t0 = $t0 + 1
    blt     $t0,$t3,Aloop                   # branch to Aloop if t0 < m*n
    jr      $ra                             # jump to return address  

printMatrix:
    move    $t0,$a0                         # $t0 points to first element of Matrix         
    move    $t1,$a1                         # $t1 = m (rows in matrix)
    move    $t2,$a2                         # $t2 = n  (cols in matrix)
    li      $t3,0                           # initialize t3 = 0
    b		outerloop			            # branch to outerloop
outerloop:
    li      $t4,0
    blt     $t3,$t1,innerloop               # if row < m , go inside inner loop
    jr      $ra                             # jump to return address

innerloop:
    lw      $a0,0($t0)                      # printing Matrix element at $t0  
    li      $v0,1
    syscall
    la      $a0,tab                         # printing tab
    li      $v0,4
    syscall
    addi    $t0,$t0,-4                       # $t0 points to next element in Matrix
    addi    $t4,$t4,1                        # $t4 += 1
    blt     $t4,$t2,innerloop                # if t4 < n that is, if row printing not finished go back to loop
    la      $a0,newline                      # printing new line to start new row
    li      $v0,4           
    syscall
    addi    $t3,$t3,1                        # $t3 += 1
    b		outerloop			             # branch to outerloop


transpose:
    move    $t0, $a0                          # $t0 points to first element of Matrix A
    move    $t1, $a1                          # $t1 points to first element of Matrix B
    move    $t2, $a2                          # $t2 = m
    move    $t3, $a3                          # $t3 = n
    li      $t4, 0                            # $t4 = i = 0
    b		transpose_outer			          # branch to transpose_outer 

transpose_outer:

    li      $t5,0                             # $t5 = j = 0
    blt		$t4, $t2, transpose_inner	      # if $t4 < $t2 (i < m) then branch totranspose_inner
    jr      $ra    

transpose_inner:

    lw      $t6,0($t0)                        # Get A[i][j]
    mul     $t7,$t2,$t5                       # $t7 = m * j
    add     $t7, $t7, $t4                     # $t7 = m * j + i
    sll     $t7, $t7, 2                       # $t7 = 4 * (m * j + i)
    sub     $t7, $t1, $t7                     # $t7 points to address of B[j][i]
    sw      $t6, 0($t7)                       # Set B[j][i] = A[i][j]
    addi    $t5,$t5,1
    addi    $t0,$t0,-4                        # $t0 points to next element of Matrix A 
    blt     $t5,$t3,transpose_inner           # if $t5 < $t3 (j < n) then repeat loop
    addi    $t4,$t4,1                         # $t4 += 1 (i += 1)
    b		transpose_outer			          # branch to transpose_outer (continue to next row)
    
negative_error:
    la      $a0,error                         # loads address of error in first argument register
    li      $v0,4                             # system call to print string (printing error)
    b		main			                  # branch to main

# Initlialize stack and frame pointer
initStack:
    addi    $sp,$sp,-4                        # decrease sp by 4 to allocate memory for $fp
    sw      $fp,0($sp)                        # Store frame pointer
    move    $fp,$sp                           # Make $fp point to current stack top before program execution
    jr      $ra                               # jump to return address
# Allocate memory to $a0 in stack
pushToStack:
    addi    $sp,$sp,-4                        # decrease sp by 4 to allocate memory for $a0
    sw      $a0,0($sp)                        # Store $a0 in stack
    jr      $ra                               # jump to return address

# Allocate memory for $a0 integers in stack
mallocInStack:
    sll     $t0,$a0,2                         # $t0 = $a0 * 4 = 4*m*n
    addi    $v0,$sp,-4                        # Storing address of first element in return value                   
    sub		$sp, $sp, $t0		              # $sp = $sp - $t0 (Allocating 4*m*n bytes)
    jr      $ra                               # jump to return address

freeStack:
    addi    $fp,$fp,-4
    move    $sp, $fp                          # before ending the program, restore the stack pointer
    # Terminating Progra
    j       exit                              # unconditional jump to exit
exit:
    li      $v0, 10                         
    syscall                                   # syscall for exit
    
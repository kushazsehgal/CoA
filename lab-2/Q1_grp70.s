################################################
# Assignment 2 - CS31001
# Q1. Implement Booth's Algorithm to multiply 2 16 bit signed integers
# Team Details - 
# Kushaz Sehgal - 20CS30030
# Jay Kumar Thakur - 20CS30024
#################################################

# Declaring String Prompts
    .data
prompt1:                                    # Prompt for taking in 1st integer as input
    .asciiz "Enter First Number : "
prompt2:
    .asciiz "Enter Second Number : "        # Prompt for taking in 2nd integer as input
error:
    .asciiz "Error : number(s) is/are outside 16 bit signed integer numerical range!\n\n"
output:
    .asciiz "Product of 2 given numbers is : "

# Instructions Start Here
# main : Program Variables -
# n1 : $s0
# n2 : $s1  
# product : $s2
# 16 bit upperbound (32767) : $t0
# 16 bit lowerbound (-32768) : $t1

    .text
    .globl main

main:
    li      $t0,32767                       # 16 bit upperbound
    li      $t1,-32768                      # 16 bit lowerbound

    #read n1
    la      $a0,prompt1                     # loads address of prompt1 in first argument register
    li      $v0,4                           # system call to print string (printing prompt1)
    syscall
    li      $v0,5                           # system call to read integer
    syscall
    move    $s0,$v0                         # $v0 stores n1, which is moved to $s0

    #read n2
    la      $a0,prompt2                     # loads address of prompt2 in first argument register
    li      $v0,4                           # system call to print string (printing prompt2)
    syscall
    li      $v0,5                           # system call to read integer
    syscall
    move    $s1,$v0                         # $v0 stores  n2, which is moved to $s1

    bgt		$s0, $t0, out_of_range_error	# if $s0 > $t0 then error (n1 greater than upperbound)
    bgt		$s1, $t0, out_of_range_error	# if $s1 > $t0 then error (n2 greater than upperbound)

    blt		$s0, $t1, out_of_range_error    # if $s0 < $t1 then error (n1 lesser than lowerbound)
    blt		$s1, $t1, out_of_range_error    # if $s1 < $t1 then error (n2 greater than lowerbound)
    
    # call booth's multiplication algorithm
    move    $a0,$s1                         # initializing value of M = n2 stored in $s0 into $a0
    move    $a1,$s0                         # initializing value of A = n1 stored in $s1 into $a1
    jal     multiply_booth                  # link and jump to multiply_booth

    # store product in s2
    move    $s2,$v0                        # s2 stores return value from multiply_booth, that is product of n1 and n2

    # printing output string
    la      $a0, output                     # loads address of output in first argument register
    li      $v0, 4                          # system call to print string (printing output)
    syscall
    # printing product
    move    $a0, $s2                        # setting s2 (product of n1 and n2) in first argument register
    la      $v0,1                           # system call to print int (printing s2)
    syscall

    b		end			                    # branch to end
                    

out_of_range_error:
    la      $a0,error                       # loads address of error in first argument register
    li      $v0,4                           # system call to print string (printing error)
    syscall
    b		main			                # branch to main
    
end:
    li      $v0, 10                         # terminate program
    syscall


# multiply_booth : Program Variables -
# M : $a0 
# Accumulator (A) : $a1
# -M : $a2  --> Not used anymore
# count (16) : $t0
# Q_0 : $t1
# Q_-1 : $t2
# MASK : t4

multiply_booth:

    li      $t4,1                           # initializing MASK = 1
    # Making First 16 bits of MASK 0
    sll     $t4,$t4,16                      # MASK = MASK << 16 (MASK = 2^16))
    addi    $t4,$t4,-1                      # MASK = MASK - 1 (first 16 bits will be 0 and last 16 bits will be 1)
    sll		$a0, $a0, 16			        # $a0 = $a0 << 16 , left shift M by 16 bits
    # and of MASK and a1
    and     $a1,$a1,$t4                     # to ensure first 16 bits of A are 0

    move  	$t2, $zero		                # intializing  value of Q_-1  = 0
    
    li      $t0,16                          # intializing value of count = 16
    
    b		iterate			                # branch to iterate

iterate:

    andi	$t1, $a1, 1			            # setting Q_0 = LSB of A, $t1 = $a1 & 1
    # Checking case using temp register $t3
    xor		$t3, $t1, $t2		            # $t3 = $t1 ^ $t2 , if t3 == 0 meaning both Q_0 and Q_-1 are 0 or 1
    beq     $t3,$zero,right_shift           # if $t3 == 0, branch to right shift

    b		case_check			            # branch to case_check

right_shift:    
    
    move    $t2,$t1                         # get LSB of A (Q_0) into $t2 (Q_-1)
    sra     $a1, $a1, 1                     # arithmetic right shift A by 1 bit
    
    addi    $t0,$t0,-1                      # add -1 to n, n = n - 1

    bgtz    $t0, iterate

    # if n == 0, store Q in return value, that is $v0 = $a1
    move    $v0,$a1
    jr		$ra					            # jump to $ra (jump to line 59 in main) 

case_check:
    #We come here if exactly one of Q_0 and Q_-1 is 1
    beqz    $t1,add_m                       # if Q_0 = 0 and Q_-1 = 1 branch to add_m 
    b		subs_m			                # else of Q_0 = 1 and Q_-1 = 0 branch to subs_m
add_m:
    add     $a1,$a1,$a0                     # A = A + M
    b		right_shift			            # branch to right_shift
    
subs_m:
    sub		$a1, $a1, $a0		            # $a1 = $a1 - $a0 (A = A - M)
    # add     $a1,$a1,$a2                     # A = A - M
    b		right_shift			            # branch to right_shift
    
    

    


    
    

    






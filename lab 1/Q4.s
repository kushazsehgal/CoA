# Assignment 1 CS31001
# Q4. Check whether a given number is a "perfect number"
# Team Details - 
# Kushaz Sehgal     20CS30030
# Jay Kumar Thakur  20CS30024

    .globl main

    .data

prompt:
    .asciiz     "Enter a positive integer : "
errorstring:
    .asciiz     "Please enter a positive integer!\n\n"
isperfect:
    .asciiz     "Entered number is a perfect number!\n"
isnotperfect:
    .asciiz     "Entered number is not a perfect number!\n"

    .text

# Program Variables :
#   n:          $s0
#   i:          $s1 
#   sum:        $s2
#   quoitient:  $s3
#   remainder:  $s4


main:
    li      $v0,4
    la      $a0,prompt
    syscall

    li      $v0,5
    syscall
    move    $s0,$v0  

    ble     $s0,$zero,err

    li      $s1,1
    li      $s2,0

    b       loop

loop:
    bge     $s1,$s0,checkperfectness
    div		$s0, $s1			# $s0 / $t1
    mflo	$s3				    # $s3 = floor($s0 / $s1) quotient
    mfhi	$s4				    # $s4 = $s0 mod $s1     remainder
    
    beq     $s4,$zero,add_divisor
    b		increment		# branch to increment
    
add_divisor:
    add     $s2,$s2,$s1
    b		increment			# branch to increment

increment:
    addi    $s1,$s1,1
    b       loop

checkperfectness:
    beq     $s0,$s2,printperfect
    b		printnotperfect			# branch to printnotperfect

printnotperfect:
    li      $v0,4
    la      $a0,isnotperfect
    syscall
    b		exit			# branch to exit

printperfect:
    li      $v0,4
    la      $a0,isperfect
    syscall
    b		exit			# branch to exit
    
err:
    li      $v0,4
    la      $a0,errorstring
    syscall

    b		main			# branch to main

exit:
    li      $v0, 10         # terminate the program
    syscall
    



    







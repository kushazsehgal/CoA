    .globl main

    .data
inputstring:
    .asciiz "Enter N : "
outputstring1:
    .asciiz "The sum of first "
outputstring2:
    .asciiz " numbers is : "
newline:
    .asciiz "\n"

    .text
# program variables
#   n:   $s0
#   sum: $s1
#   i:   $s2

main:
    li      $v0,4
    la      $a0,inputstring
    syscall

    li      $v0,5
    syscall
    
    move      $s0,$v0
    
    li      $s1,0
    li      $s2,0
    # syscall
loop:
    blt     $s0,$s2,afterloop
    add     $s1,$s1,$s2
    addi    $s2,$s2,1
    b       loop

afterloop:
    li      $v0,4
    la      $a0,outputstring1
    syscall

    li      $v0,1
    move    $a0,$s0
    syscall

    li      $v0,4
    la      $a0,outputstring2
    syscall

    li      $v0,1
    move    $a0,$s1
    syscall

    li      $v0,4
    la      $a0,newline
    syscall
    
    li      $v0,4
    la      $a0,newline
    syscall

    li      $v0, 10         # terminate the program
    syscall
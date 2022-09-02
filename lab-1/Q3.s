# Assignment 1 CS31001
# Q3. Check whether a given number is prime number or a composite number
# Team Details - 
# Kushaz Sehgal     20CS30030
# Jay Kumar Thakur  20CS30024
    .globl main
    .data
i1:		.asciiz "Enter a positive integer greater than equals to 10 : "
err:	.asciiz "Invalid Input!\n\n"
o1:		.asciiz "Entered number is a "
ans1:	.asciiz "PRIME number\n\n"
ans2:	.asciiz "COMPOSITE number\n\n"

	.text
# 	Program Variables : 
#	n : 		$s0
#	i : 		$s1
#	const_10 : 	$s2
#	tmp	: 		$s4

main:
	# printing input prompt
	li		$v0, 4							# call print string							
	la		$a0, i1							# assign input prompt as first argument
	syscall

	li		$v0, 5							# reading integer (n)
	syscall
	move 	$s0, $v0						# move n into s0 to store it

	li		$s1, 2							# initializing i = 2
	li 		$s2, 10							# initializing const_10 to 10

	blt 	$s0, $s2, error

	
	# printing initial output statement "Entered number is a "
	li 		$v0, 4							# call print string
	la		$a0, o1							# assign output string as first argument
	syscall
	
	b		loop							# branch to start loop

loop:
	bge 	$s1, $s0, print_ans1

	# Calculation remainder when n is divided by i
	div 	$s0, $s1									
	mfhi	$s4											# $s4 = $s0 % $s1 (remainder)
	
	beq 	$s4, $zero, print_ans2						# if remainder = 0, exit out of loop as n has a factor
	
	addi 	$s1, $s1, 1									# increment i (i = i + 1)  
	
	b		loop 										# branch to loop


# Print Number is Prime
print_ans1:
	li		$v0, 4										# call print string
	la		$a0, ans1									# assign prime string as first argument
	syscall
	b 		exit										# branch to exit

# Print Number is Composite
print_ans2:
	li		$v0, 4										# call print string
	la		$a0, ans2									# assign composite string as first argument
	syscall
	b 		exit										# branch to exit

# Print Error String
error:
	li		$v0, 4
	la		$a0, err
	syscall
	b		main										# branch to main to take input again

# Termination of Code
exit:
	li		$v0, 10
	syscall
# Assignment 1 CS31001
# Q2. To find the GCD of two numbers a and b
# Team Details - Group 70
# Kushaz Sehgal     20CS30030
# Jay Kumar Thakur  20CS30024

	.globl main
	
	.data
# ... INPUT STRINGS
i1:     .asciiz "Enter a : "
i2:     .asciiz "Enter b : "
# ... OUTPUT STRINGS
o1:     .asciiz "The GCD of "
o2:     .asciiz " and "
o3:     .asciiz " is : "
# ... ERROR STRINGS
err:    .asciiz "Invalid Input!\n\n"

	.text
#   a :         $s0
#   b :         $s1

main:
	li		$v0, 4
	la		$a0, i1
	syscall							# printf("Enter a : ");

	li		$v0, 5
	syscall							# scanf("%d, &a)
	move	$s0, $v0

	li		$v0, 4					
	la		$a0, i2
	syscall							# printf("Enter b : ");

	li		$v0, 5
	syscall							# scanf("%d", &b);
	move	$s1, $v0
	
	li		$zero, 0

	blt		$s0, $zero, error			# if(a < 0) throw error
	blt		$s1, $zero, error			# if(b < 0) throw error

	# ... 							printf("The GCD of %d and %d is : ", a, b);
	li		$v0, 4
	la		$a0, o1
	syscall

	li		$v0, 1
	move	$a0, $s0
	syscall

	li		$v0, 4
	la		$a0, o2
	syscall

	li		$v0, 1
	move	$a0, $s1
	syscall

	li		$v0, 4
	la		$a0, o3
	syscall
	# ...

	beq		$s0, $zero, print_b	# if(a == 0) printf("%d", b);
	
loop:
	beq		$s1, $zero, print_a	# if(b == 0) printf("%d", a);
	bgt		$s0, $s1, update_a	# if(a > b) a = a - b;
	b		update_b			# else b = b - a;
	
update_a:
	sub		$s0, $s0, $s1
	b		loop

update_b:
	sub		$s1, $s1, $s0
	b		loop
	
print_a:						# if answer is a then print the value of a and terminate
	li		$v0, 1
	move	$a0, $s0
	syscall
	b		exit

print_b:						# if answer is b then print the value of b and terminate
	li		$v0, 1
	move	$a0, $s1
	syscall
	b		exit

error:							# if the entered number is negative then print error
	li		$v0, 4
	la		$a0, err
	syscall
	b		main

exit:							# exit statement to safely terminate the program
	li		$v0, 10
	syscall
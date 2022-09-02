###################################################################
# Assignment 2 CS31001
# Q2. To find the kth largest number in the array of 10 integers
# Team Details - Group 70
# Kushaz Sehgal     20CS30030
# Jay Kumar Thakur  20CS30024
###################################################################

	.data
	
# ARRAY OF SIZE 10
array:  .space 40

# INPUT SRINGS
i1:     .asciiz "Enter 10 integers :"
i2:     .asciiz "Enter k : "
i3:		.asciiz "#"
i4:		.asciiz " : "
i5:		.asciiz "Array after sorting is : "
newl:	.asciiz "\n"

# OUPUT STRING
o1:     .asciiz "kth largest number is : "
space:	.asciiz " "

# ERROR STRING
err:    .asciiz "Invalid k!"

	.text 
	.globl main

# program variables
# k 	: $s0
# i, j 	: $s1, $s2
# tmp 	: $s3, $s4
# array	: $s5 (array address)

check_k:						# if(k > n || k <= 0) print error
	ble		$s0, 0, error
	bgt		$s0, 10, error
	j		$ra

swap:
	la		$s5, array			# $s5 <-- address of the array
	add		$s5, $s5, $s2		# $s5 <-- address of array[j]
	lw		$s3, ($s5)			# $s3 <-- array[j]
	addi	$s5, $s5, 4			# $s5 <-- address of array[j + 1]
	lw		$s4, ($s5)			# $s4 <-- array[j + 1]

	sw		$s3, ($s5)			# address of array[j + 1] <-- value of array[j]
	addi	$s5, $s5, -4		# $s5 <-- address of array[j]
	sw		$s4, ($s5)			# address of array[j] <-- value of array[j + 1]
	j		$ra

bubble_sort:
	move 	$t0, $ra			# saving the return address to $t0
	li		$s1, 0				# i = 0

	loop_i:
		li		$s2, 0			# j = 0
		blt		$s1, 40, loop_j # while(i < 40) run the j loop
		b		end_loop
	
	loop_j:	
		li		$s3, 36			
		la		$s5, array
		sub		$s3, $s3, $s1	# $s3 = 36 - i
		blt		$s2, $s3, swapping_condition # if(j < 36 - i) goto swapping condition
		addi	$s1, $s1, 4					 # else increment the value of i by 4 and goto the i loop
		b		loop_i

	swapping_condition:
		add		$s5, $s5, $s2	# $s5 <-- address of array[j]
		lw		$s3, ($s5)		# $s3 <-- value of array[j]
		addi	$s5, $s5, 4		# $s5 <-- address of array[j + 1]
		lw		$s4, ($s5)		# $s4 <-- value of array[j + 1]
		ble		$s3, $s4, after_swap # if(array[j] <= array[j+1]) do not swap their values
		jal		swap				 # else call the swap function
	after_swap:
		addi	$s2, $s2, 4		# increment the value of j and continue the j loop
		b 		loop_j
	end_loop:
		jr		$t0 			# return $t0

###################### ARRAY PRINTING ###############################
array_printing: # This function prints the array and has been created for debugging purposes
	la		$s1, array
	li		$s2, 0
	
	li  	$v0, 4
	la  	$a0, i5
	syscall

printing:
	beq		$s2, 10, return
	addi	$s2, $s2, 1

	li		$v0, 1
	lw		$a0, ($s1)
	syscall

	li		$v0, 4
	la		$a0, space
	syscall

	addi	$s1, $s1, 4
	b		printing			# branch to printing
	
return:
	li  	$v0, 4
	la  	$a0, newl
	syscall

	jr		$ra	
#######################################################################}

print_ans:
	li		$v0, 4		
	la		$a0, o1
	syscall					# printf("kth largest number is : ");

	la		$s5, array
	addi	$s0, $s0, -1	# k--
	mul 	$s1, $s0, 4		# i = k * 4
	add		$s5, $s5, $s1	# $s5 = address of the ith index of the array
	
	li		$v0, 1
	lw		$a0, ($s5)
	syscall					# output the value of array[k-1] and return to the main function
	j		$ra

main:
	la  	$s1, array 	# Assigning i = 0
	li		$s3, 0		# Assigning n = 0

	li  	$v0, 4		# printf("Enter 10 integers : \n");
	la  	$a0, i1
	syscall

	li  	$v0, 4
	la  	$a0, newl
	syscall

array_reading_loop:
	addi	$s3, $s3, 1	# it keeps the count of number of inputs taken so far till now

	###################################
	li 		$v0, 4		# printf("#%d : ", n)
	la		$a0, i3
	syscall

	li		$v0, 1
	move	$a0, $s3
	syscall

	li 		$v0, 4
	la		$a0, i4
	syscall
	####################################

	li		$v0, 5		# main integers reading part
	syscall
	sw		$v0, ($s1)

	addi	$s1, $s1, 4

	blt		$s3, 10, array_reading_loop # if the number of integers given as input is less than 10 then continue taking the input

	#####################################################
	li 		$v0, 4				# printf("Enter k : ");
	la		$a0, i2
	syscall

	li		$v0, 5 				# scanf("%d", &k);
	syscall
	move	$s0, $v0
	######################################################

	jal		check_k				# branch to check_k

	jal		bubble_sort			# calling the bubble_sort function to sort the array

	jal		array_printing		# array_printing function call
	
	jal		print_ans			# print_ans function call

	b		exit				# safely terminate the program

error:							# error message for invalid values of k
	li		$v0, 4
	la		$a0, err
	syscall

	b		main

exit:							# exit function for safely termination of the program
	li		$v0, 10
	syscall

###################################################################
# Assignment 3 CS39001
# Q2. To find the kth largest number in the array of 10 integers
# Team Details - Group 70
# Kushaz Sehgal     20CS30030
# Jay Kumar Thakur  20CS30024
###################################################################

# Declaring String Prompts
    .data
input_prompt:
    .asciiz         "Enter 10 integers : \n"
output_prompt:
    .asciiz         "Sorted Array : \n"
tab:
    .asciiz         "  "

    .text
    .globl main

# Instructions Start Here
# main : Program Variables -
# $s0 = base address of array

main:
    # jal     initStack               # link and jump to initStack
    
    addi    $sp,$sp,-4              # Allocating memory for storing previous frame pointer
    sw      $fp,0($sp)              # Store Previous Frame Pointer
    move    $fp,$sp                 # fp <-- sp Initialize new frame pointer

    la		$a0, input_prompt		# storing input_prompt string into first argument register
    li      $v0,4                   # system call to print string (printing input_prompt)
    syscall



    li      $a0,10                  # setting first argument = 10 (to allocate array of size 10)
    jal     allocate_array          # link and jump to allocate_array
    move    $s0,$v0                 # storing base address of allocated array in $s0

    # loop for reading the 10 integers
    li      $t0,0                   # consider this as i = 0
    move    $t1, $s0                # $t1 <-- $s0 , the base address of allocated array 
    read_integers:
        bge     $t0, 10, end_read_integers  # break condition (if i >= 10 then branch to endLoop)

        li      $v0, 5                  # system call to read integer
        syscall
        sw      $v0, 0($t1)             # M[t1] <-- v0 , read value stored in array

        addi    $t0, $t0 ,1             # incrementing i (i = i + 1)
        addi    $t1, $t1 ,4             # incrementing array location (now pointing array[i+1])
        j       read_integers           # loop to continue reading integers
    end_read_integers: 
    # continuing main

    # calling recursive_sort
    li      $a0,0                   # setting first argument as 0 , left = 0
    li      $a1,9                   # setting second argument as 9, right = 0
    jal     recursive_sort          # link and jump to recursive sort with corresponding arguments

    # Printing Output
    la		$a0, input_prompt		# storing input_prompt string into first argument register
    li      $v0, 4                  # system call to print string (printing output_prompt)

    li      $t0, 0                  # t0 <-- 0 initialising i = 0
    move    $t1, $s0                # s$t1 <-- $s0 toring base pointer of array in $t1
    
    print_integers:
        bge		$t0, 10, end_print_integers	    # if $t0 >= 10 then go to end_print_integers (break if i >= 10)
        lw      $a0, 0($t1)             # $a0 <-- M[$t0] , basically a0 = A[i]
        li      $v0, 1                  # system call to print integer (printing A[i])
        syscall
        la      $a0, tab                # storing tab string into first argument register 
        li      $v0, 4                  # system call to print string (printing tab)
        syscall
        addi    $t0, $t0, 1             # $t0 = $t0 + 1, i = i + 1
        addi    $t1, $t1, 4             # $t1 = $t1 + 4 , $t1 points to A[i+1] now
        b       print_integers
    end_print_integers: 

    # resetting stack and terminating program
    move    $sp, $fp                # $sp <-- $fp , stack pointer = frame pointer (emptying stack)
    lw      $fp, 0($sp)             # $fp <-- M[fp] ,resetting frame 
    addi    $sp, $sp, 4             
    # lw      $fp, 0($fp)             # $fp <-- M[fp] ,resetting frame 
    # move    $sp, $fp                # $sp <-- $fp , stack pointer = frame pointer (emptying stack)

    li      $v0, 10                 # system call to exit program
    syscall


# allocate_array - Program Variables
# $a0 = number of integers in array
# $v0 = base address of allocated array
allocate_array:
    sll		$a0, $a0, 2             # $a0 = $a0 << 2
    sub     $sp,$sp,$a0             # allocated memory of required size
    move    $v0,$sp                 # storing first address of allocated array
    jr      $ra                     # return control to caller function

# recursive_sort - Program Variables
# $s0 = base address of array
# $a0 = left
# $a1 = right
# $t0 = p
# $t1 = l
# $t2 = r
recursive_sort:

    # Creating new stack frame
    addi    $sp, $sp, -4             # allocating memory for storing previous frame pointer
    sw      $fp, 0($sp)              # M[sp] <-- $fp, storing prev frame pointer
    move    $fp, $sp                 # $fp <-- $sp, fp = new frame pointer

    addi    $sp, $sp, -4
    sw      $ra, 0($sp)              # storing previous return address in stack

    move    $t0, $a0                 # $t0 <-- $a0 ,initialising p = left 
    move    $t1, $a0                 # $t1 <-- $a0 ,initialising l = left
    move    $t2, $a1                 # $t2 <-- $a1 ,initialising r = right

    # Program Variables - 
    # $t3 = address of A[p]
    # $t4 = address of A[l]
    # $t5 = address of A[r]
    # $t6 = value of A[p]
    # $t7 = value of A[l]
    # $t8 = value of A[r]
    outerloop:

        bge		$t1, $t2, end_outerloop	# if $t1 >= $t2 (l >= r) then go to end_outerloop

        sll		$t3, $t0, 2			    # $t3 = $t0 << 2 , basically $t3 = 4*p
        sll		$t4, $t1, 2			    # $t4 = $t1 << 2 , basically $t4 = 4*l
        sll		$t5, $t2, 2			    # $t5 = $t2 << 2 , basically $t5 = 4*r

        # Note - $s0 = base address of array
        add		$t3, $s0, $t3		    # $t3 = $s0 + $t3 , t3 points to A[p]
        add		$t4, $s0, $t4		    # $t4 = $s0 + $t4 , t4 points to A[l]
        add		$t5, $s0, $t5		    # $t4 = $s0 + $t4 , t5 points to A[r]
        
        
        innerloop1:
            lw		$t6, 0($t3)		        # $t6 <-- M[$t3] basically $t6 = A[p]
            lw		$t7, 0($t4)		        # $t7 <-- M[$t4] basically $t7 = A[l]

            bgt		$t7, $t6, end_innerloop1    # if $t7 > $t6 then go to endinnerloop1 (break if A[l] > A[p])
            bge		$t1, $a1, end_innerloop1	# if $t1 > $t2 then end_innerloop1 (break if l >= right)
            
            addi    $t1, $t1,1              # $t1 = $t1 + 1 ,l = l + 1
            addi    $t4, $t4, 4             # $t4 = $t4 + 4 ,$t4 now points to A[l+1]

            b       innerloop1              # branch to innerloop1

        end_innerloop1:

        innerloop2:
            lw      $t6, 0($t3)             # $t6 <-- M[$t3] basically $t6 = A[p]
            lw      $t8, 0($t5)             # $t8 <-- M[$t5] basically $t8 = A[r]

            blt     $t8, $t6, end_innerloop2    # if $t8 < $t6 then go to endinnerloop1 (break if A[r] < A[p])
            ble		$t2, $a0, end_innerloop2	# if $t2 <= $a0 then go toend_innerloop2 (break if r <= left)

            addi    $t2, $t2, -1            # $t2 = $t2 - 1 ,r = r - 1
            addi    $t5, $t5, -4            # #t5 = $t5 - 4, $t5 now points to A[r-1]

            b       innerloop2              # branch to innerloop1
        end_innerloop2:

        blt		$t1, $t2, swap_l_r      # if $t1 < $t2 then go to swap_l_r (branch if l < r)

        lw		$t6, 0($t3)		        # $t6 <-- M[$t3] basically $t6 = A[p]
        lw      $t8, 0($t5)             # $t8 <-- M[$t5] basically $t8 = A[r]

        sw		$t8, 0($t3)		        # M[$t3] <-- $t8, A[p] set to prev A[r]
        sw      $t6, 0($t5)             # M[$t5] <-- $t6, A[r] set to prev A[p]


        # addi    $sp, $sp, -4            # $sp <-- $sp - 4 allocating memory on stack to store left
        # sw      $a0, 0($sp)             # M[sp] <-- $a0, storing left

        addi    $sp, $sp, -4            # $sp <-- $sp - 4 allocating memory on stack to store right
        sw      $a1, 0($sp)             # M[sp] <-- $a1, storing right

        addi    $sp,$sp,-4              # $sp <-- $sp - 4 allocating memory on stack to store r
        sw      $t2, 0($sp)             # M[sp] <-- $t2, storing r
        

        # calling recursive_sort(A,left,r-1)
        addi    $a1, $t2, -1		    # $a1 = $t2 - 1 , setting second argument  = r - 1
        # $a0 = left already
        jal		recursive_sort		    # jump to recursive_sort and save position to $ra
        

        # calling recursive_sort(A,left,r-1)
        # lw      $a0, 8($sp)             # $a0 <-- M[sp+8] resetting $a0 = left
        lw      $a1, 4($sp)             # $a1 <-- M[sp+4]  $a1 = previous right
        lw      $t2, 0($sp)             # $t2 <-- M[sp] resetting $t2 = r

        addi	$a0, $t2, 1			    # $a0 = $t2 + 1 setting first argument = r + 1
        # $a1 set to right earlier
        jal     recursive_sort          # jump to recursive_sort and save position to $ra
        
        #################################
        # Resetting stack frame and $ra
        #################################
        lw      $ra, -4($fp)            # $ra <-- -4(fp) ,restoring value of $ra as before
        move    $sp,$fp                 # sp <-- fp ,de-allocating memory allocated in this stack frame 
        lw      $fp,0($fp)              # fp <-- M[fp] ,restoring value of $fp as before
        addi    $sp, $sp, 4            # sp <-- sp - 4 ,restoring value of sp as before

        jr		$ra					    # return control to caller function 
        #################################


        swap_l_r:
            lw		$t7, 0($t4)		        # $t7 <-- M[$t4] basically $t7 = A[l]
            lw      $t8, 0($t5)             # $t8 <-- M[$t5] basically $t8 = A[r]

            sw      $t8,0($t4)              # M[$t4] <-- $t8, A[l] set to prev A[r]
            sw      $t7,0($t5)              # M[$t5] <-- $t7  A[r] set to prev A[l]

            b		outerloop			    # branch to outerloop
        
    end_outerloop:
        lw      $ra, -4($fp)            # $ra <-- -4(fp) ,restoring value of $ra as before
        move    $sp,$fp                 # sp <-- fp ,de-allocating memory allocated in this stack frame 
        lw      $fp,0($fp)              # fp <-- M[fp] ,restoring value of $fp as before
        addi    $sp, $sp, 4            # sp <-- sp + 4 ,restoring value of sp as before
 
        jr      $ra                     # return control to caller function 




# initStack:                         # Initialising new stack frame
#     addi    $sp,$sp,-4                  # Allocating memory for storing previous frame pointer
#     sw      $fp,0($sp)                  # Store Previous Frame Pointer
#     move    $fp,$sp                     # Initialize new frame pointer
#     jr      $ra                         # jump to return address

# pushToStack:
#     addi    $sp,$sp,-4
#     sw      $a0,$0(sp)
#     jr      $ra





    


        

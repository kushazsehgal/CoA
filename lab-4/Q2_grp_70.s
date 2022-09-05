###################################################################
# Assignment 4 CS39001
# Q2. To find the kth largest number in the array of 10 integers
# Team Details - Group 70
# Kushaz Sehgal     20CS30030
# Jay Kumar Thakur  20CS30024
###################################################################

# Declaring String Prompts
    .data
array:  .space          40

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
# array = A
# $t0 = i
# $t1 = offset for ith element (4*i)

main:
    # initialising Stack Frame
    jal     initStack              # link and jump to initStack

    la		$a0, input_prompt		# storing input_prompt string into first argument register
    li      $v0,4                   # system call to print string (printing input_prompt)
    syscall

    # loop for reading the 10 integers
    li      $t0, 0                  # t0 <-- 0 consider this as i = 0
    li      $t1, 0                  # t1 <-- 0 initialising offset = 0
    read_integers:
        bge     $t0, 10, end_read_integers  # break condition (if i >= 10 then branch to endLoop)

        li      $v0, 5                  # system call to read integer
        syscall
        sw      $v0, array($t1)         # v0 <-- array($t1) , $v0 = A[i]     

        addi    $t0, $t0 ,1             # incrementing i (i = i + 1)
        addi    $t1, $t1 ,4             # t1 <-- t1 + 4 , t1 now is offset for A[i+1]
        j       read_integers           # loop to continue reading integers
    end_read_integers: 

    # calling recursive_sort
    li      $a0,0                   # setting first argument as 0 , left = 0
    li      $a1,9                   # setting second argument as 9, right = 0
    jal     recursive_sort          # link and jump to recursive sort with corresponding arguments

    # Printing Output
    la		$a0, output_prompt		# storing output_prompt string into first argument register
    li      $v0, 4                  # system call to print string (printing output_prompt)
    syscall 

    li      $t0, 0                  # t0 <-- 0 initialising i = 0
    li      $t1, 0                  # t1 <-- 0 , initialising offset for array = 0
    
    print_integers:
        bge		$t0, 10, end_print_integers	    # if $t0 >= 10 then go to end_print_integers (break if i >= 10)
        lw      $a0, array($t1)         # $a0 <-- array($t1) , $a0 = A[i]
        li      $v0, 1                  # system call to print integer (printing A[i])
        syscall
        la      $a0, tab                # storing tab string into first argument register 
        li      $v0, 4                  # system call to print string (printing tab)
        syscall
        addi    $t0, $t0, 1             # $t0 = $t0 + 1, i = i + 1
        addi    $t1, $t1, 4             # t1 <-- t1 + 4 , t1 now is offset for A[i+1]
        b       print_integers
    end_print_integers: 

    ###############################################
    # Resetting stack frame and terminating program
    ###############################################
    jal     clearStack              # Empyting present stack frame
    li      $v0, 10                 # system call to exit program
    syscall


# recursive_sort - Program Variables
# $a0 = left
# $a1 = right
# $t9 = temporary to variable to store registers values to use later
# $t0 = p
# $t1 = l
# $t2 = r
recursive_sort:

    # Creating new stack frame
    move    $t9, $ra                  # $t9 <-- $ra (return address stored in t9)
    jal     initStack                 # initliasing new stack frame
    move    $ra, $t9                  # $ra <-- $t9 ,restoring balue of $ra

    # pushing $ra to top of stack to restore $ra after recursive function calls
    move    $t9, $a0                  # $t9 <-- $a0, storing value of $a0
    move    $a0, $ra                  # $a0 <-- $ra passing first argument as return address
    jal     pushToStack               # pushing $ra to top of stack
    move    $a0, $t9                  # $a0 <-- $t9, restoring value of $t9

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
        
        innerloop1:
            lw		$t6, array($t3)		    # $t6 <-- array[$t3] basically $t6 = A[p]
            lw		$t7, array($t4)		    # $t7 <-- array[$t4] basically $t7 = A[l]

            bgt		$t7, $t6, end_innerloop1    # if $t7 > $t6 then go to endinnerloop1 (break if A[l] > A[p])
            bge		$t1, $a1, end_innerloop1	# if $t1 > $t2 then end_innerloop1 (break if l >= right)
            
            addi    $t1, $t1,1              # $t1 = $t1 + 1 ,l = l + 1
            addi    $t4, $t4, 4             # $t4 = $t4 + 4 ,$t4 now is offset for A[l+1]

            b       innerloop1              # branch to innerloop1

        end_innerloop1:

        innerloop2:
            lw      $t6, array($t3)          # $t6 <-- array[$t3] basically $t6 = A[p]
            lw      $t8, array($t5)          # $t8 <-- array[$t5] basically $t8 = A[r]

            blt     $t8, $t6, end_innerloop2    # if $t8 < $t6 then go to endinnerloop1 (break if A[r] < A[p])
            ble		$t2, $a0, end_innerloop2	# if $t2 <= $a0 then go toend_innerloop2 (break if r <= left)

            addi    $t2, $t2, -1            # $t2 = $t2 - 1 ,r = r - 1
            addi    $t5, $t5, -4            # #t5 = $t5 - 4, $t5 now offset for A[r-1]

            b       innerloop2              # branch to innerloop1
        end_innerloop2:

        blt		$t1, $t2, swap_l_r      # if $t1 < $t2 then go to swap_l_r (branch if l < r)

        lw		$t6, array($t3)		    # $t6 <-- array[$t3] basically $t6 = A[p]
        lw      $t8, array($t5)         # $t8 <-- array[$t5] basically $t8 = A[r]

        sw		$t8, array($t3)		    # array[$t3] <-- $t8, A[p] set to prev A[r]
        sw      $t6, array($t5)         # array[$t5] <-- $t6, A[r] set to prev A[p]

        # pushing value of $a1 (right) on stack to use after recursive call
        move    $t9, $a0                # $a0 <-- $t9 , storing value of $a0 to restore its value later
        move    $a0, $a1                # $a0 <-- $a1
        jal     pushToStack             # pushing value right on stack
        move    $a0, $t9                # restoring value of $a0

        # pushing value of $t2 (r) on stack to use after recursive call
        move    $t9, $a0                # $a0 <-- $t9 , storing value of $a0 to restore its value later
        move    $a0, $t2                # $a0 <-- $$t2
        jal     pushToStack             # pushing value of r on stack
        move    $a0, $t9                # restoring value of $a0

        # calling recursive_sort(A,left,r-1)
        addi    $a1, $t2, -1		    # $a1 = $t2 - 1 , setting second argument  = r - 1
        # $a0 = left already
        jal		recursive_sort		    # jump to recursive_sort and save position to $ra
        

        
        # restoring value of $t2 as r and popping r from stack
        jal		popFromStack			# popping value of r from stack
        move    $t2, $v0                # $t2 <-- $v0 , $t2 = r ,restored $t2

        # calling recursive_sort(A,r+1,right)
        # restoring value of $a1 as right and popping right from stack
        jal     popFromStack            # popping value of right from stack
        move    $a1, $v0                # $a1 <-- $v0 , $t2 = right ,restored $a1
        addi	$a0, $t2, 1			    # $a0 = $t2 + 1 setting first argument = r + 1
        # $a1 set to right earlier
        jal     recursive_sort          # jump to recursive_sort and save position to $ra
        
        #################################
        # Resetting stack frame and $ra
        #################################
        jal     popFromStack            # Popping previous value of $ra from stack 
        move    $ra, $v0                # $ra <-- $v0 ,restored $ra

        move    $t9, $ra                # $t9 <-- $ra ,storing $ra to use later
        # Deleting Stack Frame
        jal     clearStack              # Emptying present stack frame

        move    $ra, $t9                # $ra <-- $t9 ,restoring value of $ra

        jr		$ra					    # return control to caller function 


        swap_l_r:
            lw		$t7, array($t4)		    # $t7 <-- array[$t4] basically $t7 = A[l]
            lw      $t8, array($t5)         # $t8 <-- array[$t5] basically $t8 = A[r]

            sw      $t8,array($t4)          # array[$t4] <-- $t8, A[l] set to prev A[r]
            sw      $t7,array($t5)          # array[$t5] <-- $t7  A[r] set to prev A[l]

            b		outerloop			    # branch to outerloop
        
    end_outerloop:
        #################################
        # Resetting stack frame and $ra
        #################################
        jal     popFromStack            # Popping previous value of $ra from stack 
        move    $ra, $v0                # $ra <-- $v0 ,restored $ra

        move    $t9, $ra                # $t9 <-- $ra ,storing $ra to use later
        # Deleting Stack Frame
        jal     clearStack              # Empyting present stack frame

        move    $ra, $t9                # $ra <-- $t9 ,restoring value of $ra
 
        jr      $ra                     # return control to caller function 




initStack:                         # Initialising new stack frame
    addi    $sp,$sp,-4                  # Allocating memory for storing previous frame pointer
    sw      $fp,0($sp)                  # Store Previous Frame Pointer
    move    $fp,$sp                     # Initialize new frame pointer
    jr      $ra                         # return control to caller function

pushToStack:                       # pushing $a0 on top of stack
    addi    $sp,$sp,-4                  # $sp <-- $sp - 4 ,allocating memory for $a0 
    sw      $a0, 0($sp)                 # M[$sp] <-- $a0 ,storing $a0
    jr      $ra                         # return control to caller function

popFromStack:                     # returning and popping value on top of stack
    lw      $v0, 0($sp)             # $v0 <-- M[$sp] ,storing top value in $v0
    addi    $sp, $sp, 4             # $s0 <-- $sp + 4 ,de-allocating memory
    jr      $ra                     # return control to caller function

clearStack:                        # clearing stack frame
    move    $sp, $fp                    # $sp <-- $fp , stack pointer = frame pointer (emptying stack)
    lw      $fp, 0($sp)                 # $fp <-- M[fp] ,resetting frame 
    addi    $sp, $sp, 4                 # $sp <-- $sp - 4 ,now sp = stack pointer of previous stack frame
    jr      $ra                         # return control to caller function





    


        

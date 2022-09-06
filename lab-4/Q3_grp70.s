###################################################################
# Assignment 4 CS39001
# Q3. Implement a searching algorithm in an array of 10 integers
# Team Details - Group 70
# Kushaz Sehgal     20CS30030
# Jay Kumar Thakur  20CS30024
###################################################################

    .data
# Declaring array
array:  .space          40
# Declaring String Prompts
input_prompt:
    .asciiz         "Enter 10 integers : \n"
output_prompt:
    .asciiz         "Sorted Array : \n"
key_prompt:
    .asciiz         "\nEnter key : "
key_output:
    .asciiz         " is FOUND in the array at index (0-indexing): "
key_failure:
    .asciiz         " not FOUND in the array."
tab:
    .asciiz         "  "


    .text
    .globl main

# Instructions Start Here
# main : Program Variables -
# array = A
# $t0 = i
# $t1 = offset for ith element (4*i)
# $s0 = key
# $s2 = final answer

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
        sw      $v0, array($t1)         # array($t1) <-- $v0,  A[i] = $v0     

        addi    $t0, $t0, 1             # incrementing i (i = i + 1)
        addi    $t1, $t1, 4             # t1 <-- t1 + 4,  t1 now is offset for A[i+1]
        j       read_integers           # loop to continue reading integers
    end_read_integers: 

    # calling recursive_sort
    li      $a0,0                   # setting first argument as 0,  left = 0
    li      $a1,9                   # setting second argument as 9, right = 0
    jal     recursive_sort          # link and jump to recursive sort with corresponding arguments

    # Printing Output
    la		$a0, output_prompt		# storing output_prompt string into first argument register
    li      $v0, 4                  # system call to print string (printing output_prompt)
    syscall 

    li      $t0, 0                  # t0 <-- 0 initialising i = 0
    li      $t1, 0                  # t1 <-- 0,  initialising offset for array = 0
    
    print_integers:
        bge		$t0, 10, end_print_integers	    # if $t0 >= 10 then go to end_print_integers (break if i >= 10)
        lw      $a0, array($t1)         # $a0 <-- array($t1),  $a0 = A[i]
        li      $v0, 1                  # system call to print integer (printing A[i])
        syscall
        la      $a0, tab                # storing tab string into first argument register 
        li      $v0, 4                  # system call to print string (printing tab)
        syscall
        addi    $t0, $t0, 1             # $t0 = $t0 + 1, i = i + 1
        addi    $t1, $t1, 4             # t1 <-- t1 + 4,  t1 now is offset for A[i+1]
        b       print_integers
    end_print_integers: 

    # prompt for entering key
    la		$a0, key_prompt		    # storing key_prompt string into first argument register
    li      $v0,4                   # system call to print string (printing key_prompt)
    syscall
               
    li      $v0, 5                  # system call to read integer
    syscall
    move    $s0, $v0                # $s0 <-- $v0,  $s0 = key
    li      $s1, 3                  # $s1 <-- 3
    # calling recursive_search(A,0,9)
    li      $a0, 0                  # $a0 <-- 0, start = 0
    li      $a1, 9                  # $a1 <-- 9, end = 0
    jal		recursive_search	    # jump to recursive_search and save position to $ra
    
    
    # # pushing index on stack to use later
    # move    $a0, $v0                # $v0 <-- $a0,  $a0 = index
    # # li      $v0, 1
    # # syscall
    # jal     pushToStack             # push value of index on top of stack

    move    $s2, $v0                # $s2 <-- $v0, storing answer index in $s2

    move    $a0, $s0                # storing key into first argument register  
    li      $v0, 1                  # system call to print integer (print key)
    syscall

    beq       $s2, -1, failure      # if index == -1, key not found, so branch to failure
    
    success:
    # printing key_output
    la      $a0, key_output         # storing key_output string into first argument register
    li      $v0, 4                  # system call to print string (printing key_output)
    syscall
    move    $a0, $s2                # $a0 <-- $s2, storing index into first argument register
    li      $v0, 1                  # syscall to print integer, printing index
    syscall
    b       final

    failure:
    # printing key_failure
    la      $a0, key_failure        # storing key_output string into first argument register
    li      $v0, 4                  # system call to print string (printing key_output)
    syscall
    b       final                   # branch to exit block
    
    final:
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
    move    $ra, $t9                  # $ra <-- $t9, restoring balue of $ra

    # pushing $ra to top of stack to restore $ra after recursive function calls
    move    $t9, $a0                  # $t9 <-- $a0, storing value of $a0
    move    $a0, $ra                  # $a0 <-- $ra passing first argument as return address
    jal     pushToStack               # pushing $ra to top of stack
    move    $a0, $t9                  # $a0 <-- $t9, restoring value of $t9

    move    $t0, $a0                  # $t0 <-- $a0, initialising p = left 
    move    $t1, $a0                  # $t1 <-- $a0, initialising l = left
    move    $t2, $a1                  # $t2 <-- $a1, initialising r = right

    # Program Variables - 
    # $t3 = address of A[p]
    # $t4 = address of A[l]
    # $t5 = address of A[r]
    # $t6 = value of A[p]
    # $t7 = value of A[l]
    # $t8 = value of A[r]
    outerloop:

        bge		$t1, $t2, end_outerloop	# if $t1 >= $t2 (l >= r) then go to end_outerloop

        sll		$t3, $t0, 2			    # $t3 = $t0 << 2,  basically $t3 = 4*p
        sll		$t4, $t1, 2			    # $t4 = $t1 << 2,  basically $t4 = 4*l
        sll		$t5, $t2, 2			    # $t5 = $t2 << 2,  basically $t5 = 4*r
        
        innerloop1:
            lw		$t6, array($t3)		    # $t6 <-- array[$t3] basically $t6 = A[p]
            lw		$t7, array($t4)		    # $t7 <-- array[$t4] basically $t7 = A[l]

            bgt		$t7, $t6, end_innerloop1    # if $t7 > $t6 then go to endinnerloop1 (break if A[l] > A[p])
            bge		$t1, $a1, end_innerloop1	# if $t1 > $t2 then end_innerloop1 (break if l >= right)
            
            addi    $t1, $t1,1              # $t1 = $t1 + 1, l = l + 1
            addi    $t4, $t4, 4             # $t4 = $t4 + 4, $t4 now is offset for A[l+1]

            b       innerloop1              # branch to innerloop1

        end_innerloop1:

        innerloop2:
            lw      $t6, array($t3)          # $t6 <-- array[$t3] basically $t6 = A[p]
            lw      $t8, array($t5)          # $t8 <-- array[$t5] basically $t8 = A[r]

            blt     $t8, $t6, end_innerloop2    # if $t8 < $t6 then go to endinnerloop1 (break if A[r] < A[p])
            ble		$t2, $a0, end_innerloop2	# if $t2 <= $a0 then go toend_innerloop2 (break if r <= left)

            addi    $t2, $t2, -1            # $t2 = $t2 - 1, r = r - 1
            addi    $t5, $t5, -4            # #t5 = $t5 - 4, $t5 now offset for A[r-1]

            b       innerloop2              # branch to innerloop1
        end_innerloop2:

        blt		$t1, $t2, swap_l_r      # if $t1 < $t2 then go to swap_l_r (branch if l < r)

        recursive_calls:
        lw		$t6, array($t3)		    # $t6 <-- array[$t3] basically $t6 = A[p]
        lw      $t8, array($t5)         # $t8 <-- array[$t5] basically $t8 = A[r]

        sw		$t8, array($t3)		    # array[$t3] <-- $t8, A[p] set to prev A[r]
        sw      $t6, array($t5)         # array[$t5] <-- $t6, A[r] set to prev A[p]

        jal		store_registers			  # jump to store_registers and save position to $ra
        # calling recursive_sort(A,left,r-1)
        addi    $a1, $t2, -1		    # $a1 = $t2 - 1,  setting second argument  = r - 1
        # $a0 = left already
        jal		recursive_sort		    # jump to recursive_sort and save position to $ra

        jal     restore_registers       # restored all registers as before recursive call

        jal		store_registers			  # jump to store_registers and save position to $ra
        # calling recursive_sort(A,r+1,right)
        addi	$a0, $t2, 1			    # $a0 = $t2 + 1 setting first argument = r + 1
        # $a1 = right already
        jal     recursive_sort          # jump to recursive_sort and save position to $ra
        
        jal     restore_registers       # restored all registers as before recursive call

        b		end_recursive_sort		# branch to end_recursive_sort (returning from recursive_sort)
        

        store_registers:
            move    $t9, $ra                # $t9 <-- $ra, storing $ra to restore after pushToStack
            move    $t8, $a0                # $t8 <-- $a0, storing previous $a0

            jal     pushToStack             # pushed value of $a0 (left) on top of stack to restore after recursive calls

            move    $a0, $a1
            jal     pushToStack             # pushed value of $a1 (right) on top of stack to restore after recursive calls

            move    $a0, $t0
            jal     pushToStack             # pushed value of $t0 (p) on top of stack to restore after recursive calls

            move    $a0, $t1
            jal     pushToStack             # pushed value of $t1 (l) on top of stack to restore after recursive calls

            move    $a0, $t2            
            jal     pushToStack             # pushed value of $t2 (r) on top of stack to restore after recursive calls

            move    $a0, $t3                
            jal     pushToStack             # pushed value of $t3 (address of A[p]) on top of stack to restore after recursive calls

            move    $a0, $t4
            jal     pushToStack             # pushed value of $t4 (address of A[l]) on top of stack to restore after recursive calls

            move    $a0, $t5
            jal     pushToStack             # pushed value of $t3 (address of A[r]) on top of stack to restore after recursive calls

            move    $ra, $t9                # $ra <-- $t9, restored $ra
            move    $a0, $t8                # $a0 <-- $t8, restored $a0

            jr      $ra                     # return control to caller function

        restore_registers:
            move    $t9, $ra                # $t9 <-- $ra, storing $ra to restore after pushToStack
            move    $t8, $v0                # $t8 <-- $v0, storing previous $v0 to restore later

            jal     popFromStack            # popped value of $t5
            move    $t5, $v0                # $t5 <-- $v0, restored value of $t5   

            jal     popFromStack            # popped value of $t4
            move    $t4, $v0                # $t4 <-- $v0, restored value of $t4

            jal     popFromStack            # popped value of $t3
            move    $t3, $v0                # $t3 <-- $v0, restored value of $t3

            jal     popFromStack            # popped value of $t2
            move    $t2, $v0                # $t2 <-- $v0, restored value of $t2

            jal     popFromStack            # popped value of $t1
            move    $t1, $v0                # $t1 <-- $v0, restored value of $t1

            jal     popFromStack            # popped value of $t0
            move    $t0, $v0                # $t0 <-- $v0, restored value of $t0

            jal     popFromStack            # popped value of $a1
            move    $a1, $v0                # $a1 <-- $v0, restored value of $a1

            jal     popFromStack            # popped value of $a0
            move    $a0, $v0                # $a0 <-- $v0, restored value of $a0
            
            move    $ra, $t9                # $ra <-- $t9, restored $ra
            move    $v0, $t8                # $a0 <-- $t8, restored $v0

            jr      $ra                     # return control to caller function

        swap_l_r:
            lw		$t7, array($t4)		    # $t7 <-- array[$t4] basically $t7 = A[l]
            lw      $t8, array($t5)         # $t8 <-- array[$t5] basically $t8 = A[r]

            sw      $t8,array($t4)          # array[$t4] <-- $t8, A[l] set to prev A[r]
            sw      $t7,array($t5)          # array[$t5] <-- $t7  A[r] set to prev A[l]

            b		outerloop			    # branch to outerloop
        
    end_outerloop:

    end_recursive_sort:
        #################################
        # Resetting stack frame and $ra
        #################################
        jal     popFromStack            # Popping previous value of $ra from stack 
        move    $ra, $v0                # $ra <-- $v0, restored $ra

        move    $t9, $ra                # $t9 <-- $ra, storing $ra to use later
        # Deleting Stack Frame
        jal     clearStack              # Empyting present stack frame

        move    $ra, $t9                # $ra <-- $t9, restoring value of $ra
 
        jr      $ra                     # return control to caller function 

# recursive_search - Program Variables:
# $s0 = key
# #s1 = constant value (3)
# $a0 = start
# $a1 = end
# $t1 = mid1
# $t2 = mid2
# $t3 = A[mid1]
# $t4 = A[mid2]
# $t0 = temporary variable to store register values to restore later
recursive_search:
    
    # initialising new stack frame
    move    $t0, $ra                    # $t0 <-- $ra, storing $ra in $t0 to restore later
    jal     initStack                   # initialising stack
    move    $ra, $t0                    # $ra <-- $t0, restoring value of $ra

    # pushing $ra on stack to restore later
    move    $t0, $a0                    # $t0 <-- $a0, storing $a0 in $t0 to restore later
    move    $a0, $ra                    # $a0 <-- $ra, to push $ra on stack
    jal     pushToStack                 
    move    $a0, $t0                    # $a0 <-- $t0, restoring value of $a0 

    bgt		$a0, $a1, return_not_found	# if $a0 > $a1 then branch to return_not_found,  basically return -1 if start > end
    
    
    # $t1 = start + (end - start)/3
    sub		$t1, $a1, $a0		        # $t1 = $a1 - $a0, $t1 = end - start
    div		$t1, $s1			        # $t1 / 3 quotient stored in $lo
    mflo	$t1					        # $t1 = floor($t1 / 3), basically $t0 = (end-start)/3
    add		$t1, $t1, $a0		        # $t1 = $t1 + $a0, basically $t1 = start + (end - start)/3

    # $t2 = end - (end - start)/3
    sub     $t2, $a0, $a1               # $t2 = $a0 - $a1, $t1 = start - end
    div     $t2, $s1                    # $t2 / 3 quotient stored in $lo
    mflo    $t2                         # $t2 = floor($t2/3), basically $t2 = (start - end)/3
    add     $t2, $t2, $a1               # $t2 = $t2 + $a1, basically $t2 = end + (start - end)/3 = end - (end - start)/3

    # $t3 = A[mid1]
    sll		$t3, $t1, 2			        # $t3 = $t1 << 2,  $t3 = offset for A[mid1]
    lw		$t3, array($t3)		        # $t3 <-- array[$t3],  basically $t3 = A[mid1] 
    # $t4 = A[mid2]
    sll     $t4, $t2, 2                 # $t4 = $t2 << 2,  $t4 = offset for A[mid2]
    lw		$t4, array($t4)		        # $t4 <-- array[$t4],  basically $t4 = A[mid2] 

    beq		$s0, $t3, return_mid1	    # if $s0 == $t3 then branch to return_mid1 (key == A[mid1])
    beq     $s0, $t4, return_mid2       # if $s0 == $t4 then branch to return_mid2 (key == A[mid2])
    
    blt     $s0, $t3, return_recursive1
    bgt     $s0, $t4, return_recursive2

    b		return_recursive3			# unconditonal branch to return_recursive3
    
    return_mid1:
        move    $v0, $t1                # $v0 <-- $t1 (returning mid1)
        b       return_from_search           # branch to return_from_search
    return_mid2:
        move    $v0, $t2                # $v0 <-- $t2 (returning mid2)
        b		return_from_search			# branch to return_from_search
    return_not_found:
        li      $v0, -1                 # $v0 <-- -1 (returning -1)
        b       return_from_search           # branch to return_from_search
    


    return_recursive1:
        jal     save_variables          # saving all registers on stack to restore later
        
        add     $a1, $t1, -1            # $a1 = $t1 - 1, basically $a1 = mid1 - 1
        # Note - $a0 already start
        jal     recursive_search        # calling recursive_search(A,start,mid1-1,key)
        
        jal     restore_variables       # restoring all registers (changed due to recursive call)
        
        b		return_from_search			# branch to return_from_search
    return_recursive2:
        jal     save_variables          # saving all registers on stack to restore later

        add     $a0, $t2, 1             # $a0 = $t2 + 1, basically $a0 =  mid2 + 1
        # Note - $a1 already end
        jal     recursive_search        # calling recursive_search(A,mid2+1,end,key)
        
        jal     restore_variables       # restoring all registers (changed due to recursive call)

        b		return_from_search			# branch to return_from_search
    return_recursive3:
        jal     save_variables          # saving all registers on stack to restore later

        add     $a0, $t1, 1             # $a0 = $t1 + 1, basically $a0 = mid1 + 1
        add     $a1, $t2, -1            # $a1 = $t2 - 1, basically $a1 - mid2 - 1
        jal     recursive_search        # calling recursive_search(A,mid1+1,mid2-1,key)

        jal     restore_variables       # restoring all registers (changed due to recursive call)

        b		return_from_search			# branch to return_from_search
            
    save_variables:                     # Function to save all registers to restore after recursive calls

        move    $t0, $ra                # $t0 <-- $ra ,storing $ra to restore after pushToStack
        move    $t5, $a0                # $t5 <-- $a0 ,storing $a0 (start) to restore after pushToStack

        jal     pushToStack             # pushing $a0 (start) on top of stack

        move    $a0, $a1                
        jal     pushToStack             # pushing $a1 (end) on top of stack

        move    $a0, $t1
        jal     pushToStack             # pushing $t1 (mid1) on top of stack

        move    $a0, $t2                # pushing $t2 (mid2) on top of stack
        jal     pushToStack

        move    $a0, $t5                # $a0 <-- $t5 ,restored $a0 (start)
        move    $ra, $t0                # $ra <-- $t0 ,restored $ra

        jr      $ra                     # return control to caller function

    restore_variables:

        move    $t0, $ra                # $t0 <-- $ra, storing $ra to restore after popFromStack
        move    $t6, $v0                # $t6 <-- $v0, storing previous return value
        
        jal     popFromStack            # popped value of $t2 stored on stack
        move    $t2, $v0                # $t2 <-- $v0, restored $t2

        jal     popFromStack            # popped value of $t1 stored on stack
        move    $t1, $v0                # $t1 <-- $v0, restored $t1

        jal     popFromStack            # popped value of $a1 stored on stack
        move    $a1, $v0                # $a1 <-- $v0, restored $a1

        jal     popFromStack            # popped value of $a0 stored on stack
        move    $a0, $v0                # $a0 <-- $v0, restored $a0

        move    $ra, $t0                # $ra <-- $t0, restored value of $ra
        move    $v0, $t6                # $v0 <-- $t6, restored value of $v0
        jr      $ra                     # return control to caller function
    return_from_search:
        #################################
        # Resetting stack frame and $ra
        #################################
        # getting value of previous $ra
        move    $t0, $v0                # $t0 <-- $v0, storing return value to restore later
        jal     popFromStack            # popping stack (poppin previous value of $ra)
        move    $ra, $v0                # $ra <-- $v0, restoring value of $ra
        move    $v0, $t0                # $v0 <-- $t0, restoring $v0 (return value)
        
        # deleteing stack frame
        move    $t0, $ra                # $t0 <-- $ra, storing $ra to in $t0 to restore later
        jal     clearStack              # de-allocating all memory in stack and resetting fp and sp
        move    $ra, $t0                # $ra -- $t0, restoring $ra

        jr      $ra                     # return control to caller function

initStack:                         # Initialising new stack frame
    addi    $sp,$sp,-4                  # Allocating memory for storing previous frame pointer
    sw      $fp,0($sp)                  # Store Previous Frame Pointer
    move    $fp,$sp                     # Initialize new frame pointer
    jr      $ra                         # return control to caller function

pushToStack:                       # pushing $a0 on top of stack
    addi    $sp,$sp,-4                  # $sp <-- $sp - 4, allocating memory for $a0 
    sw      $a0, 0($sp)                 # M[$sp] <-- $a0, storing $a0
    jr      $ra                         # return control to caller function

popFromStack:                     # returning and popping value on top of stack
    lw      $v0, 0($sp)             # $v0 <-- M[$sp], storing top value in $v0
    addi    $sp, $sp, 4             # $s0 <-- $sp + 4, de-allocating memory
    jr      $ra                     # return control to caller function

clearStack:                        # clearing stack frame
    move    $sp, $fp                    # $sp <-- $fp,  stack pointer = frame pointer (emptying stack)
    lw      $fp, 0($sp)                 # $fp <-- M[fp], resetting frame 
    addi    $sp, $sp, 4                 # $sp <-- $sp - 4, now sp = stack pointer of previous stack frame
    jr      $ra                         # return control to caller function





    


        

# Binary search using a function

    .data

# int array[] = {1, 2, 2, 3, 4, 9, 10, 11, 20}
array: .word 1, 2, 2, 3, 4, 9, 10, 11, 20

input: .asciiz "Value: "
outputFound: .asciiz "Found at index "
outputNotFound: .asciiz "Not found."

    .text
main:

    # Input message
    li $v0, 4
    la $a0, input
    syscall

    # Read input
    li $v0, 5
    syscall

    # Store value to search for in $a0 (argument of function)
    move $a0, $v0

    # $t0 will reference the start of the array
    la $t0, array

    # Starting index of array left half (argument of function)
    li $a2, 0

    # Starting index of array right half (argument of function)
    li $a3, 8

    # Load decimal 2 into $t2 for mid point division in Binary Search
    li $t2, 2

    # Load decimal 4 into $t6 for calculation of index in bytes
    li $t6, 4

    # Load decimal -1 into $v0 (index not found)
    li $v0, -1

    # Call function
    jal binary_search

    # Found value at array (index >= 0)?
    bge $v0, $0, found

    # System service to print output message
    li $v0, 4
    la $a0, outputNotFound
    syscall

    j end

binary_search:

    # if left_index > right_index than the value was not found
    bgt $a2, $a3, end_search

    # Store mid point index in $t1   int m = l + (r - l) / 2;
    sub $t1, $a3, $a2
    div $t1, $t1, $t2
    add $t1, $t1, $a2

    # Calculate index in bytes into $t7
    mul $t7, $t1, $t6

    # $t3 references the mid point address of the array
    add $t3, $t0, $t7

    # Load into $t4 the mid point element of the array
    lw $t4, 0($t3)

    # if mid_point_element == value than the value was found
    beq $t4, $a0, return_index

    # if mid_point_element < value than ignore left half
    blt $t4, $a0, mid_less

    # if mid_point_element > value than ignore right half
    add $a3, $t1, -1

    j binary_search

mid_less:
    add $a2, $t1, 1

    j binary_search

return_index:
    
    # Return index where the value was first found
    move $v0, $t1

end_search:
    jr $ra

found:
    move $t5, $v0

    # System service to print output message
    li $v0, 4
    la $a0, outputFound
    syscall

    # System service to print index
    li $v0, 1
    move $a0, $t5
    syscall

end:
    jr $ra
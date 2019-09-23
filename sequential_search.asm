    .data
# int array[] = {4, 9, 1, 10, 11, 20, 2, 3, 2}
array: .word 4, 9, 1, 10, 11, 20, 2, 3, 2
input: .asciiz "Value: "
outputFound: .asciiz "Found at index "
outputNotFound: .asciiz "Not found."

    .text
main:

    # Show input message
    li $v0, 4
    la $a0, input
    syscall

    # Read value to search in array
    li $v0, 5
    syscall

    # Store value into $t0
    move $t0, $v0

    # $t1 will point to the address of the array
    la $t1, array

    # #t2 will reference to the i-th element of the array
    move $t2, $t1

    # Iterator
    li $t3, 0

    # Array size
    li $t4, 9

loop:
    # i > size -> end_loop
    bge $t3, $t4, not_found

    # Read i-th element of the array
    lw $t5, 0($t2)

    beq $t5, $t0, found

    addi $t2, $t2, 4
    addi $t3, $t3, 1

    j loop

found:
    li $v0, 4
    la $a0, outputFound
    syscall

    # Calculate index that the value was found
    sub	$t6, $t2, $t1
    li $t7, 4
    div $t6, $t6, $t7

    li $v0, 1
    move $a0, $t6
    syscall

    j end

not_found:
    li $v0, 4
    la $a0, outputNotFound
    syscall

end:
    jr $ra











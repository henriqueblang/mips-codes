    .data
# int array[] = {1, 4, 5, 6};
array: .word 4, 1, 9, 6

    .text
main:

    # load array address into $t0
    la $t0, array

    # $t1 will reference the i-th element of the array, starting at 0 (initial address of array)
    move $t1, $t0

    # iterator (offset)
    li $t2, 0

    # last address offset (bytes)
    li $t3, 12

loop:

    # while $t2 < size (bytes)
    bgt	$t2, $t3, end_loop

    # print
    li $v0, 1
    lw $a0, 0($t1)
    syscall

    # add offset to $t1 (i.e, it will reference the next word)
    addi $t1, $t1, 4

    # add offset to iterator
    addi $t2, $t2, 4

j loop

end_loop:
    jr $ra
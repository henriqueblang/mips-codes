    .data
input: .asciiz "N: "
output: .asciiz "Fib: "

    .text
main:

    # Input message
    li $v0, 4
    la $a0, input
    syscall

    # Get input
    li $v0, 5
    syscall

    # Store input in $t0 (n)
    move $t0, $v0

    # Next-to-last
    li $t1, 0

    # Last
    li $t2, 1

    # Current
    add $t3, $t1, $t2

    # i
    li $t4, 2

loop: 
    bgt $t4, $t0, end

    add $t3, $t1, $t2
    move $t1, $t2
    move $t2, $t3
    addi $t4, $t4, 1

j loop

end:
    li $v0, 4
    la $a0, output
    syscall

    li $v0, 1
    move $a0, $t3
    syscall

    jr $ra
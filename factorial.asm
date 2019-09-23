    .data
input: .asciiz "N: "
output: .asciiz "Fatorial: "

    .text
main:

    # Show input message
    li $v0, 4
    la $a0, input
    syscall

    # Get input
    li $v0, 5
    syscall

    # Input to register
    move $t0, $v0

    # Factorial register
    li $t1, 1

    blez $t0, end_if

    # While help register
    li $t2, 1

while:
    ble $t0, $t2, end_if
    mul $t1, $t1, $t0
    addi $t0, $t0, -1

    j while

end_if:

    # Show output message
    li $v0, 4
    la $a0, output
    syscall

    # Show factorial
    li $v0, 1
    move $a0, $t1
    syscall

    jr $ra
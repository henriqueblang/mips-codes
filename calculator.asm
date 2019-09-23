    .data
    
operatorInput: .asciiz "Enter with operator: "
aInput: .asciiz "Enter with A: "
bInput: .asciiz "Enter with B: "

invalidOperator: .asciiz "Invalid operator."
invalidDivision: .asciiz "Invalid division (by 0)."

output: .asciiz "Result: "

    .text
main:

    # Load operators into registers
    li $t4, '+'
    li $t5, '-'
    li $t6, '*'
    li $t7, '/'

    # Operator input message
    li $v0, 4
    la $a0, operatorInput
    syscall

    # Read operator
    li $v0, 12
    syscall

    # Store operator in $t0
    move $t0, $v0

    # Print new line
    li $v0, 11
    li $a0, 10
    syscall

    # A input message
    li $v0, 4
    la $a0, aInput
    syscall

    # Read A
    li $v0, 5
    syscall

    # Store A in $t1
    move $t1, $v0

    # Print new line
    li $v0, 11
    li $a0, 10
    syscall

    # B input message
    li $v0, 4
    la $a0, bInput
    syscall

    # Read B
    li $v0, 5
    syscall

    # Store B in $t2
    move $t2, $v0

    # Jump to label according to operator
    beq $t0, $t4, plus
    beq $t0, $t5, minus
    beq $t0, $t6, times
    beq $t0, $t7, division

    # Print new line
    li $v0, 11
    li $a0, 10
    syscall

    # Invalid operator message
    li $v0, 4
    la $a0, invalidOperator
    syscall

    j end

# Plus label
plus:
    add $t3, $t1, $t2

    j end_operation

# Minus label
minus:
    sub	$t3, $t1, $t2

    j end_operation

# Times label
times:
    mul $t3, $t1, $t2

    j end_operation

# Division label
division:

    # Check for division by 0
    beq $t2, $0, invalid_division

    div $t3, $t1, $t2

    j end_operation

# Division by 0 label
invalid_division:

    # Print new line
    li $v0, 11
    li $a0, 10
    syscall

    # Invalid division message
    li $v0, 4
    la $a0, invalidDivision
    syscall

    j end

end_operation:

    # Print new line
    li $v0, 11
    li $a0, 10
    syscall

    # Result message
    li $v0, 4
    la $a0, output
    syscall

    # Print calculated result
    li $v0, 1
    move $a0, $t3
    syscall

end:
    jr $ra
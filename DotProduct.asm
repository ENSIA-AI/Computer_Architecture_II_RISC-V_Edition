.data
vector1: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
vector2: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

.text
addi a0, x0, 10
jal ra, DotProduct
j print
DotProduct:
addi sp, sp -20 # Make space for 5 words on the stack
sw ra, 0(sp) # Store the return address
sw s0, 4(sp) # Store register s0
sw s1, 8(sp) # Store register s1
sw s2, 12(sp) # Store register s2
sw s3, 16(sp) # Store register s3
add s0, a0, x0 # Set s0 equal to the size
add s1, x0, x0 # Set s1 equal to 0 (this is where we accumulate the sum)
la s2, vector1
la s3, vector2
add t0, x0, x0
loop:

bge x0, s0, end # Branch if s0 is not positive

lw a0, (s2)
lw a1, (s3)
jal ra, dot # Call the function dot
add s1, s1, a0 # Add the returned value into the accumulator s1
addi s0, s0, -1 # Decrement s0 by 1
addi s2, s2, 4 # Compute the addresses of the next elements
addi s3, s3, 4
jal x0, loop # Jump back to the loop label
end: 
add a0, s1, x0 # Set a0 to s1, which is the desired return value
lw ra, 0(sp) # Restore ra
lw s0, 4(sp) # Restore s0
lw s1, 8(sp) # Restore s1
lw s2, 12(sp) # Restore s2
lw s3, 16(sp) # Restore s3
addi sp, sp, 20 # Free space on the stack for the 5 words
jr ra # Return to the caller

dot: mul a0, a0, a1
jr ra

print:
addi a7, x0, 1
ecall

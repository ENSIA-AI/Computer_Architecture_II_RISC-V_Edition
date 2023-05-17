.data

ask1: .string "Please enter a number to compute its exp polynomial value:   "
msg: .string "The result is:   \n"

.text

la a0, ask1
li a7, 4
ecall

li a7, 5
ecall

#exp = x^5+6x^3+3x+4
add s0, x0, x0 # The final sum
add s1, x0, a0 # Save x 
# x^5
add a1, x0, a0
addi t0, x0, 4
jal ra, power
add s0, s0, a0
# + x^3
add a0, x0, s1
add a1, x0, a0
addi t0, x0, 2
jal ra, power
# + 6x^3
addi a1, x0, 6
jal ra, multiplication
add s0, s0, a0
# + 3x
addi a1, x0, 3
add a0, x0, s1
jal ra, multiplication
add s0, s0, a0
# +4
addi s0, s0, 4
j print

power:
addi sp, sp, -4
sw ra 0(sp)
loop:
beq t0, x0, end_loop
jal ra multiplication
addi t0, t0, -1
j loop

multiplication:
mul  a0, a0, a1
jr ra

end_loop:
lw ra, 0(sp)
addi sp, sp, 4
jr ra

print:

la a0, msg
li a7, 4
ecall

add a0, x0, s0
addi a7, x0, 1
ecall
.data

ask1: .string "Please enter a number to compute its factorial value:   "
msg: .string "The result is:   \n"

.text

la a0, ask1
li a7, 4
ecall

li a7, 5
ecall

jal ra, Factorial
j print

Factorial:

beqz a0, return
addi sp, sp, -8
sw ra, 4(sp)
sw a0, 0(sp)
addi a0, a0, -1
jal ra, Factorial
lw a1, 0(sp)
addi sp, sp, 4
mul a0, a1, a0
lw ra, 0(sp) 
addi sp, sp, 4
jr ra

return:
addi a0, x0, 1
jr ra


print:
add s0, x0, a0

la a0, msg
li a7, 4
ecall

add a0, x0, s0
addi a7, x0, 1
ecall
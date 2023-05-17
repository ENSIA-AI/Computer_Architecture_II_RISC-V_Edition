.data

ask1: .string "Please enter a number to compute its Fibonacci value:   "
msg: .string "The result is:   \n"

.text

la a0, ask1
li a7, 4
ecall

li a7, 5
ecall

addi t0, x0, 1
add s0, x0, x0

jal ra, Fibonacci
j print


Fibonacci:
bge t0, a0, BaseCase
addi sp, sp, -8
sw ra, 0(sp)
sw a0, 4(sp)
addi a0, a0, -1
jal ra, Fibonacci

lw a1, 4(sp)
sw a0, 4(sp)
addi a0, a1, -2
jal ra, Fibonacci
lw a1, 4(sp)
add a0, a0, a1
lw ra, 0(sp)
addi sp, sp, 8 

BaseCase:
jr ra

print:

add s0, x0, a0
la a0, msg
li a7, 4
ecall
add a0, x0, s0
addi a7, x0, 1
ecall

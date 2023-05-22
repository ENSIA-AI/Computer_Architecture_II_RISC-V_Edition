# Write a RISC-V program that defines a one-dimensional array of 10 integers in the 
#static area of the data segment, asks the user to input all 10 array elements, computes,
# and displays their sum.
.data
MyArray: .word 0:10
Result: .string "The sum of the array elements is:  \n"

.text

la s0, MyArray
add t0, x0, x0
addi t1, x0 ,10
add s1, x0, x0
addi a7, x0, 5

Read:
beq t0, t1, End
ecall
slli t2, t0, 2
add t2, s0, t2
add s1, s1, a0
sw a0, (t2)
addi t0, t0, 1
j Read
End:
la a0, Result
addi a7, x0, 4
ecall
add a0, x0, s1
addi a7, x0, 1
ecall
.data

EndLine: .string "\n"
EndMatrix: .string "##############################\n"
Space: .string "  "

.data

Matrix1: .word 2, 3,
	       4, 5
	       
Matrix2: .word 2, 3,
               4, 5

MatrixResult: .word 0, 0,
                    0, 0
	            
.text
# Base addresses
la s0, Matrix1
la s1, Matrix1
la s2, MatrixResult
addi s3, x0, 2 # Number of rows 0--3
addi s4, x0, 2 # Number of columns 0--3


addi t0, x0, 0 # i
FirstLoop:
beq t0, s3 EndFirstLoop

addi t1, x0, 0 # j
SecondtLoop:
beq t1, s3 EndSecondtLoop

addi t2, x0, 0 # k
add s5, x0, x0 # Holds a sum
ThirdLoop:
beq t2, s3 EndThirdLoop
# @Matrix_1[i,k] = base@ + (i * columns + k) * element size
mul t3, t0, s3
add t3, t3, t2
slli t3, t3, 2
add t3, t3, s0
lw a0, (t3)
add a1, x0, a0
# @Matrix_2[k,j] = base@ + (k * columns + j) * element size
mul t4, t2, s3
add t4, t4, t1
slli t4, t4, 2
add t4, t4, s1
lw a0, (t4)
mul a1, a1, a0
add s5, s5, a1
addi t2, t2, 1
j ThirdLoop
EndThirdLoop:
# @Matrix_Result[i,j] = base@ + (i * columns + j) * element size
mul t5, t0, s3
add t5, t5, t1
slli t5, t5, 2
add t5, t5, s2
sw s5, (t5)
addi t1, t1, 1
# Just printing
add a0, x0, s5
addi a7, x0, 1
ecall
la a0, Space
addi a7, x0, 4
ecall
j SecondtLoop
EndSecondtLoop:
addi t0, t0, 1
# Just a new line
la a0, EndLine
addi a7, x0, 4
ecall
j FirstLoop
EndFirstLoop:

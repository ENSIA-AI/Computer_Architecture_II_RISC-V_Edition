# Write a RISC-V program that allocates an n×n array of integers on the heap,
# where n is a user input. The program should compute and print the value of each element
# as follows:
#for (i=0; i<n; i++)
	#for (j=0; j<n; j++) {
 		#a[i][j] = i+j;
 		#if (i>0) a[i][j] = a[i][j] + a[i-1][j];
 		#if (j>0) a[i][j] = a[i][j] + a[i][j-1];
 		#print_int(a[i][j]);
 		#print_char(' ');
 		#}
 	#print_char('\n');
#}

.data
Ask_n: .string "Enter the value of N:  \n"
Space: .string " "
Back: .string "\n"


.text
la a0, Ask_n
addi a7, x0, 4
ecall
# Read the value of n
addi a7, x0, 5
ecall
# Save a0 in s0
add s0, x0, a0
# Allocate nxn array in the heap
mul a0, a0, a0
slli a0, a0, 2
# Save nxn in s1
add s1, x0, a0
addi a7, x0, 9
ecall
# Save the address of the array in s2
add s2, x0, a0

add t0, x0, x0 # i=0
First_loop:
beq t0, s0, End_First_loop
add t1, x0, x0 # j=0
Second_loop:
beq t1, s0, End_Second_loop
# @Matrix_1[i,j] = base@ + (i * columns + j) * element size
mul t2, t0, s0 # i * columns
add t2, t2, t1 # (i * columns + j)
slli t2, t2, 2 # (i * columns + j) * element size
add t2, t2, s2 # base@ + (i * columns + j) * element size
#a[i][j] = i+j;
add t3, t1, t0
sw t3, (t2)
#if (i>0) a[i][j] = a[i][j] + a[i-1][j];
blez t0, Second_If
addi t4, t0, -1 # [i-1]
mul t5, t4, s0 # [i-1] * columns
add t5, t5, t1 # ([i-1] * columns + j)
slli t5, t5, 2 # ([i-1] * columns + j) * element size
add t5, t5, s2 # base@ + ([i-1] * columns + j) * element size
lw t4, (t5)
lw t3, (t2)
add t4, t3, t4
sw t4, (t2)
Second_If:
#if (j>0) a[i][j] = a[i][j] + a[i][j-1];
blez t1, print
addi t4, t1, -1 # [j-1]
mul t5, t0, s0 # i * columns
add t5, t5, t4 # (i * columns + [j-1])
slli t5, t5, 2 # (i * columns + [j-1]) * element size
add t5, t5, s2 # base@ + (i * columns + [j-1]) * element size
lw t4, (t5)
lw t3, (t2)
add t4, t3, t4
sw t4, (t2)
print:
#print_int(a[i][j]);
lw a0, (t2)
addi a7, x0, 1
ecall
#print_char(' ');
la a0, Space
addi a7, x0, 4
ecall
addi t1, t1, 1
j Second_loop
End_Second_loop:
addi t0, t0, 1
la a0, Back
ecall
j First_loop
End_First_loop:

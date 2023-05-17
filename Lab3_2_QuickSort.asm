# Solution of Exercise 2 - lab 3: Quick Sort Implementation
# By: Omar Farouk ZOUAK
.data
# N.B.: If you update the array here, don't forget to change the array size in line 10 as well!
arr: .word -1, 22, 8, 35, 5, 4, 11, 2, 1, 78
separator: .string ", " # will be used to separate array items when printing

.text
la s0, arr # Load array into s0
li s1, 10 # Array size

# Preparing to call quicksort
mv a0, s0 # First argument is A
li a1, 0 # Second argument is low = 0
addi a2, s1, -1 # Third argument is high = size - 1 
jal quicksort # Calling quicksort(A, 0, size - 1)

# Jump to print section after sorting
j print


quicksort:
	# Save used registers
	addi sp, sp, -20
	sw s0, 0(sp)
	sw s1, 4(sp) 
	sw s2, 8(sp)
	sw s3, 12(sp)
	sw ra, 16(sp)
	
	bge a1, a2, endsort # if low >= hi, just end, else continue
	
	mv s0, a0 # Save A, because [a0-a7] should be saved by the caller before function call
	mv s1, a1 # Save lo
	mv s2, a2 # Save hi
	
	# p = partition(A, lo, hi)
	jal partition # Call partition(A, lo, hi) - i.e. with the same arguments received -
	mv s3, a0 # Save p, which is returned from partition function, i.e. found in a0
	
	# Call quicksort(A, lo, p-1)
	mv a0, s0 # First argument is A
	mv a1, s1 # Second argument is lo
	mv a2, s3
	addi a2, a2, -1 # Third argument is p-1
	jal quicksort
	
	# Call quicksort(A, p+1, hi)
	mv a0, s0 # First argument is A
	mv a2, s2 # Third argument is high
	mv a1, s3
	addi a1, a1, 1 # Second argument is p+1
	jal quicksort
	
	endsort:
	# Restore registers back and return
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw s3, 12(sp)
	lw ra, 16(sp)
	addi sp, sp, 20
	jr ra


partition:
	# Saving registers
	addi sp, sp, -28
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw s3, 12(sp)
	sw s4, 16(sp)
	sw s5, 20(sp)
	sw ra, 24(sp)
	
	# Save array's base address
	mv s5, a0
	
	# Mulyiply by 4 (Using shift left) to get the address, because every item is a word of 4 bytes long (32 bits)
	slli s3, a1, 2 # 4 * Low, later it will be j
	slli s4, a2, 2 #  4 * High, we will use it to compare j
	
	add s0, s5, s4 # s0 now holds the "address" of pivot = A[high]
	lw s2, 0(s0) # s2 now holds the "value" of pivot = A[high]
	
	addi s1, s3, -4 # s1 holds i = low - 1 (Again, -4 instead of -1 because we are working with addresses and each item is 4 bytes long)
	
	for:
	add t0, s5, s3 # t0 now holds the address of A[j]
	lw t1, 0(t0) # t2 now holds the value of A[j]
	blt s2, t1, endfor # If A[j] < pivot, we move to next iteration
	addi s1, s1, 4 # i = i + 1
	
	# Swap A[i] and A[j]
	add a0, s5, s1 # The first argument is the address of A[i]
	mv a1, t0 # The second argument is the address of A[j]
	jal swap
	
	endfor:
	addi s3, s3, 4 # j = j + 1
	blt s3, s4, for # Loop again if j < high
	
	next:
	# Swap A[i+1] and A[high]
	addi s1, s1, 4 # s1 now holds i + 1
	add a0, s5, s1 # The first argument is the address of A[i+1]
	mv a1, s0 # The second argument is the address of A[high]
	jal swap
	
	endpartition:
	mv a0, s1 # a0 = 4(i + 1), because we will be returning the value i + 1 (a0 holds the return value)
	srli a0, a0, 2 # Divide everything by 4, to get the correct index back (The index was multiplied by 4 because each word is 4 bytes long, remember)
	
	# Restore registers and return
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw s3, 12(sp)
	lw s4, 16(sp)
	lw s5, 20(sp)
	lw ra, 24(sp)
	addi sp, sp, 28
	jr ra


swap:
	lw t0, 0(a0) # s0 holds the value in address a0
	lw t1, 0(a1) # s0 holds the value in address a1
	
	sw t1, 0(a0) # a0 is now storing the value s1
	sw t0, 0(a1) # a1 is now storing the value s0
	
	jr ra # Return


print:
li t1, 4
mul s1, s1, t1 # Multiply s1, which holds the array size, by 4 to use it for comparision with the counter
la t0, separator # Load separator string, in order to print a separator after each element
li t2, 0 # Counter, initially 0
printloop:
beq s1, t2, end # If the counter t2 reached the array size (which is saved in s1), we are done! So, end the program
add t3, t2, s0 # t3 now holds the "address" of A[counter]
lw a0, 0(t3) # a0 now holds the "value" of A[counter], after loading it from memory using the address in t3
li a7, 1 # 1 system call is used for printing integers
ecall # Execute system call
mv a0, t0 # a0 holds the address of the separator string
li a7, 4 # 4 system call is used for printing strings
ecall # Execute system call
addi t2, t2, 4 # Increment counter by 4 because we are working with addresses
b printloop

end:
li a7, 10 # Exit system call, with code 0 (No errors)
ecall 
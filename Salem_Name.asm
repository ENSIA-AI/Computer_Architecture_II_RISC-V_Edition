.data
first:.string "Salem "
name: .space 20
.text 
la a0, name
li a1, 20
li a7, 8
ecall
la a0, first
li a7, 4
ecall
la a0, name
ecall
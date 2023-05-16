.data
ask: .string "Please enter your name:   "
msg:.string "Salem "
name: .space 20

.text 

la a0, ask

li a7, 4
ecall

la a0, name
li a1, 20
li a7, 8
ecall
la a0, msg
li a7, 4
ecall
la a0, name
ecall

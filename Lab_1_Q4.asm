.data

# The following are the result messages
eq_str: .string "These values are equal"
not_eq_str: .string "These values are not equal"

ask1: .string "Please enter the first value:   "
ask2: .string "Please enter the second value:   "

.text

la a0, ask1
li a7, 4
ecall

li a7, 5
ecall

mv t0, a0

la a0, ask2
li a7, 4
ecall

li a7, 5
ecall

mv t1, a0

bne t0, t1, not_equal
equal: 
la a0, eq_str
j The_exit

not_equal:
la a0, not_eq_str
The_exit:

li a7, 4
ecall

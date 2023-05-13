.data
#declaration part
MyString:
.string "hello world"

.text
#instruction

#load the address of str
la a0, MyString
li a7, 4
ecall

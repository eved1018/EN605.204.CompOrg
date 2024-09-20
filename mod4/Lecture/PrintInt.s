#
# Program Name: PrintName
# Author: Evan Edelstein
# Date: 9/14/24
# Purpose: prompt, read and print users age
#



.text
.global main

main:
    # Push the stack
    SUB sp,sp, #4
    STR lr, [sp, #0]

    # Prompt the user
    LDR r0, =prompt1
    BL printf

    # Read in name
    LDR r0, =format1
    LDR r1, =age1
    BL scanf

    # Print the users name
    LDR r0, =output1
    LDR r1, =age1
    LDR r1, [r1, #0]
    BL printf

    # Pop the stack
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt1: .asciz "Please enter your age: "
    format1: .asciz "%d"
    age1: .word 0
    output1: .asciz "Your age is %d\n"

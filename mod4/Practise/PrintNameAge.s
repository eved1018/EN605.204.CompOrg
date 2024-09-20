#
# Program Name: PrintName
# Author: Evan Edelstein
# Date: 9/14/24
# Purpose: prompt, read and print users name and age
# 

.text
.global main

main:
    # Push the stack 
    SUB sp,sp, #4 
    STR lr, [sp, #0]
    
    # Prompt the user for name
    LDR r0, =prompt1
    BL printf

    # read in name
    LDR r0, =format1
    LDR r1, =name1
    BL scanf

    # Prompt the user for age
    LDR r0, =prompt2
    BL printf

    # read in age
    LDR r0, =format2
    LDR r1, =age1
    BL scanf

    # print the users name and age 
    LDR r0, =output
    LDR r1, =name1
    LDR r2, =age1
    LDR r2, [r2, #0]
    BL printf

    # Pop the stack 
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt1: .asciz "Please enter your name: "
    format1: .asciz "%s"
    name1: .space 40
    prompt2: .asciz "Please enter your age: "
    format2: .asciz "%d"
    age1: .word 0
    output: .asciz "Your name is \t %s \t and your age is \t %d \t \n"
    

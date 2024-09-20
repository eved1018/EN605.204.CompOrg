#
# Program Name: PrintName
# Author: Evan Edelstein
# Date: 9/14/24
# Purpose: prompt, read and print users name
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

    # read in name
    LDR r0, =format1
    LDR r1, =name1
    BL scanf

    # print the users name
    LDR r0, =output1
    LDR r1, =name1
    BL printf

    # Pop the stack 
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt1: .asciz "Please enter your name: "
    format1: .asciz "%s"
    name1: .space 40
    output1: .asciz "Your name is \"%s\"\n"

#
# Program Name: Negate.s
# Author: Evan Edelstein
# Date: 9/19/2020
# Purpose: This program negates a number using 2s compliment operation
# program using gcc #

.text
.global main
main:
    # Save return to OS on stack 
    SUB sp, sp, #4
    STR lr, [sp, #0]
    
    # Enter your program here.
    LDR r0, =prompt1
    BL printf


    LDR r0, =format1
    LDR r1, =num
    BL scanf

    LDR r0, =num
    LDR r0, [r0]

    MVN r0, r0
    ADD r1,r0, #1

    LDR r0, =output
    BL printf

    # Return to the OS 
    LDR lr, [sp, #0]
    ADD sp, sp, #4 
    MOV pc, lr
    
.data
    prompt1: .asciz "Enter a number to negate "
    format1: .asciz "%d"
    num: .word 0
    output: .asciz "%d\n"

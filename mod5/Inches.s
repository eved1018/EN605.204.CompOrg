#
# Program Name: Inches.s
# Author: Evan Edelstein
# Date: 9/19/2020
# Purpose: This program converts feet and inches to total inches 
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
    LDR r1, =feet 
    BL scanf

    LDR r0, =feet 
    LDR r5, [r0]

    LDR r0, =prompt2
    BL printf

    LDR r0, =format1
    LDR r1, =inches
    BL scanf

    LDR r0, =inches 
    LDR r6, [r0]


    MOV r4, #12
    MUL r5, r5, r4

    ADD r1, r5, r6

    LDR r0, =output
    BL printf


    # Return to the OS 
    LDR lr, [sp, #0]
    ADD sp, sp, #4 
    MOV pc, lr
    
.data
    prompt1: .asciz "Enter feet \n"
    prompt2: .asciz "Enter inches \n"
    format1: .asciz "%d"
    feet: .word 0
    inches: .word 0
    output: .asciz "Total Inches: %d\n"



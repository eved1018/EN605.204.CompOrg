#
# Program Name: recMultiply.s
# Author: Evan Edelstein
# Date: 9/19/2020
# Purpose: Recursivly multiply 2 numbers
# program using gcc #
.global main
.global Multiply



.text
Multiply:
    // Add room on the stack for 2 variables and sp
    SUB sp, sp, #12
    STR lr, [sp, #0]
    STR r4, [sp, #4]
    STR r5, [sp, #8]
    // Save argument in r4 and r5

    MOV r4, r0 // x
    MOV r5, r1 // y

    // if y == 1 return x
    CMP r1, #1
    BNE Else
    B Return 

    // else return x + mult(x,y-1)
    Else:
        SUB r1, r1, #1
        BL Multiply
        ADD r0, r4, r0
        B Return

    // Manage stack
    Return:
        LDR lr, [sp, #0]
        LDR r4, [sp, #4]
        LDR r5, [sp, #8]
        ADD sp, sp, #12
        MOV pc, lr
.data
# END Multiply

.text
main:
    # Save return to OS on stack 
    SUB sp, sp, #4
    STR lr, [sp, #0]
    
    // Prompt user for two numbers to multiply
    LDR r0, =prompt1
    BL printf

    // Collect user input
    LDR r0, =format1
    LDR r1, =x
    LDR r2, =y
    BL scanf 
    
    // Save first value
    LDR r0, =x
    LDR r0, [r0]

    // Save second value
    LDR r1, =y
    LDR r1, [r1]

    // Multiply the 2 numbers
    BL Multiply
       
    // Print the product
    MOV r1, r0
    LDR r0, =output
    BL printf


    # Return to the OS 
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
    
.data
    prompt1: .asciz "Enter two numbers to multiply: \n"
    format1: .asciz "%d %d"
    x: .word 0 
    y: .word 0 
    output: .asciz "Rsult is %d\n"


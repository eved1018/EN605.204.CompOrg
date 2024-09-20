#
# Program Name: Swap.s
# Author: Evan Edelstein
# Date: 9/19/2020
# Purpose: This program swaps 2 variables without a temp var using xor.
# program using gcc 

.text
.global main
main:
    # Save return to OS on stack 
    SUB sp, sp, #4
    STR lr, [sp, #0]
    
    # Enter your program here.
    LDR r0, =prompt1
    BL printf

    LDR r0, =format
    LDR r1, =num1
    LDR r2, =num2
    BL scanf
    
    LDR r3, =num1
    LDR r3, [r3]

    LDR r4, =num2
    LDR r4, [r4]


    // Swap r3 and r4
    EOR r3, r4, r3 // r3 now "holds" both values  

    EOR r4, r3, r4 // get out first value out
    EOR r3, r4, r3 // get the second value out


    LDR r0, =output
    MOV r1, r3
    MOV r2, r4
    BL printf


    # Return to the OS 
    LDR lr, [sp, #0]
    ADD sp, sp, #4 
    MOV pc, lr
    
.data

    prompt1: .asciz "\nEnter two numbers: "
    prompt2: .asciz "\nEnter the second number: "
    format: .asciz "%d %d"
    num1: .word 0
    num2: .word 0
    output: .asciz "\nFist is now %d and second is now %d \n"


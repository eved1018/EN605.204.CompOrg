
#
# Program Name: FeetAndInches.s
# Author: Evan Edelstein
# Date: 9/19/2020
# Purpose: This program converts total inches to feet and inches 
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
    LDR r1, =inches
    BL scanf

    LDR r0, =inches 
    LDR r4, [r0] // r3 will hold the orginal total inches
    
    // Alg: 

    MOV r0, r4
    MOV r1, #12
    BL __aeabi_idiv
    MOV r5, r0 // r5 will hold whole number of feet

    // Get r4 to be the remainder -> convert to fraction of feet -> convert to inches
    MOV r6, #12
    MUL r0, r5, r6
    SUB r3, r4, r0 // r4 has remaining inches inches 
    

    LDR r0, =output
    MOV r1, r4
    MOV r2, r5
    BL printf

    # Return to the OS 
    LDR lr, [sp, #0]
    ADD sp, sp, #4 
    MOV pc, lr
    
.data
    prompt1: .asciz "\nEnter inches "
    format1: .asciz "%d" 
    inches: .word 0
    output: .asciz "\n%d inches => %d feet, %d inches \n"



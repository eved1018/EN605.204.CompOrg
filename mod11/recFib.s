#
# Program Name: recFib
# Author: Evan Edelstein
# Date: 9/19/2020
# Purpose: This program recursivly computes the nth Fibonacci number.
# program using gcc #
.global main
.global Fib

.text 
Fib:
    // Push Stack
    SUB sp, sp, #8
    STR lr, [sp]
    STR r4, [sp, #4]
    
    MOV r4, r0 // n

    // if n == 0 return 1
    CMP r0, #1
    BGT Else
    MOV r0, #1
    B Return
//                    r2       r3   
    Else: // return fib(n-1) + fin(n-2)
        SUB r0, r0, #1
        BL Fib
        MOV r2, r0

        MOV r0, r4 // store prev n

        SUB r0, r0, #2
        BL Fib
        MOV r3, r0
        ADD r0, r2, r3
        B Return


    // Pop from stack
    Return:
        LDR lr, [sp]
        LDR r4, [sp, #4]
        ADD sp, sp, #8
        MOV pc, lr

   .data
# END fn 


.text
main:
    # Save return to OS on stack 
    SUB sp, sp, #4
    STR lr, [sp, #0]
    
    # Enter your program here.

    LDR r0, =prompt1
    BL printf


    LDR r0, =format1
    LDR r1, =value
    BL scanf 

    LDR r0, =value
    LDR r0, [r0]

    BL Fib

    MOV r1, r0
    LDR r0, =output
    BL printf

    # Return to the OS 
    LDR lr, [sp, #0]
    ADD sp, sp, #4 
    MOV pc, lr
    
.data
    prompt1: .asciz "Enter the nth Fibonacci to compute: \n "
    format1: .asciz "%d"
    value: .word 0 
    output: .asciz "Rsult is %d\n"

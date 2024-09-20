#
# Program Name: TimesTen.s
# Author: Evan Edelstein
# Date: 9/19/2020
# Purpose: This program multiples an number by ten.
# program using gcc

.text
.global main
main:
    # Save return to OS on stack 
    SUB sp, sp, #4
    STR lr, [sp, #0]
    
    # Enter your program here.

    LDR r0, =prompt
    BL printf

    LDR r0, =format
    LDR r1, =num
    BL scanf

    LDR r4, =num
    LDR r4, [r4] // r4 now stores out input value

    // x *10 => x * 2^3 + x * 2^1

    LSL r1, r4, #3
    LSL r2, r4, #1
    ADD r1, r1, r2

    LDR r0, =output
    BL printf


    # Return to the OS 
    LDR lr, [sp, #0]
    ADD sp, sp, #4 
    MOV pc, lr
    
.data
    prompt: .asciz "\nEnter a number to multiply by 10: "
    num: .word 0
    format: .asciz "%d"
    output: .asciz "%d\n"


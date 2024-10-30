#
# Program Name: template.s
# Author: Evan Edelstein
# Date: 9/19/2020
# Purpose: This program is template that can be used to start ARM assembly
# program using gcc #
.global main


.text
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

    LDR r1, =num
    LDR r6, [r1]

    LDR r0, =prompt2
    BL printf


    LDR r0, =format1
    LDR r1, =denom
    BL scanf 

    LDR r0, =denom
    LDR r1, [r0]

    MOV r0, r6

    BL __aeabi_idivmod


    LDR r0, =output
    BL printf


    # Return to the OS 
    LDR lr, [sp, #0]
    ADD sp, sp, #4 
    MOV pc, lr
    
.data
    prompt1: .asciz "Enter numarator: "
    prompt2: .asciz "Enter denomanator: "
    format1: .asciz "%d"
    num: .word 0 
    denom: .word 0
    output: .asciz  "%d \n"



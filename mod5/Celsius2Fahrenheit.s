
#
# Program Name: Celsius2Fahrenheit.s
# Author: Evan Edelstein
# Date: 9/19/2024
# Purpose: This program is to convert a tempature from Celsius to Fahrenheit
# program using gcc #

.text
.global main
main:
    # Save return to OS on stack 
    SUB sp, sp, #4
    STR lr, [sp, #0]

    LDR r0, =prompt1
    BL printf


    LDR r0, =format1
    LDR r1, =temp
    BL scanf  

    LDR r0, =temp
    LDR r0, [r0]
    
    # F = (C * 9/5) + 32 


    MOV r1, #9
    MUL r0, r0, r1


    MOV r1, #5
    BL __aeabi_idiv


    ADD r0, r0, #32

    MOV r1, r0

    LDR r0, =output
    BL printf

    
    # Return to the OS 
    LDR lr, [sp, #0]
    ADD sp, sp, #4 
    MOV pc, lr
    
.data
    prompt1: .asciz "Enter a Tempature in Celsius to convert to Fahrenheit "
    format1: .asciz "%d"
    temp: .word 0
    output: .asciz "%df\n"

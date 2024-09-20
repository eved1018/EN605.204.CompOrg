#
# Program Name: Fahrenheit2Celsius.s
# Author: Evan Edelstein
# Date: 9/19/2024
# Purpose: This program is to convert a tempature from Fahrenheit to Celsius  
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

    # C = (F - 32) * 5/9
    LDR r0, =temp
    LDR r0, [r0]

    SUB r0, r0, #32

    MOV r1, #5
    MUL r0, r0, r1
    
    MOV r1, #9
    BL __aeabi_idiv

    MOV r1, r0

    LDR r0, =output
    BL printf

    
    # Return to the OS 
    LDR lr, [sp, #0]
    ADD sp, sp, #4 
    MOV pc, lr
    
.data
    prompt1: .asciz "Enter a Tempature in Fahrenheit to convert to Celsius "
    format1: .asciz "%d"
    temp: .word 0
    output: .asciz "%dc\n"

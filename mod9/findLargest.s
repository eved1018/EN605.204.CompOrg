 # Author: Evan Edelstein
# Date: 9/19/2020
# Purpose: This program finds the l;argets of three input values
# program using gcc #
.global main
.global findMaxOf3

.text 
findMaxOf3:
    // Push Stack
    SUB sp, sp, #4
    STR lr, [sp]
    MOV r4, r0


    CMP r0, r1
    BGT Comp02
        // r0 less than r1
        CMP r1,r2
        BGT printr1
            B printr2

    Comp02:
        CMP r0, r2
        BGT printr0
            // r0 is less than r2
            B printr2

    printr2:
        LDR r0, =out
        MOV r1, r2
        BL printf
        B exit


    printr0:
        MOV r1, r0
        LDR r0, =out
        BL printf
        B exit

    printr1:
        LDR r0, =out
        BL printf
        B exit
   
    exit:
    // pop the stack
    LDR lr, [sp]
    ADD sp, sp , #4
    MOV pc, lr


.data
    out: .asciz "Max is %d\n"

// END findMaxOf3


.text 
main:

    // Push Stack
    SUB sp, sp, #4
    STR lr, [sp]

    // fn code
    LDR r0, =prompt1
    BL printf

    LDR r0, =format1
    LDR r1, =val1
    BL scanf

    LDR r0, =val1
    LDR r0, [r0]
    MOV r5, r0

    LDR r0, =prompt2
    BL printf

    LDR r0, =format2
    LDR r1, =val2
    BL scanf

    LDR r0, =val2
    LDR r0, [r0]
    MOV r6, r0

    LDR r0, =prompt3
    BL printf

    LDR r0, =format3
    LDR r1, =val3
    BL scanf

    LDR r0, =val3
    LDR r0, [r0]
    MOV r7, r0

    MOV r0, r5
    MOV r1, r6
    MOV r2, r7

    BL findMaxOf3

    // pop the stack 
    LDR lr, [sp]
    ADD sp, sp , #4
    MOV pc, lr



.data
    prompt1: .asciz "Please enter the first number \n"
    format1: .asciz "%d"
    val1: .word 0

    prompt2: .asciz "Please enter the second number \n"
    format2: .asciz "%d"
    val2: .word 0

    prompt3: .asciz "Please enter the third number \n"
    format3: .asciz "%d"
    val3: .word 0

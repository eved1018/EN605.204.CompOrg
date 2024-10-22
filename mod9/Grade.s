#
# Program Name: Grade.s
# Author: Evan Edelstein
# Date: 9/19/2020
# Purpose: This program converts a number grade into a letter grade
# program using gcc #


.global main
.global printGrade


.text 
printGrade:
     // Push Stack
    SUB sp, sp, #4
    STR lr, [sp]
    MOV r4, r0


    // if grade is above 100 or less than 0
    MOV r0, #0
    CMP r4, #0
    MOVLT r0, #1
    

    MOV r1, #0
    CMP r4, #100
    MOVGT r1, #1

    ORR r0, r0, r1
    CMP r0, #0
    BEQ noError
        // if error
        LDR r0, =error
        MOV r1, r4
        BL printf
        B exit


    noError:
        // print grade
        // if grade is greater than 90
        CMP r4, #90
        BLT GradeB
            // print A
            LDR r0, =grade1
            BL printf
            B exit

         GradeB:
             CMP r4, #80
             BLT GradeC
                // printb
                LDR r0, =grade2
                BL printf 
                B exit

         GradeC:
             CMP r4, #70
             BLT GradeF
                //printc
                LDR r0, =grade3
                BL printf
                B exit
            
         GradeF:
            //printf
            LDR r0, =grade4
            BL printf
            B exit
        
    exit:
    // pop the stack
    LDR lr, [sp]
    ADD sp, sp , #4
    MOV pc, lr

.data
    error: .asciz "Could not grade value %d, must be between 0 and 100 \n"
    grade1: .asciz "Grade is A\n"
    grade2: .asciz "Grade is B\n"
    grade3: .asciz "Grade is C\n"
    grade4: .asciz "Grade is F\n"
// END printGrade


.text 
main: 
    # Save return to OS on stack
    SUB sp, sp, #8
    STR lr, [sp, #0]

    # Enter your program here.

    LDR r0, =prompt1
    BL printf

    LDR r0, =format1
    LDR r1, =name
    BL scanf

    LDR r0, =name
    LDR r0, [r0]
    MOV r2, r0

    // prompt for input grade
    LDR r0, =prompt2
    BL printf

    LDR r0, =format2
    LDR r1, =grade
    BL scanf

    LDR r0, =grade
    LDR r5, [r0]

    LDR r0, =out1
    LDR r1, =name
    BL printf

    MOV r0, r5
    BL printGrade


    # Return to the OS
    LDR lr, [sp, #0]
    ADD sp, sp, #8
    MOV pc, lr




.data
    prompt1: .asciz "Enter name: "
    format1: .asciz "%s"
    prompt2: .asciz "Enter grade value: "
    format2: .asciz "%d"
    name: .asciz "%s"
    grade: .word 0
    out1: .asciz "Name: %s \n"

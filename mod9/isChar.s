#
# Program Name: isChar.s
# Author: Evan Edelstein
# Date: 10/21/2024
# Purpose: This program checks if a user inputed a charecter
# program using gcc #
.global main
.global logical_check
.global conditional_check

.text
logical_check:

    // Push Stack
    SUB sp, sp, #4
    STR lr, [sp]
    MOV r4, r0
    MOV r1, r0


    // check that the input string is a char
    //if ((r1>=0x41 && r1<=0x5a) || (r1>=0x61 && r1<= 0x7a)) //is r1 a character?
    MOV r2, #0 // All bits are 0
    CMP r1, #0x41
    ADDGE r2, #1 // if true, bit 0 is changed to 1

    MOV r3, #0
    CMP r1, #0x5A
    ADDLE r3, #1
    AND r2, r2, r3 // Results from first AND, if true r1 is uppercase

    MOV r0, #0
    CMP r1, #0x61
    ADDGE r0, #1

    MOV r3, #0
    CMP r1, #0x7A
    ADDLE r3, #1
    AND r3, r3, r0 // Results from second AND, if true r1 is lowercase
    ORR r2, r2, r3 // Results from OR, if true r1 is a letter
    
    CMP r2, #1
    BGE label1
        // print is not char
        LDR r0, =out2
        BL printf
        B Endprint

    label1: //print is char
        LDR r0, =out1
        BL printf
        B Endprint

    Endprint:

    // pop the stack 
    LDR lr, [sp]
    ADD sp, sp , #4
    MOV pc, lr
.data
    out1: .asciz "[logical check] value is a charecter\n"
    out2: .asciz "[logical check] value is not a charecter\n"
# END logical_check


.text 
conditional_check:

    MOV r4, r0
    
    // if (a > 0x5a) goto checkLower
    CMP r0, #0x5a
    BGE checkLower

    // if (a > 0x41) goto validCharacter
    CMP r0, #0x41
    BGE validCharacter

    // goto invalidCharacter
    B invalidCharacter


    checkLower:
        // if (a > 0x7a) goto InvalidCharacter
        CMP r0, #0x7a
        BGE invalidCharacter

        // if (a > 0x61) goto ValidCharacter
        CMP r0, #0x61
        BGE validCharacter
    
    //goto InvalidCharacter
    B invalidCharacter

    validCharacter:
        LDR r0, =outA
        BL printf
        B Endprint2

    invalidCharacter:    
        // print is not char
        LDR r0, =outB
        BL printf
        B Endprint2

    Endprint2:

    // pop the stack 
    LDR lr, [sp]
    ADD sp, sp , #4
    MOV pc, lr


.data
    outA: .asciz "[conditional check] value is a charecter\n"
    outB: .asciz "[conditional check] value is not a charecter\n"
# END conditional_check

.text
main:
    # Save return to OS on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    // prompt for input
    LDR r0, =prompt1
    BL printf

    LDR r0, =format1
    LDR r1, =val
    BL scanf

    LDR r0, =val
    LDR r0, [r0]
    BL logical_check
    
    BL conditional_check

    # Enter your program here.
    # Return to the OS
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt1: .asciz "Enter a value and check if it is a charecter: \n"
    format1: .asciz "%s"
    val:    .asciz "%s"



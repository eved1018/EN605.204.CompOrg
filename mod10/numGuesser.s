#
# Program Name: template.s
# Author: Evan Edelstein
# Date: 9/19/2020
# Purpose: A guessing game, the user enters maximum number and must guess a random number from 0->max
# program using gcc #
.global main
.global ishighLow
.global randFunc
.global getRemainder



.text 
getRemainder:
    // Push Stack
    SUB sp, sp, #4
    STR lr, [sp]


    // r0 has random number
    // r1 is max 
    
    CMP r0, r1
    BLE endRemainder


    SubtarctFactor:
        SUB r0, r0, r1
        CMP r0, r1
        BLT endRemainder
        B SubtarctFactor
        
    endRemainder:
    // pop the stack 
    LDR lr, [sp]
    ADD sp, sp , #4
    MOV pc, lr

// END getRemainder

.text
	// Purpose: To retrieve a random number from 0..r0
randFunc:

    // Push Stack
    SUB sp, sp, #4
    STR lr, [sp]
    
    MOV r6, r1

    MOV r0, #0
    BL time
    BL srand
    BL rand

    MOV r1, r6
    BL getRemainder
    // r0 has random number under max

    // pop the stack 
    LDR lr, [sp]
    ADD sp, sp , #4
    MOV pc, lr
// END randFunc



.text 
isHighLow:
    // Push Stack
    SUB sp, sp, #4
    STR lr, [sp]
    
    // fn code : r0 => secret, r1 => guess
    CMP r1, r0
    BLT low
      B high

    low:
        LDR r0, =plow
        BL printf
        B end
    high:
        LDR r0, =phigh
        BL printf
        B end
    equal:
        LDR r0, =peq
        BL printf
        B end


    end:
    // pop the stack 
    LDR lr, [sp]
    ADD sp, sp , #4
    MOV pc, lr
.data
    plow: .asciz "Guess %d is lower than random number \n"
    phigh: .asciz "Guess %d is higher than random number \n"
# END isHighLow


.text
main:
    # Save return to OS on stack 
    SUB sp, sp, #4
    STR lr, [sp, #0]

    LDR r0, =promptMax
    BL printf

    LDR r0, =formatMax
    LDR r1, =max
    BL scanf 

    LDR r1, =max
    LDR r1, [r1]

    BL randFunc // r0 is the random number
    // r0 is our random number that is less than r1 (max)

    MOV r5, r0 

    promptUser:

        // prompt number from user
        LDR r0, =prompt
        BL printf


        LDR r0, =format
        LDR r1, =num
        BL scanf 

        MOV r0, r5 // move the random num into r0

        LDR r1, =num
        LDR r1, [r1]

        CMP r0,r1
        BEQ endMain
            BL isHighLow
            B promptUser
        B endMain

    endMain:
     LDR r0, =peq
     BL printf
    
    # Return to the OS 
    LDR lr, [sp, #0]
    ADD sp, sp, #4 
    MOV pc, lr
    
.data
    promptMax: .asciz "Enter maximum random number: "
    formatMax: .asciz "%d"
    max: .word 0
    prompt: .asciz "Enter a guess: "
    format: .asciz "%d"
    num:    .word 0 
    peq: .asciz "Correct secret number was %d \n"

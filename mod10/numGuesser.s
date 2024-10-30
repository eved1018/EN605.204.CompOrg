#
# Program Name: template.s
# Author: Evan Edelstein
# Date: 9/19/2020
# Purpose: This program is template that can be used to start ARM assembly
# program using gcc #
.global main
.global ishighLow
.global randFunc

.text
	// Purpose: To retrieve a random number from 0..r0
randFunc:
	SUB sp, sp, #8
	STR lr, [sp]
	STR r5, [sp, #4]
	// Get the random number, setting the limit using a modulus operation
    MOV r3, r0
    MOV r0, #12 // seed
	BL srand // r0 already has the seed
	BL rand
	MOV r4, r0 // Save the random number
	// Modulus operation
	MOV r1, #100
	BL __aeabi_idiv
	MOV r1, #100
	MUL r0, r0, r1
	SUB r0, r4, r0
	LDR lr, [sp]
	LDR r4, [sp, #4]
	ADD sp, sp, #8
	MOV pc, lr

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
    LDR r0, [r1]

    BL randFunc // r0 is the random number

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

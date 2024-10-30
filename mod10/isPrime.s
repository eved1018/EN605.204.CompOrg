#
# Program Name: template.s
# Author: Evan Edelstein
# Date: 9/19/2020
Purpose: Check of a number is prime
# program using gcc #
.global main
.global checkPrime
.global getRemainder
   

.text
checkPrime:
    // Push Stack
    SUB sp, sp, #4
    STR lr, [sp]

    // fn code
    // num
    MOV r4, r0
    // how many divisors
    MOV r2, #0

    
    // check if num is less than one
    CMP r0, #1
    BLT printNotPrime
        // gt than 1
        # initialize the loop,
        # r1 - counter init to 1
        # r3 - loop limit: n

        MOV r1, #1
        mov r3, r0

        StartPrimeLoop:
          CMP r3, r1
          BLE EndPrimeLoop
              # Loop Block

              MOV r5, r0
              MOV r6, r1
              MOV r7, r3
              // r0 is num and r1 is loop var
              // divide num/loopcounter
              BL __aeabi_idivmod
              MOV r3, r1
              
              MOV r0, r5
              MOV r1, r6
              // everything is reset and r3 holds modulo
          
              CMP r3, #0
              // if mod is zero add to div counter
              ADDEQ r2, r2, #1
              MOV r3, r7

              # Get next value
              ADD r1, r1, #1
              B StartPrimeLoop

          EndPrimeLoop:
            CMP r2, #2
            BGT printNotPrime
                B printPrime

    printPrime:
        LDR r0, =isprime
        MOV r1, r4
        BL printf
        B end

    printNotPrime:
        LDR r0, =notprime
        MOV r1, r4
        BL printf
        B end

    end:
        // pop the stack
        LDR lr, [sp]
        ADD sp, sp , #4
        MOV pc, lr
.data
    isprime: .asciz "%d is prime \n"
    notprime: .asciz "%d is not prime \n"
# END checkPrime


.text
main:
    # Save return to OS on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Enter your program here.

    promptUser:

        // prompt number from user
        LDR r0, =prompt
        BL printf


        LDR r0, =format
        LDR r1, =num
        BL scanf 

        LDR r0, =num
        LDR r0, [r0]

        CMP r0, #-1
        BEQ endMain
            BL checkPrime
            B promptUser
        B endMain
    endMain:

    # Return to the OS
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data

    prompt: .asciz "Enter a number to check if it is prime: "
    format: .asciz "%d"
    num: .word 0

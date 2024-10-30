
#
# Program Name: template.s
# Author: Evan Edelstein
# Date: 9/19/2020
# Purpose: Check of a number is prime
# program using gcc #
.global main
.global checkPrime
.global getRemainder
   

.text
checkPrime:
    // Logic taken from https://developer.arm.com/documentation/107829/0200/Example--checking-prime-numbers
    // Push Stack
    SUB sp, sp, #4
    STR lr, [sp]
    
    MOV r4, r0

    // if it is 1,0 or neg it isnt prime
    CMP r0, #1
    BLE printNotPrime

    // For all numbers between input and zero check if that number (sentinal ) is a divisior of input_number, if it is
    // the input number is not prime

    // in python
//   def is_prime(n):
//    j = n 
//    i = n - 1
//
//    if n <= 1:
//        return False
//
//    while i > 1:
//        j = n
//        while j >= i:
//            j = j - i
//        
//        if j == 0:
//            return False
//        
//        i = i - 1
//    
//    return True
//


    SUB r1, r0 , #1
    startSubLoop:
        CMP r1, #1
        BEQ printPrime
        // else 
        MOV r2, r0
    
    subtractFactor:
        SUB r2, r2, r1 // input_number = input_number - sentinal
        CMP r2, r1 // is sentinal a factor of our number
        BLT checkRemainder
        B subtractFactor
    
    checkRemainder:
        CMP r2, #0   // If number has a divisor without remainder than it is not prime
        BEQ printNotPrime
            // else there is a remainder
            SUB r1 , r1, #1 // decrement sentinal
            B startSubLoop

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

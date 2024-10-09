#
# Program Name: template.s
# Author: Evan Edelstein
# Date: 9/19/2020
# Purpose: This program is does unit conversions options are:
# (0)  miles 2 kilometers:  
# (1)  kilometers per hour
# (2)  celcuis 2 farenhiet
# (3)  inches 2 feet
# program using gcc #


.global main
.global miles2kilometers
.global kph
.global CtoF
.global InchesToFeet


.text 
miles2kilometers:
# purpose: Convert miles to kilometers.
# Inputs: r0 (miles)
# Outputs: r0 (kilometers)

    // Push Stack 
    SUB sp, sp, #4
    STR lr, [sp]

    // Multiply by 16 and divide by 10 to preserve precision
    MOV r6, r0
    MOV r2, #16
    MUL r0, r2
    MOV r1, #10
    BL __aeabi_idiv

    // Pop back into stack 
    LDR lr, [sp]
    ADD sp, sp , #4
    MOV pc, lr
    
.data

# END miles2kilometers

.text 
kph:
# purpose: Convert miles per hour to kilometers per hour
# Inputs: r0 (hours), r1 (miles)
# Outputs: r0 (kilometers per hour)
    // Push Stack
    SUB sp, sp, #4
    STR lr, [sp]
    
    // Store hours for later
    MOV r5, r0

    // Swap r1 (miles) and r0 (hours) -> r0 (miles) and r1 (hours)
    MOV r2, r1
    MOV r1, r0
    MOV r0, r2

    // Call miles2km -> r0 (km)
    BL miles2kilometers

    // Divide by r0 (km) by r1 (hours)
    MOV r1, r5
    BL __aeabi_idiv

    // pop the stack 
    LDR lr, [sp]
    ADD sp, sp , #4
    MOV pc, lr
.data
# END kph


.text 
CToF:
# purpose: Convert Celsuis to Farenhiet
# Inputs: r0 (Celsius)
# Outputs: r0 (Farenhiet)
     // Push Stack
    SUB sp, sp, #4
    STR lr, [sp]

    // c2f ->  F = (C * 9/5) + 32 
    MOV r1, #9
    MUL r0, r0, r1

    MOV r1, #5
    BL __aeabi_idiv


    ADD r0, r0, #32

    MOV r1, r0

    // pop the stack 
    LDR lr, [sp]
    ADD sp, sp , #4
    MOV pc, lr
.data 
# END CtoF

.text
inchesToFt:
# purpose: Convert inches to feet
# Inputs: r0 (inches)
# Outputs: r0 (feet)
    // Push Stack
    SUB sp, sp, #4
    STR lr, [sp]

    // Convert inches to Feet
    MOV r1, #12
    BL __aeabi_idiv

    // pop the stack 
    LDR lr, [sp]
    ADD sp, sp , #4
    MOV pc, lr
.data
# END inchesToFt

.text
main:
    # Save return to OS on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    // 1)  miles2kilometers(int miles)

    // prompt for input
    LDR r0, =prompt1
    BL printf

    LDR r0, =format1
    LDR r1, =val
    BL scanf

    LDR r0, =val
    LDR r0, [r0]

    BL miles2kilometers

    // Print output
    MOV r2, r0
    MOV r1, r6
    LDR r0, =KilOuput
    BL printf

    // end m2km
    // 2) kph(int hours, int miles)

    // prompt for input
    LDR r0, =prompt2
    BL printf

    LDR r0, =format1
    LDR r1, =val
    BL scanf

    LDR r0, =val
    LDR r0, [r0]

    LDR r0, =prompt25
    BL printf

    LDR r0, =format1
    LDR r1, =val2
    BL scanf

    LDR r1, =val2
    LDR r1, [r1]

    BL kph
    MOV r1, r0
    LDR r0, =kphOuput
    BL printf
    // end kph

    // 3) CToF [celcuis 2 farenhiet]

    LDR r0, =prompt3
    BL printf

    LDR r0, =format1
    LDR r1, =val
    BL scanf
 
    LDR r0, =val
    LDR r0, [r0]
    MOV r7, r0
    
    // Call fn 
    BL CToF
 
    // Print output
    MOV r1, r7
    MOV r2, r0
    LDR r0, =farnhOutput
    BL printf
 
    // end CToF

    // 4) inchesToFt
    LDR r0, =prompt4
    BL printf

    LDR r0, =format1
    LDR r1, =val
    BL scanf
 
    LDR r0, =val
    LDR r0, [r0]
    MOV r7, r0

    BL inchesToFt
 
    // Print output
    MOV r1, r7
    MOV r2, r0
    LDR r0, =ftOutput
    BL printf

    
    # Return to the OS
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt1: .asciz "Enter a distance in Miles to convert to Km: \n"
    format1: .asciz "%d"
    KilOuput: .asciz "%d Miles -> %d Kilometers\n"
    prompt2: .asciz "Enter a hours: \n"
    prompt25: .asciz "Enter miles: \n"
    kphOuput: .asciz "%d KPH\n"
    prompt3: .asciz "Enter Temp in Celsuis: \n"
    farnhOutput: .asciz "%d C -> %d F\n"
    prompt4: .asciz "Enter inches to convert to feet: \n"
    ftOutput: .asciz "%d inches -> %d feet\n"
    val: .word 0
    val2: .word 0






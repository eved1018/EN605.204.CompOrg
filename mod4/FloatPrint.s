.text
.global main

main:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    LDR r0, =prompt1
    BL printf

    LDR r0, =input1
    LDR r1, =num1
    BL scanf

    LDR r0, =format1
    LDR r1, =num1
    LDR r1, [r1]          // Load the address of the float
    VMOV S0, R1           // put the value S0 register
    vcvt.F64.F32 D0, S0   // Converting the float to double precision

    LDR r0, =format2
    VMOV r1, r2, D0       // Move both values to r1 and r2 to build a string
    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    num1:    .word 0
    prompt1: .asciz "Enter float number: "
    input1:  .asciz "%f"
    format1: .asciz "Your number is: %f\n"
    format2: .asciz "%.2f\n"
# End main

.text
.global main
main:
    # Save return to OS on stack 
    SUB sp, sp, #8
    STR lr, [sp, #0]
    
    
    # Enter your program here.

    ldr r0, =prompt
    bl printf
    

    // setp pair for float to be stored in 
    LDR r0, =fmt_in
    LDR r1, =num
    BL scanf

    //LDR r1, =num
    //LDR r1, [r1, #0]

  
    // ldr r3, =num // used to test by hardcoding a float into num and just printing
    VLDR.32 s15, =num
    VCVT.f64.f32 d7, s15

    ldr r0, =fmt_out
    VMOV r1, r2, d7 
    LDR r1, [r1, #0]
    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #8
    MOV pc, lr
    
.data
    prompt: .asciz "Enter a number "
    fmt_in:  .asciz "%f"                       // Format string for scanf
    fmt_out: .asciz "You entered: %f\n"        // Format string for printf
    num:     .float 0.0                       // Variable to store the floating point number



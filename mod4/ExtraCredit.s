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

    LDR r1, =num // Load the adr of num into r1
   
    VLDR s0, [r1] // Load the valuer of num into s0
    vcvt.f64.f32  d5, s0    // Convert num to double 

    LDR r0, =fmt_out
    VMOV r2, r3, d5 // Store num into r2 and r3 (not sure why r1 and r2 didnt work?)
    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #8
    MOV pc, lr
    
.data
    prompt: .asciz "Enter a number "
    fmt_in:  .asciz "%f"                       // Format string for scanf
    fmt_out: .asciz "You entered: %f\n"        // Format string for printf
    num:     .float 0.0                       // Variable to store the floating point number



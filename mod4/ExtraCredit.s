.text
.global main
main:
    // Save return to OS on stack 
    SUB sp, sp, #4
    STR lr, [sp, #0]
    
    
    // Enter your program here.

    ldr r0, =prompt
    bl printf

    // setp pair for float to be stored in 
    LDR r0, =fmt_in
    LDR r1, =num
    BL scanf

    LDR r1, =num // Load the adr of num into r1
    LDR r1, [r1]


    VMOV s0, r1 // Load the valuer of num into s0
    vcvt.f64.f32  d0, s0    // Convert num to double 

    LDR r0, =fmt_out
    VMOV r1, r2, d0 // Store num into r2 and r3 (not sure why r1 and r2 didnt work?)
    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
    
.data

    num: .word 0
    prompt: .asciz "Enter a number: "
    fmt_in: .asciz "%f"
    fmt_out: .asciz "%.2f\n"


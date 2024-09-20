.text
.global main
main: 
    SUB sp, sp, #4
    STR lr, [sp]
    
    LDR r0, =helloword
    BL printf 

    
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
    helloword: .asciz "Hello World\n"
#END main

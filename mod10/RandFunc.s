.text
.global main
.global setSeed
.global randFunc
main:
	SUB sp, sp, #4
	STR lr, [sp]
	#Prompt for the seed
	LDR r0, =prompt
	BL printf
	LDR r0, =format
	LDR r1, =seed
	BL scanf
	#Set the seed for the random number
	LDR r0, =seed
	LDR r0, [r0]
	BL setSeed
	# print first random number
	BL randFunc
	MOV r1, r0
	LDR r0, =output
	BL printf
	# print second random number
	BL randFunc
	MOV r1, r0
	LDR r0, =output
	BL printf
	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr
.data
	prompt: .asciz "\nEnter the seed: "
	format: .asciz "%d"
	seed: .word 0
	output: .asciz "\nThe random number is %d\n"

.text
# Function: setSeed
# Author: Charles Kann
# Date: 7/31/2020
# Purpose: Set a see for the randFunc
# Input: r0: seed
# Output: None
# Side effect: Seed is set
setSeed:
	SUB sp, sp, #4
	STR lr, [sp]
	BL srand // r0 already has the seed
	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr


.text
	// Purpose: To retrieve a random number from 0..r0
randFunc:
	SUB sp, sp, #8
	STR lr, [sp]
	STR r4, [sp, #4]
	// Get the random number, setting the limit using a modulus operation
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

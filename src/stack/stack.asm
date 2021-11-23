; stack.asm

extern printf

section .data
	strn	db	"ABCDE",0
	strlen	equ	$ - strn-1 	; len without 0
	fmt1	db	"Original: %s",EOL,0
	fmt2	db	"Reversed: %s",EOL,0
section	.bss
section .text
	
	global main

main:
	; The stack must maintain 16-byte alignment. Just before
	; main is called, 8 bytes are pushed onto the stack, so
	; the prologue aligns the stack.
	push 	rbp
	mov	rbp, rsp	; prologue

	mov	rdi, fmt1
	mov	rsi, strn
	mov	rax, 0
	call	printf

	; get the string onto the stack
	xor	rax, rax	; clear rax
	mov	rbx, strn	; address of strng in rbx
	mov	rcx, strlen	; length/counter
	mov	r12, 0		; r12 = pointer
	
	pushLoop:
		mov	al, byte [rbx+r12]	; char into rax
		push	rax			; rax => stack
		inc	r12
		loop	pushLoop

	mov	rbx, strn	; addr of strn in rbx
	mov	rcx, strlen	; length counter
	mov	r12, 0		; r12 => pointer
	popLoop:
		pop 	rax			; one char
		mov	byte [rbx+r12], al	; overwrite char in strn
		inc	r12
		loop	popLoop
		mov	byte [rbx+r12], 0	; null-term the string

	mov	rdi, fmt2
	mov	rsi, strn
	mov	rax, 0
	call 	printf

	mov	rax, 0		; return success

leave
ret


extern printf

section .data
	number 	dq 	100
	msg1	db	"Sum (A) => 0 to %ld is %ld", EOL, 0
	msg2	db	"Sum (B) => 0 to %ld is %ld", EOL, 0

section .bss
section .text
	global main

main:
	push 	rbp		; prologue
	mov 	rbp, rsp	;

	mov	rbx, 0		; counter
	mov 	rax, 0		; accumulator

loop1:
	add 	rax, rbx
	inc	rbx

	cmp 	rbx, [number]
	jle	loop1

	mov 	rdi, msg1
	mov	rsi, [number]
	mov	rdx, rax
	mov 	rax, 0		; no xmm
	call	printf

; better loop
	mov	rcx, [number]
	mov	rax, 0
loop2:
	add	rax, rcx
	loop	loop2		; decreases rcx by 1

	mov	rdi, msg2
	mov	rsi, [number]	; loop from
	mov	rdx, rax	; sum
	mov	rax, 0		; no xmm
	call 	printf 

	mov	rsp, rbp
	pop	rbp
	mov	rax, 0
	ret

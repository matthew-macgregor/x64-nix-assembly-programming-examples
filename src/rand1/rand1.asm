; rand1.asm

%include "../constants.inc"

extern rand
extern printf

section .data
	before	db	"Generate random number from 0-99",EOL,0
	ifmt	db	"Rand is: %d",EOL,0
	divbt	dq	100
section .bss
section .text

	global main

main:
	push 	rbp
	mov	rbp, rsp
	
	xor	rax, rax
	call	rand

;	mov	rdi, ifmt
;	mov	rsi, rax
;	xor	rax, rax	; no xmm
;	call 	printf

	mov	rax, rsi
	xor	rdx, rdx
	idiv	qword [divbt]
	mov	rdi, ifmt
	mov	rsi, rdx
	xor	rax, rax
	call 	printf

	xor	rax, rax	; success
leave
ret


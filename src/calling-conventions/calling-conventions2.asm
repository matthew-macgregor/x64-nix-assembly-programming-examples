extern printf

section .data
	msg	db	"Nothing here.",EOL,0
section .bss
section .text
	global main

main:

	push rbp
	mov rbp, rsp
	mov rdi, msg
	mov rax, 0
	call printf

	mov rsp, rbp
	pop rbp
	

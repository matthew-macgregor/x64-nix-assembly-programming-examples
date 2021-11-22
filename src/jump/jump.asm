; jump.asm

extern printf

section .data
    	n1      dq  92
    	n2      dq  84

	sge	db 	"< n1 >= n2 >",EOL,0 
	slt	db	"< n1 < n2 >",EOL,0

section .bss
section .text
	global main

main:
	push rbp	; prologue
	mov rbp, rsp

	mov rax, [n1]
	mov rbx, [n2]
	cmp rax, rbx
	jge greater

; less than
	mov rdi, slt
	mov rax, 0	; no xmm
	call printf
	jmp exit


greater:
	mov rdi, sge
	mov rax, 0	; no xmm
	call printf

exit:
	mov rsp, rbp
	pop rbp
	mov rax, 0
	ret

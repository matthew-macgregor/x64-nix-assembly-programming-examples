; sreverse.asm

section .data
section .bss
section .text

global sreverse
sreverse:

    push 	rbp
    mov		rbp, rsp
pushing:
    mov 	rcx, rsi
    mov		rbx, rdi
    mov		r12, 0
push_loop:
    mov		rax, qword [rbx+r12]
    push	rax
    inc		r12
    loop	push_loop

popping:
    mov		rcx, rsi
    mov		rbx, rdi
    mov		r12, 0
    pop_loop:
        pop rax
        mov byte [rbx+r12], al
        inc r12
        loop pop_loop
    mov	rax, rdi
leave
ret

; aligned

extern printf
section .data
    fmt	db	"2 x pi equals %.14f",EOL,0
    pi	dq	3.14159265
section .bss
section .text

;; -- func_stack -----------------------------------------------
func_stack:
section .data
    .fmt	db	"%d",EOL,0
section .bss
section .text

    ; you can also use enter 0,0 instead of the prologue, but performance
    ; is not as good.
    push 	rbp			; aligns the stack frame on 16-byte border
    mov		rbp, rsp	; moves the stack pointer in rbp

    mov		rax, 1
    inc		rax

    mov		rdi, .fmt
    mov		rsi, rax
    mov		rax, 0
    call	printf

    ; you can also use leave instead of the epilogue, which does not have
    ; performance problems
    mov		rsp, rbp	; epilogue restores the stack pointer
    pop		rbp			; restores rbp
ret

;; -- func3 ----------------------------------------------------
func3:
    push	rbp
    movsd	xmm0, [pi]	; value of pi to fp register
    addsd	xmm0, [pi]
    mov		rdi, fmt
    mov		rax, 1
    call	printf

    pop		rbp
ret

;; -- func2 ----------------------------------------------------
func2:
    push 	rbp
    call	func3
    pop		rbp
ret

;; -- func1 ----------------------------------------------------
func1:	
    push 	rbp
    call	func2
    pop		rbp
ret


;; =============================================================
    global main

main:
    push	rbp
    call	func1
    call	func_stack
    pop		rbp
    mov 	rax, 0
ret

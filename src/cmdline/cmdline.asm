; cmdline.asm

extern printf

%include "../constants.inc"

section .data
    msg db  "Cmd: ",EOL,0
    fmt db  "%s",EOL,0
section .bss
section .text
    global main

main:

    push    rbp
    mov     rbp, rsp
    mov     r12, rdi    ; number of args
    mov     r13, rsi    ; address of args array

    mov     rdi, msg
    call    printf      ; ? no rax 0 (xmm) here?
    mov     r14, 0      ; loop counter

.ploop:
    mov     rdi, fmt
    mov     rsi, qword [r13+r14*8]  ; start of args array + counter * 8 bytes
    call    printf      ; print the arg
    inc     r14         ; count
    cmp     r14, r12    ; == num args?
    jl      .ploop      ; keep going

    xor	    rax, rax    ; return 0
leave
ret

; move.asm

extern printf

section .data
    bNum    db  123
    wNum    dw  12345
    dNum    dd  1234567890
    qNum1   dq  1234567890123456789
    qNum2   dq  123456
    qNum3   dq  3.14

section .bss
section .text
    global main

main:
    ; prologue
    push rbp
    mov rbp,rsp

    mov rax, -1
    mov al, byte [bNum]     ; high bits retain value
    xor rax, rax            ; clear
    mov al, byte [bNum]

    mov rax, -1             ; fill 1's
    mov ax, word [wNum]
    xor rax, rax            ; clear
    mov ax, word [wNum]

    mov rax, -1
    mov eax, dword [dNum]

    mov rax, -1
    mov rax, qword [qNum1]
    mov qword [qNum2], rax
    mov rax, 123456
    movq xmm0, [qNum3]

    mov rax, 0

    mov rsp,rbp
    pop rbp
    ret
extern printf

section .data
    bNum        db      123
    wNum        dw      12345
    warray      times   5 dw 0
    dNum        dd      12345
    qNum1       dq      12345
    text1       db      "abc",0
    qNum2       dq      3.141592654
    text2       db      "cde",0
    strOut      db      "<Memory>",EOL,0

section .bss
    bvar        resb    1
    dvar        resd    1
    wvar        resw    10
    qvar        resq    3

section .text
    global main

main:
    push rbp
    mov rbp, rsp

    lea rax, [bNum]     ; load addr
    mov rax, bNum       ; load addr
    mov rax, [bNum]     ; load value

    mov [bvar], rax     ; rax -> addr of bvar
    lea rax, [bvar]     ; load addr
    lea rax, [wNum]     ; load addr
    mov rax, [wNum]     ; load value
    lea rax, [text1]    ; load addr
    mov rax, text1      ; load addr
    mov rax, text1+1    ; load addr char 2
    lea rax, [text1+1]  ; load value char 2
    mov rax, [text1]    ; load value char 1
    mov rax, [text1+1]  ; load value char 2

    mov rdi, strOut     ; prints <Memory>
    call printf

    xor rax, rax        ; Success

    mov rsp, rbp        ; epilogue
    pop rbp

    ret

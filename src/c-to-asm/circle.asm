; circle.asm

section .data
    pi 	dq	3.141592654
section .bss
section .text

; area = π * r^2
global carea
carea:
    section .text
        push 	rbp
        mov		rbp, rsp
        movsd	xmm1, qword [pi]
        mulsd	xmm0, xmm0	; r^2, radius in xmm0
        mulsd	xmm0, xmm1	; π *
    leave
    ret

; perimeter = 2πr
global ccircum
ccircum:
    section .text
        push rbp
        mov rbp, rsp
        movsd xmm1, qword [pi]
        addsd xmm0, xmm0	; radius in xmm0
        mulsd xmm0, xmm1
    leave
    ret

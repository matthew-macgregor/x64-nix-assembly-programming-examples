; bits3.asm

extern printb
extern printf

section .data
    msg1		db	"No bits set:",EOL,0
    msg2		db	EOL,"Set bit #4",EOL,0
    msg3		db	EOL,"Clear bit #4",EOL,0
    msg4		db	EOL,"Test bit #4",EOL,0
    msgskip		db	EOL,"Skipped message",EOL,0
    msgshow		db	EOL,"Shown message",EOL,0
    bitflags	dq	0
section .bss
section .text
    global main

main:
    push    rbp
    mov	    rbp, rsp
    
    mov	    rdi, msg1
    xor	    rax, rax
    call	printf

    mov	    rdi, [bitflags]
    call	printb

    mov	    rdi, msg2		
    xor	    rax, rax
    call	printf

    bts	    qword [bitflags], 4	    ; set bit 4 
    mov	    rdi, [bitflags]		    ; display
    call 	printb

    mov	    rdi, msg4			; test bit 4
    xor	    rax, rax
    call	printf
    ;xor	rdi, rdi
    mov	    rax, 4				; bit 4
    xor	    rdi, rdi
    bt	    [bitflags], rax		; bit test
    setc	dil				    ; set dil (=low rdi) to 1 if CF is set
    call	printb			    ; display rdi

    mov     rdi, msg3
    xor     rax, rax
    call	printf

    btr	    qword [bitflags], 4	; clear bit 4
    mov	    rdi, [bitflags]
    call	printb

    mov	    rdi, msg4
    xor	    rax, rax
    call	printf
    mov	    rax, 4				; bit 4
    xor	    rdi, rdi
    bt	    [bitflags], rax		; bit test
    setc 	dil

; 	commentary: dil is the low 8-bytes of rdi
;   setc is "Set if Carry", which sets the byte of the operand to 1 if the carry flag
;	is set, or to 0 if not. So rdi (dil) is 0 because bit 4 is clear. 
    
    push 	rdi				; preserve our result
    call	printb			; printb clobbers rdi
    pop	    rdi

    cmp	    dil, 0
    je	    skip			; jump if rdi (dil) is 0 (which it will be)

    mov 	rdi, msgskip	; you won't see this message
    xor	    rax, rax
    call	printf

skip:
    mov	    rdi, msgshow	; you will see this message
    xor	    rax, rax
    call	printf

    xor	rax, rax			; return 0
leave
ret

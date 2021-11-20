; ============================================================ ;
;  Calling C Standard Library Function In ASM (printf)	       ;
; ============================================================ ;
;                                                              ;
; - printf-example.asm                                         ;
;                                                              ;
;   nasm -f elf64 -g -F dwarf printf-ex1.asm -l printf-ex1.lst ;
;   gcc -o printf-ex1 printf-ex1.o -no-pie	               ;
;                                                              ;
; ============================================================ ;

; Defines
%define SUCCESS		0

extern printf

section .data
	EOL			equ		10
	WRITE			equ		1
	STDOUT			equ		1
	SYS_EXIT		equ		60
	msg			db		"hello world",0
	fmtstr			db		"format str: %s",EOL,0

section .bss

section .text
    global  main

main:
	; prologue
	push 	rbp
	mov	rbp,rsp
	
	; printf args
	mov	rdi, fmtstr
	mov	rsi, msg
	mov	rax, 0			; no xmm registers (?)
	call	printf			; cstdio
	
	; epilogue
	mov	rsp, rbp
	pop	rbp
	mov	rax, SYS_EXIT
	
    	mov     rdi, SUCCESS          	; return code success
    	syscall                		; please give up

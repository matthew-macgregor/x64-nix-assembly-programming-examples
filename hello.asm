; ================================================================================= ;
;  Hello World in x64 Assembly (Unix/Linux)		                            ;
; ================================================================================= ;
;                                                                                   ;
; - hello.asm                                                                       ;
;                                                                                   ;
;   nasm -f elf64 -g -F dwarf hello.asm -l hello.lst 	                            ;
;   gcc -o hello hello.o -no-pie	               	                            ;
;                                                                                   ;
; ===================================================================================

; hello.asm

section .data
	EOL			equ		10
	WRITE			equ		1
	STDOUT			equ		1
	SYSCALL_EXIT		equ		60
	msg			db		"hello world",EOL,0

section .bss

section .text
    global  main

main:
    mov     rax, WRITE          	; 1 is write
    mov     rdi, STDOUT          	; 1 is stdout
    mov     rsi, msg        		; rsi holds str to write
    mov     rdx, 12         		; str length is 12
    syscall                 
    mov     rax, SYSCALL_EXIT  		; 60 is exit
    mov     rdi, 0          		; return code success
    syscall                 		; please give up

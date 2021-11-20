; ================================================================================= ;
;  Hello World AAK in x64 Assembly (Unix/Linux)		                            ;
; ================================================================================= ;
;                                                                                   ;
; - hello-aak.asm                                                                   ;
;                                                                                   ;
;   nasm -f elf64 -g -F dwarf hello-aak.asm -l hello-aak.lst 	                    ;
;   gcc -o hello-aak hello-aak.o -no-pie	               	                    ;
;                                                                                   ;
; ================================================================================= ;

; alive.asm
section .data
	WRITE		equ		1
	STDOUT		equ		1
	SYS_EXIT	equ		60
	


	hwmsg		db		"Hello, World!",10,0
	hwmsg_len	equ		$-hwmsg-1 ; len minus zero
	aakmsg		db 		"Alive & Kicking!",10,0
	aakmsg_len	equ		$-aakmsg-1
	radius		dq		357
	pi			dq		3.14
	
section .bss
section .text
	global main
	
main:
	push		rbp				;prologue
	mov			rbp, rsp		;prologue
	mov			rax, WRITE
	mov			rdi, STDOUT
	mov			rsi, hwmsg		; str
	mov			rdx, hwmsg_len
	syscall
	
	mov			rax, WRITE
	mov			rdi, STDOUT
	mov			rsi, aakmsg
	mov			rdx, aakmsg_len
	syscall
	
	mov			rsp, rbp		;epilogue
	pop			rbp
	mov			rax, SYS_EXIT
	mov			rdi, 0			; success
	syscall

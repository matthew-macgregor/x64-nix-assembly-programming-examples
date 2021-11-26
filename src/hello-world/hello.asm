; hello.asm

; Data Types
; db Byte		(8 bits)
; dw Word 		(16 bits)
; dd Double Word 	(32 bits)
; dq Quad Word		(64 bits)

%include "../constants.inc"

; Initialized Variables & Constants
; ------------------------------------------------------ ;
section .data
	msg    	db		"Hello, world",0xa,0
	strlen 	equ		13

; resb Byte
; resw Word
; resd Double Word
; resq Quad Word

; Uninitialized Variables
; ------------------------------------------------------ ;
section .bss		; bss = Block Started by Symbol


; Program Code 
; ------------------------------------------------------ ;
section .text
	global main

main:
	mov rax, WRITE 				; 1 is write
	mov rdi, STDOUT				; 1 is stdout
	mov rsi, msg	
	mov rdx, strlen
	syscall
	mov rax, SYSCALL_EXIT		; exit
	mov rdi, 0					; success exit code
	syscall						; please give up

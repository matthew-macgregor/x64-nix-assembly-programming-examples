; alive.asm

; compile with -p "../constants.inc"

extern	printf

; Data Types
; db Byte		(8 bits)
; dw Word 		(16 bits)
; dd Double Word 	(32 bits)
; dq Quad Word		(64 bits)

; Initialized Variables & Constants
; ------------------------------------------------------ ;
section .data
	ENDL		equ		0xa

    hwMsg    	db		"Hello, world",ENDL,0
	hwStrlen 	equ		$-hwMsg-1
	aMsg		db		"Alive and Kicking",ENDL,0
	aStrlen		equ		$-aMsg-1
	fmtStr		db		">> %s",0
	piStr		db		"Pi: %lf",ENDL,0
	radStr		db		"Radius: %d",ENDL,0

	radius		dq		357
	pi			dq		3.14
	
	
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
	push rbp		; func prologue
	mov rbp,rsp		; prologue
	
	mov rax, WRITE		
	mov rdi, STDOUT
	mov rsi, hwMsg
	mov rdx, hwStrlen
	syscall

	mov rax, WRITE
	mov rdi, STDOUT
	mov rsi, aMsg
	mov rdx, aStrlen
	syscall

	mov rdi, fmtStr
	mov rsi, hwMsg
	mov rax, 0
	call printf

	mov rdi, piStr
	movq xmm0, [pi]
	mov rax, 1		; use 1 xmm register 
	call printf

	mov rdi, radStr
	mov rax, 0
	mov rsi, [radius]
	call printf

	mov rsp, rbp		; epilogue
	pop rbp	
	
	;mov rax, EXIT		; exit
	;mov rdi, 0		; success exit code
	;syscall		; bye

	ret	


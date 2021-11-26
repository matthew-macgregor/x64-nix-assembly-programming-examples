; console1.asm

section .data
	msg1		db	"Enter some text:",EOL,0
	msg1len		equ	$-msg1
	msg2		db	">>",0
	msg2len		equ	$-msg2
	inputlen 	equ	10		; buffer size
section .bss
	input		resb	inputlen+1	; leave room for null term
section .text
	global main

main:
	push 	rbp
	mov	rbp, rsp
	
	mov	rdi, msg1
	call	better_prints
	
	mov	rdi, input	; address of buffer
	mov	rsi, inputlen
	call 	better_reads

	mov	rdi, msg2
	call	better_prints

	mov	rdi, input
	call	better_prints

leave
ret

; -------------------------------
; rsi = str address
; rdx = str len
prints:
	push 	rbp
	mov	rbp, rsp

	mov	rax, WRITE
	mov	rdi, STDOUT

	syscall

leave
ret

; -------------------------------
; rsi = buffer addr
; rdi = buffer len
reads:
	push	rbp
	mov	rbp, rsp

	mov	rax, READ
	mov	rdi, STDIN
	syscall
leave
ret

; -------------------------------
; rdi = buffer
better_prints:
	push 	rbp
	mov	rbp, rsp
	push	r12		; save

	xor	rdx, rdx	; length
	mov	r12, rdi	; str

.lengthloop:
	cmp	byte [r12], 0
	je	.lengthfound
	inc	rdx
	inc	r12
	jmp	.lengthloop

.lengthfound:
	cmp	rdx,0
	je	.done
	mov	rsi, rdi	; rdi is addr of str
	mov	rax, WRITE
	mov	rdi, STDOUT
	syscall
.done:
leave
ret

; -------------------------------
; rsi = buffer addr
; rdi = buffer len
better_reads:
section .data
section .bss
	.inputchar	resb	1
section .text

	push 	rbp
	mov	rbp, rsp
	push 	r12		; save
	push	r13		; save
	push 	r14		; save

	mov	r12, rdi	; input buffer
	mov	r13, rsi	; max length
	xor	r14, r14	; clear it, r14 becomes our counter

.readc:
	mov	rax, READ	
	mov	rdi, STDIN
	lea	rsi, [.inputchar] 	; address of input
	mov	rdx, 1			; read 1 character
	syscall

	mov	al, [.inputchar]
	cmp	al, byte EOL
	je	.done
	cmp	al, 97
	jl	.readc			; ignore characters less than a
	cmp	al, 122			; greater than z, ignore
	jg	.readc
	inc	r14
	cmp	r14, r13
	ja	.readc			; buffer max
	mov	byte [r12], al		; stash the char in the buffer
	inc	r12			; move along
	jmp	.readc

.done:
	inc	r12
	mov	byte [r12],0		; null terminator

	pop	r14
	pop	r13
	pop	r12
leave
ret

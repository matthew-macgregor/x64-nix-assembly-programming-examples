; asum.asm

section .data
section .bss
section .text

global asum
asum:
	section .text
		mov rcx, rsi	; array length
		mov rbx, rdi	; address of array
		mov r12, 0
		movsd xmm0, qword [rbx+r12*8]
		dec rcx		; array length - 1
				; first elem already in xmm0
		sloop:
			inc r12
			addsd xmm0, qword [rbx+r12*8]
			loop sloop
ret	; sum in xmm0

; adouble

section .data
section .bss
section .text
global adouble
adouble:
	section .text
		mov	rcx, rsi	; array length
		mov	rbx, rdi	; address of array
		mov	r12, 0

	aloop:
		movsd 	xmm0, qword [rbx+r12*8]
		addsd	xmm0, xmm0			; double
		movsd	qword [rbx+r12*8], xmm0		; apply to array
		inc	r12
		loop 	aloop
ret

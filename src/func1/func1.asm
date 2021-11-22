extern printf

section .data

	radius	dq	10.0
	pi	dq	3.14
	fmt	db	"Area: %.2f for Radius: %.2f",EOL,0
	
section .bss
section .text
	global main

main:

	push 	rbp
	mov 	rbp, rsp

	call	area
	mov	rdi, fmt
	movsd	xmm1, [radius]	; print the radius as well 
	mov	rax, 2		; there are two xmm register to print 
	call	printf
	

leave				; epilogue (simple version)

; leave is the same as the standard epilogue 
;     mov rsp, rbp 
;     pop rbp

ret

; This code is just for simple introductory purposes. It's
; better to use registers + stack for function args.

; Area of a Circle = pi * (r ^ 2)
area:
	push 	rbp		; prologue
	mov	rbp, rsp	; prologue
	movsd	xmm0, [radius]	; set radius
	mulsd	xmm0, [radius]	; multiply radius * radius
	mulsd	xmm0, [pi]	; multiply radius * pi
				; area is in xmm0
leave
ret

; Returning from a function, use xmm0 for floating-point values
; and rax for integer values. 

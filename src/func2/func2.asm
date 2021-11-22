extern printf

section .data
	radius	dq	10.0
section .bss
section .text

; == AREA Function
area:
	section .data
		.pi	dq	3.141592654	; local data
	section .text

	push 	rbp		; prologue
	mov	rbp, rsp
	
	movsd	xmm0, [radius]
	mulsd	xmm0, [radius]
	mulsd	xmm0, [.pi]
leave
ret

; == CIRCUMFERENCE Function
circum:
	section .data
		.pi 	dq	3.14
	section .text
	
	push 	rbp
	mov	rbp, rsp

	movsd	xmm0, [radius]
	addsd	xmm0, [radius]
	mulsd	xmm0, [.pi]
leave
ret

; == CIRCLE Function
circle:
	section .data
		.fmt_area	db	"Area: %f",EOL,0
		.fmt_circum	db	"Circumerence: %f",EOL,0
	section .text
	
	push 	rbp
	mov	rbp, rsp

	call	area
	mov	rdi, .fmt_area
	mov	rax, 1			; area is in xmm0
	call	printf
	
	call	circum
	mov	rdi, .fmt_circum
	mov	rax, 1
	call 	printf

leave
ret

; == MAIN =================================================
	global main

main:
	push 	rbp
	mov	rbp, rsp

	call	circle

leave
ret


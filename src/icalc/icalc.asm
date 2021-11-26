; icalc.asm

extern printf

section .data
	n1	dq	128
	n2	dq	19
	neg1	dq	-12
	fmtl	db	"Numbers: %ld and %ld",EOL,0
	fmti	db	"%s %ld",EOL,0	

section .bss
	resulti	resq 1
	modulo	resq 1

section .text

;; == FUNCTION print_nl == ;;
print_nl:
section .data
	.NL	db	EOL,0
section .bss
section .text

	push 	rbp
	mov	rbp, rsp
	
	mov	rdi, .NL
	mov	rax, 0
	call 	printf
leave
ret

display_n:
	push 	rbp
	mov	rbp, rsp

	mov	rdi, fmtl
	mov	rsi, [n1]
	mov	rdx, [n2]
	mov	rax, 0		; no xmm

	call 	printf
leave
ret

display_resulti:
	push	rbp
	mov	rbp, rsp

	; load argument registers out of order to avoid
	; using temporary locations
	mov	rdx, rsi	; (3) value to print
	mov	rsi, rdi	; (2) address of id string
	mov	rdi, fmti	; (1) format string
	mov	rax, 0
	call 	printf
leave
ret

add_n:
	push	rbp
	mov	rbp, rsp

	mov	rax, [n1]
	add	rax, [n2]
	mov	[resulti], rax
leave
ret

sub_n:
	push	rbp
	mov	rbp, rsp

	mov	rax, [n1]
	sub	rax, [n2]
	mov	[resulti], rax

leave
ret

incr_n:
	push	rbp
	mov	rbp, rsp

	mov	rax, [n1]
	inc	rax
	mov	[resulti], rax
leave
ret

decr_n:
	push	rbp
	mov	rbp, rsp

	mov	rax, [n1]
	dec	rax
	mov	[resulti], rax

leave
ret

shift_l:
	push 	rbp
	mov	rbp, rsp

	mov 	rax, [n1]
	sal	rax, 2
	mov	[resulti], rax
leave
ret

shift_r:
	push 	rbp
	mov	rbp, rsp

	mov 	rax, [n1]
	sar	rax, 2
	mov	[resulti], rax
leave
ret

shift_r_sign:
	push 	rbp
	mov	rbp, rsp
	
	mov 	rax, [neg1]
	sar	rax, 2			; divide by 4
	mov	[resulti], rax
leave
ret

multiply:
	push	rbp
	mov	rbp, rsp

	mov	rax, [n1]
	imul	qword [n2]
	mov	[resulti], rax
leave
ret

divide:
	push 	rbp
	mov	rbp, rsp
	
	mov	rax, [n1]
	mov	rdx, 0		; rdx must be 0 before idiv
	idiv	qword [n2]
	mov	[resulti], rax
	mov	[modulo], rdx	; rdx has modulo

leave
ret


; == MAIN ===============================================
	global main

main:
section .data

	sumi	db	"Sum: ",0
	difi	db	"Difference: ",0
	resi	db	"Result: ",0
	inci	db	"N1 Incremented: ",0
	deci	db	"N1 Decremented: ",0
	sali	db	"N1 Shift Left 2: (x4):",0
	sari	db	"N1 Shift Right 2: (/4):",0
	sariex	db	"N1 Shift Right 2: (/4) with "
		db	"sign extension:",0
	multi	db	"Product: ",0
	divi	db	"Integer quotient:",0
	remi	db	"Modulo: ",0

section .bss
section .text

	push 	rbp
	mov	rbp, rsp 

	; print starting values
	call	display_n
	
	; addition
	call	add_n
	mov	rdi, sumi
	mov	rsi, [resulti]
	call	display_resulti
	
	; subtraction
	call	sub_n
	mov	rdi, difi
	mov	rsi, [resulti]
	call	display_resulti
	
	; increment
	call	incr_n
	mov	rdi, inci
	mov	rsi, [resulti]
	call	display_resulti

	; decrement
	call	decr_n
	mov	rdi, deci
	mov	rsi, [resulti]
	call	display_resulti

	; shift left
	call	shift_l
	mov	rdi, sali
	mov	rsi, [resulti]
	call	display_resulti

	; shift right
	call	shift_r
	mov	rdi, sari
	mov	rsi, [resulti]
	call	display_resulti

	; shift right sign
	call	shift_r_sign
	mov	rdi, sariex
	mov	rsi, [resulti]
	call	display_resulti

	; multiply
	call	multiply
	mov	rdi, multi
	mov	rsi, [resulti]
	call	display_resulti 

	; divide
	call	divide
	mov	rdi, divi
	mov	rsi, [resulti]
	call	display_resulti
	mov	rdi, remi
	mov	rsi, [modulo] 
	call	display_resulti

	xor 	rax, rax
leave
ret

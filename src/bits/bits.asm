; bits.asm

extern printb
extern printf

section .data
	msgn1	db	"Number1",EOL,0
	msgn2	db	"Number2",EOL,0
	msg1	db	"XOR",EOL,0
	msg2	db	"OR",EOL,0
	msg3	db	"AND",EOL,0
	msg4	db	"NOT N1",EOL,0
	msg5	db	"SHL 2 lower byte of n1",EOL,0
	msg6	db	"SHR 2 lower byte of n1",EOL,0
	msg7	db	"SAL 2 lower byte of n1",EOL,0
	msg8	db	"SAR 2 lower byte of n1",EOL,0
	msg9	db	"ROL 2 lower byte of n1",EOL,0
	msg10	db	"ROL 2 lower byte of n2",EOL,0
	msg11	db	"ROR 2 lower byte of n1",EOL,0
	msg12	db	"ROR 2 lower byte of n2",EOL,0
	n1	dq	-72
	n2	dq	1064

section .bss
section .text

	global main

main:
	push rbp
	mov  rbp, rsp

	mov rsi, msgn1
	call printmsg
	mov rdi, [n1]
	call printb

	mov rsi, msgn2
	call printmsg
	mov rdi, [n2]
	call printb

	mov rsi, msg1
	call printmsg

	mov rax, [n1]
	xor rax, [n2]
	mov rdi, rax
	call printb

	mov rsi, msg2
	call printmsg

	mov rax, [n1]
	or  rax, [n2]
	mov rdi, rax
	call printb

	mov rsi, msg3
	call printmsg

	mov rsi, msg4
	call printmsg

	mov rax, [n1]
	not rax
	mov rdi, rax
	call printb

	mov rsi, msg5
	call printmsg

	mov rax, [n1]
	shl al, 2
	mov rdi, rax
	call printb

	mov rsi, msg6
	call printmsg

	mov rax, [n1]
	shr al, 2
	mov rdi, rax
	call printb

	mov rsi, msg7
	call printmsg

	mov rax, [n1]
	sal al,2
	mov rdi, rax
	call printb

	mov rsi, msg8
	call printmsg

	mov rax, [n1]
	sar al,2
	mov rdi, rax
	call printb
	
	mov rsi, msg9
	call printmsg

	mov rax, [n1]
	rol al,2
	mov rdi, rax
	call printb
	mov rsi, msg10
	call printmsg
	mov rax, [n2]
	rol al,2
	mov rdi, rax
	call printb

	mov rsi, msg11
	call printmsg

	mov rax, [n1]
	ror al,2
	mov rdi, rax
	call printb
	mov rsi, msg12
	call printmsg
	mov rax, [n2]
	ror al,2
	mov rdi,rax
	call printb

	mov rax, 0	; success
leave
ret

printmsg:
section .data
	.fmtstr	db	"%s",0
section .text
	mov rdi, .fmtstr
	mov rax, 0
	call printf
	ret
	

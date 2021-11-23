; calling-conventions.asm

extern printf

%define alignit	0xfffffffffffffff0

section .data
	first	db	"A",0
	second	db	"B",0
	third	db	"C",0
	fourth	db	"D",0
	fifth	db	"E",0
	sixth	db	"F",0
	seventh	db	"G",0
	eigth	db	"H",0
	ninth	db	"I",0
	tenth	db	"J",0
	fmt1	db	"Str: %s %s %s %s %s %s %s %s %s %s",EOL,0
	fmt2	db	"PI = %f",EOL,0
	pi	dq	3.14
section .bss
section .text
	global main

main:
	push rbp
	mov  rbp,rsp

	mov rdi, fmt1 		; param1
	mov rsi, first		; param2
	mov rdx, second		; ...
	mov rcx, third
	mov r8,  fourth
	mov r9,  fifth

	; push the rest in reverse order
	push tenth
	push ninth
	push eigth
	push seventh
	push sixth
	mov  rax, 0		; no xmm
	call printf

	and  rsp, alignit	; 16-byte align the stack
				; (isn't there an align operation or something?)

	movsd xmm0, [pi]	
	mov   rax,  1		; print 1 floating point register
	mov   rdi,  fmt2
	call  printf

	mov rsp,rbp
	pop rbp
ret

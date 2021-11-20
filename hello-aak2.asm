; ================================================================================= ;
;  Hello World AAK in x64 Assembly (Unix/Linux)		                            ;
; ================================================================================= ;
;                                                                                   ;
; - hello-aak2.asm                                                                   ;
;                                                                                   ;
;   nasm -f elf64 -g -F dwarf hello-aak2.asm -l hello-aak2.lst 	                    ;
;   gcc -o hello-aak2 hello-aak2.o -no-pie	               	                    ;
;                                                                                   ;
; ================================================================================= ;

%include "includes.inc"

%define pi 	3.14
%define radius	357



section .data
	hwmsg		db		"Hello, World!",0
	msg		db 		"Alive & Kicking!",0

	fmtstr		db		"%s",EOL,0
	fmtflt		db		"%f",EOL,0
	fmtint		db		"%d",EOL,0

	pix		dq		3.14	
section .bss
section .text

extern 		printf
	global main
	
main:
	push			rbp			;prologue
	mov			rbp, rsp		;prologue

; printf str
	mov			rax, 0			;no float
	mov			rdi, fmtstr
	mov			rsi, hwmsg
	call printf
	
; printf str
	mov			rax, 0			;no float
	mov			rdi, fmtstr
	mov			rsi, msg				
	call printf

; printf int
	mov			rax, 0
	mov			rdi, fmtint
	mov			rsi, radius
	call printf

; printf float
;	mov			rax, 1			;mmx enabled
;	movq			xmm0, [pi]
;	mov			rdi, fmtflt
;	call printf

; printf float
	mov			rax, 1
	movq			xmm0, [pix]
	mov			rdi, fmtflt
	call printf

	mov			rsp, rbp		;epilogue
	pop			rbp

ret 

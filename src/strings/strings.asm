; strings.asm
extern printf

%include "../constants.inc"

%define bdquo	0xe2,0x80,0x9e
%define ldquo	0xe2,0x80,0x9c

section .data
	str0	db	">> >> >> >> >> >> >> >>",EOL,0
	str1	db	"Same string.",EOL,0
	str2	db	"Same string.",EOL,0
	strlen2 equ 	$-str2-1
	str3	db	"Same ",ldquo,"not",bdquo," string.",EOL,0	; utf-8 quote
	strlen3 equ	$-str3-1
	cmpstr1 db	"String diff: strings have no difference.",EOL,0
	cmpstr2 db	"String diff: strings are different.",EOL,0
	cmpstr3 db	"Strings are different beginning at char: %d.",EOL,0
	endstr	db	"strings.asm => ok",EOL,0

section .bss
section .text

%macro print_compstr 2
	xor				rax, rax		; no xmm
	
	mov 			rdi, str0
	call			printf

	mov				rdi, %1
	call			printf

	mov				rdi, %2
	call			printf
	
	mov				rdi, str0
	call			printf
%endmacro


	global main

main:
	push			rbp
	mov				rbp, rsp

	print_compstr	str1, str2

	; set up the strings == case

	lea				rdi, [str1]
	lea				rsi, [str2]
	mov				rdx, strlen2

	; compare
	call			compare1
	cmp				rax, 0			; rax == 0 if str1 == str2
	jnz				not_eq1			; REM: ZF 1 if not equal
	
	; equal, output

	mov				rdi, cmpstr1
	call			printf

	print_compstr  	str1, str3

	; set up the ne case

	lea				rdi, [str1]
	lea				rsi, [str3]
	mov				rdx, strlen3		; Note: str3 is shorter in this example

	; compare
	
	call			compare1
	cmp				rax, 0			; rax == 0 if str1 == str2
	jnz				not_eq1			; REM: ZF 1 if not equal
	
	; not equal

not_eq1:
	; rax is the 0-index character position in the string where the first
	; difference was found
	mov				rdi, cmpstr3		; set up print
	mov				rsi, rax		; set up %d (pos)
	xor				rax, rax		; no xmm
	call			printf

_end:
	xor				rax, rax		; no xmm
	mov				rdi, endstr
	call			printf

	xor				rax, rax

leave
ret


;; Compare #1

compare1:
	mov				rcx, rdx		; strlen in rdx at call, rcx is counter
	cld								; sets DF flag = 0
									; string ops increment RSI and/or RDI when DF = 0

cmpr:	
	cmpsb							; compare string operands (RSI source, RDI dest)
	jne				notequal		; jump if difference
	loop			cmpr			; REM: loop dec 1 from rcx (--rcx), compares to zero
	xor				rax, rax		; ecx counter == 0 without finding a diff
	ret								; return rax == 0

notequal:
	mov				rax, rdx 
	dec				rcx				; compute pos
	sub				rax, rcx		; compute pos
	ret

	xor				rax, rax		; zero rax
	ret

;; Hosts File Reader
;; Platform: x86_64 Linux
;; Purpose: outputs the contents of the files listed in command line arguments
;; to stdout, like a very simple version of `cat`.
;; 
;; Purpose: practice reading a file on GNU/Linux using only syscalls.

;; Defines ;;
%define SYS_READ 0
%define SYS_WRITE 1
%define SYS_OPEN 2
%define SYS_CLOSE 3
%define SYS_EXIT 60

%define STDERR 0
%define STDOUT 1

%define EXIT_SUCCESS 0
%define EXIT_FAILURE 1
%define NULL 0

%define BUFF_SZ 128

;; = = = START =================================== = = = ;;
global _start

section .text
_start:
	;; COMMAND LINE ARGS ;;
	;; If we're building with nostdlib, then our command line args
	;; are going to be passed on the stack.
	;; rsp -> argc
	;; rsp+8 -> address of the exe name
	;; rsp+16 -> address of the first cli arg (if present)

print_args:
	mov	rbx, 2		; counter starts at first in vec
	mov	r12, [rsp]	; save value of argc

;; = = = MAIN =================================== = = = ;;
main_loop:
%ifdef DEBUG
;; Loops through the arguments given on the command line and prints to
;; standard output
	mov	rdi, debug_prefix_str		; "DEBUG: " 
	mov	rsi, debug_prefix_str_len
	call	print_string_l

	mov	rdi, qword [rsp+rbx*8]	; argument in argv[n]
	call	print_string

	mov	rdi, nl			; print a newline
	call	print_string

%endif

;; End of Command Line Args Handling ;;

;; Begin File Handling ;;

	;; OPEN FILE ;;
	mov 	rax, SYS_OPEN
	mov	rdi, qword[rsp+rbx*8] 	; arg1: argv[n]
	xor 	rsi, rsi 		; arg2: 0 == readonly
	syscall

	;; ERRNO ;;
	cmp	rax, 0		; error handling 
	js	exit_file_error	; if rax is negative, it's an error

	;; READ FILE ;;
	push 	rax		; save file descriptor
	sub 	rsp, BUFF_SZ	; expand the stack for our buffer

read_to_buffer:
	mov	rax, SYS_READ		; read
	mov	rdi, [rsp+BUFF_SZ]	; file descriptor from the stack
	mov	rsi, rsp		; buffer addr
	mov	rdx, BUFF_SZ		; buffer size
	syscall

	;; ERRNO ;;
	cmp	rax, 0
	js	exit_file_error		; check for errors

	;; DONE? ;;
	test	rax, rax		; check for no remaining bytes
	jz	cleanup		

	mov	rdi, rsp		; buffer addr
	mov	rsi, rax		; number of bytes
	call	print_string_l

	jmp read_to_buffer

cleanup:
	add	rsp, BUFF_SZ		; restore the stack
	pop	rdi			; remove the file descriptor

	;; TODO: Close the file
	mov	rax, SYS_CLOSE
	; rdi already is the fd
	syscall

	;; ERRNO ;;
	cmp	rax, 0
	js	exit_file_error

	;; LOOP to next argument ;;
	inc	rbx
	cmp	rbx, r12		; counter <= count?
	jle	main_loop		; then keep looping

exit:
	;; CLEAN EXIT PROGRAM ;;
	mov 	rax, SYS_EXIT 
	xor	rdi, rdi
	syscall

exit_file_error:
	mov	rdi, err_file_open

	jmp exit_error

exit_error:
	;; EXIT WITH ERROR ;;
	mov	rax, SYS_EXIT	
	mov	rdi, EXIT_FAILURE
	syscall

;; procedure: print_string_l
;; rdi -> pointer to buffer
;; rsi -> length of buffer to print
;; Outputs strings to stdout
;; --------------------------------------------------
print_string_l:
	;; -- prelude
	push 	rbp
	mov	rbp, rsp
	push	rbx

	mov 	rdx, rsi		; number of bytes from param
	mov 	rsi, rdi		; buffer addr from param
	mov 	rax, SYS_WRITE		; syscall
	mov 	rdi, STDOUT		; file descriptor
	syscall

	;; -- postlude
	pop	rbx
	pop	rbp
	ret

;; procedure: print_string
;; rdi -> pointer to null terminated buffer
;; Outputs null-terminated strings to stdout
;; --------------------------------------------------
;; Note: print_string_l is more efficient
print_string:
	push	rbp	; prelude
	mov	rbp, rsp
	push	rbx

	;; strlen()
	mov	rbx, rdi
	mov	rdx, 0
prs__count_loop:
	cmp	byte[rbx], NULL
	je	prs__count_done
	inc	rdx
	inc	rbx
	jmp	prs__count_loop
prs__count_done:
	cmp	rdx, 0
	je	prs__done

	;; output string
	mov	rax, SYS_WRITE
	mov	rsi, rdi	;; address of buffer
	mov	edi, STDOUT
	;; count already set
	syscall

prs__done:
	pop rbx
	pop rbp
	ret

section .data
debug_prefix_str:	db	"DEBUG: ", 0
debug_prefix_str_len:	equ	$-debug_prefix_str 
err_file_open:		db	"Unable to open file", 0xA, 0
err_file_open_len:	equ	$-err_file_open
nl: 			db 	0xA
nllen: 			equ 	$-nl

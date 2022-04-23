; file1.asm

extern printf

%macro prologue 0
    push        rbp
    mov         rbp, rsp
%endmacro

section .data

    bufferlen       equ     64
    file_name       db      "testfile.txt",0
    FD              dq      0                   ; file descriptor

    txt1            db      "1. First data written",NL,0
    tlen1           dq      $-txt1-1
    txt2            db      "2. Second data written",NL,0
    tlen2           dq      $-txt2-1
    txt3            db      "3. Third data written",NL,0
    tlen3           dq      $-txt3-1
    txt4            db      "4. Fourth data written",NL,0
    tlen4           dq      $-txt4-1

    m_error_create  db    "error creating file",NL,0
    m_error_close   db    "error closing file",NL,0
    m_error_write   db    "error writing file",NL,0
    m_error_open    db    "error opening file",NL,0
    m_error_append  db    "error appending to file",NL,0
    m_error_delete  db    "error deleting file",NL,0
    m_error_read    db    "error reading file",NL,0
    m_error_pos     db    "error positioning in file",NL,0

    m_ok_create     db    "file created and opened",NL,0
    m_ok_close      db    "file closed",NL,0
    m_ok_write      db    "file written",NL,0
    m_ok_open       db    "file opened for r/w",NL,0
    m_ok_append     db    "file opened for append",NL,0
    m_ok_delete     db    "file deleted",NL,0
    m_ok_read       db    "file read",NL,0
    m_ok_pos        db    "positioned in file",NL,0

    ; Conditional Compilation
    _CREATE         equ    1
    _OVERWRITE      equ    1
    _APPEND         equ    1
    _O_WRITE        equ    1
    _READ           equ    1
    _O_READ         equ    1
    _DELETE         equ    1

section .bss
    buffer          resb   bufferlen
section .text
    global main

main:
    prologue

%IF _CREATE
    ;; create & open file
    mov     rdi, file_name
    call    create_file
    mov     qword [FD], rax

    ;; write to file
    mov     rdi, qword [FD]
    mov     rsi, txt1
    mov     rdx, qword [tlen1]
    call    write_file

    ;; close file
    mov     rdi, qword [FD]
    call    close_file
%ENDIF ; _CREATE

%IF _DELETE
    mov     rdi, file_name
    call    delete_file
%ENDIF

    xor     rax, rax        ; success
leave
ret

global create_file
create_file:
    mov     rax, NR_CREATE
    mov     rsi, S_IRUSR | S_IWUSR
    syscall
    cmp     rax, 0          ; file descriptor
    jl      create_error
    mov     rdi, m_ok_create
    push    rax             ; preserve
    call    print_string
    pop     rax
ret
create_error:
    mov     rdi, m_error_create
    call    print_string
ret

;; filename is in rdi
global delete_file
delete_file:
    mov     rax, NR_UNLINK
    syscall
    cmp     rax, 0
    jl      delete_error
    mov     rdi, m_ok_delete
    call    print_string
ret
delete_error:
    mov     rdi, m_error_delete
    call    print_string
ret

global read_file
read_file:
    mov     rax, NR_READ
    syscall
    cmp     rax, 0              ; null file descr?
    jl      read_error
    mov     byte [rsi+rax], 0   ; null terminate the string
    mov     rax, rsi

    mov     rdi, m_ok_read
    push    rax                 ; save
    call    print_string
    pop     rax                 ; restore
ret
read_error:
    mov     rdi, m_error_read
    call    print_string
ret

global write_file
write_file:
    mov     rax, NR_WRITE
    syscall
    cmp     rax, 0
    jl      write_error
    mov     rdi, m_ok_write
    call    print_string
ret
write_error:
    mov     rdi, m_error_write
    call    print_string
ret

global append_file
append_file:
    mov     rax, NR_OPEN
    mov     rsi, O_RDWR|O_APPEND
    syscall
    cmp     rax, 0
    jl      append_error
    mov     rdi, m_ok_append
    push    rax
    call    print_string
    pop     rax
    ret
append_error:
    mov     rdi, m_error_append
    call    print_string
ret

; TODO: improve with locals
global close_file
close_file:
    mov     rax, NR_CLOSE
    syscall
    cmp     rax, 0
    jl      closeerror
    mov     rdi, m_ok_close
    call    print_string
    ret
closeerror:
    mov     rdi, m_error_close
    call    print_string
    ret

global print_string
print_string:
    mov     r12, rdi
    mov     rdx, 0

str_loop:
    cmp     byte [r12], 0
    je      str_done
    inc     rdx             ; count of length
    inc     r12
    jmp     str_loop
str_done:
    cmp     rdx, 0          ; 0 length
    je      prt_done
    mov     rsi, rdi        ; buffer
    mov     rax, SYS_WRITE
    mov     rdi, STDOUT
    syscall
prt_done:
    ret


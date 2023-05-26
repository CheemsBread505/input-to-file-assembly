; TO COMPILE!!!

; nasm -f elf64 main.asm -o main.o
; ld main.o -o main


section .data
    name1 db "What is your name?",10,0
    text db "Hello, World!",10,0
    hello1 db "Hello, ",10,0
    filename db "output.txt",0
    mode db "w",0

section .bss
    name resb 16

section .text 
    global _start

_start: 
    mov rax, name1
    call _print

    call _getName

    mov rax, hello1
    call _print

    call _printName

    ; Open the file
    mov rax, 2
    mov rdi, filename
    mov rsi, 2
    mov rdx, 0
    syscall
    
    ; Check if file open was successful
    cmp rax, 0 
    jl _exit 

    ; Write to the file
    mov rdi, rax 
    mov rax, 1 
    mov rsi, name 
    mov rdx, 13 
    syscall

    ; Close the file
    mov rax, 3
    mov rdi, rax
    syscall

    call _exit

_getName: 
    mov rax, 0
    mov rdi, 0
    mov rsi, name 
    mov rdx, 16
    syscall 
    ret

_printName: 
    mov rax, 1
    mov rdi, 1
    mov rsi, name
    mov rdx, 16
    syscall
    ret

_exit:
    ; Exit the program
    mov rax, 60
    xor rdi, rdi
    syscall

;input: rax as a pointer to string
;output: print tring at rax
_print:
    push rax
    mov rbx, 0
_printLoop:
    inc rax
    inc rbx
    mov cl, [rax]
    cmp cl, 0
    jne _printLoop

    mov rax, 1
    mov rdi, 1
    pop rsi 
    mov rdx, rbx
    syscall

    ret
%include "lib.s"
%include "syscalls.h"

extern printnum, puts, putc

SECTION .data
	fizzbuzz: db `fizzbuzz\n`, 0
	fizz: db `fizz\n`, 0
	buzz: db `buzz\n`, 0

SECTION .text

global _start
_start:
	mov r14, 1 
.while:
	cmp r14, 100
	jg .endwhile
	mov rax, r14
	mov r15, 3
	cqo
	div r15
	mov r11, rdx    

	mov rax, r14
	mov r15, 5
	cqo
	div r15
	mov r13, rdx   

	cmp r11, 0
	je .fizz
	cmp r13, 0
	je .buzz
	jmp .nothing

.fizz:
	cmp r13, 0
	je .fizzbuzz
	mov rsi, fizz
	call puts
	jmp .continue

.buzz:
	mov rsi, buzz
	call puts
	jmp .continue

.nothing:
	mov rax, r14
	call printnum
	mov al, BYTE`\n`
	call putc
	jmp .continue 

.fizzbuzz:
	mov rsi, fizzbuzz
	call puts
	jmp .continue	
	
.continue:
	inc r14
	jmp .while

	
.endwhile:
	mov rax, 60
	mov rdi, 0
	syscall	
	

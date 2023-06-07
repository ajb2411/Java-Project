extern printf, scanf
%macro PRINT 02
push rbp
mov rax, 00
mov rdi, %1
mov rsi, %2
call printf
pop rbp
%endmacro

%macro SCAN 02
push rbp
mov rax,00
mov rsi, %1
mov rdi, %2
call scanf
pop rbp
%endmacro

section .data
msg1 db "Enter three numbers: A, B, C:", 10,0
fmt1 db "%s",0
fmt2 db "%d",0

section .bss
a resd 1
b resd 1
c resd 1


section .txt
	global main

main:	PRINT fmt1, msg1
	SCAN fmt2, a 
	SCAN fmt2, b
	SCAN fmt2, c
	PRINT fmt2, [a]
	PRINT fmt2, [b]
	PRINT fmt2, [c]
	
	MOV rax, 00
	ret

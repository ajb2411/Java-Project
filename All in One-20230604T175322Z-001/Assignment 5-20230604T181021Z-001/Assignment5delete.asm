
%macro WRITE 02
mov rax,01
mov rdi,01
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro FOPEN 02
mov rax,02
mov rdi,%1
mov rsi,%2
mov rdx,0777o
syscall
%endmacro


section .data
e1 db "Invalid number of arguments",10
len1 equ $-e1
e2 db "File not exist",10
len2 equ $-e2
msg1 db "deletion successful...",10
msglen equ $-msg1


section .bss
fname resb 32
fd resq 01


section .text
global _start:
_start:
pop rcx;
cmp rcx,02
jne error1
pop rcx
pop rcx
mov rsi,fname
mov rdx,00

up: mov bl,byte[rcx+rdx]
cmp bl,00
je down
mov byte[rsi+rdx],bl
inc rdx
jmp up

down: mov byte[rsi+rdx],00
FOPEN fname,00
cmp rax,00
jle error2
mov [fd],rax
mov rax,00
mov rdi,[fd]
syscall
mov rax,87
mov rdi,fname
syscall

WRITE msg1,msglen
exit: mov rax,60
mov rdi,00
syscall

error1: WRITE e1,len1
jmp exit
error2: WRITE e2,len2
jmp exit


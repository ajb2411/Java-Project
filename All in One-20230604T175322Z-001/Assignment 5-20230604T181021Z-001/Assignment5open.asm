
%macro WRITE 02
mov rax,01
mov rdi,01
mov rsi,%1
mov rdx,%2
syscall
%endmacro

section .data
e db "Invalid number of arguments",10
elen equ $-e
e1 db "Error while opening file",10
e1len equ $-e1

section .bss
fname resb 50
d1 resb 8
buffer resb 100
size resb 8
fien resb 8
argc resb 8

section .text
global _start:
_start:
pop rcx;
mov qword[argc],rcx
cmp rcx,02
jne err
pop rcx
pop rcx
mov rsi,fname
mov rdx,00
lb1: mov bl,byte[rcx+rdx]
cmp bl,00
je lb2
mov byte[rsi+rdx],bl
inc rdx
jmp lb1

lb2: mov rax,02
mov rdi,fname
mov rsi,0
mov rdx,0644o

syscall
cmp rax,00
je error1
mov qword[d1],rax

lab1: mov rax,0
mov rdi,qword[d1]
mov rsi,buffer
mov rdx,100
syscall

mov qword[size],rax
WRITE buffer ,qword[size]
cmp qword[size],100
je lab1

mov rax,3
mov rdi,qword[d1]
syscall
mov rax,60
mov rdx,00
syscall

err: WRITE e,elen
mov rax,60
mov rdx,00
syscall
error1: WRITE e1,e1len
mov rax,60
mov rdx,00
syscall


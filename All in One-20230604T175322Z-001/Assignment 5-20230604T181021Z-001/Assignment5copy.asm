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
e2 db "Error opening source file",10
len2 equ $-e2
e3 db "Error opening destination file",10
len3 equ $-e3
msg1 db "copying successful...",10
msglen equ $-msg1


section .bss
src resb 32
dest resb 32
fd1 resq 1
fd2 resq 1
fd3 resq 1
buffer resb 100
actl resq 1


section .text
global _start:
_start:
pop rcx;
cmp rcx,3
jne error1
pop rcx
pop rcx
mov rsi,src
mov rdx,00

up: mov bl,byte[rcx+rdx]
cmp bl,00
je down
mov byte[rsi+rdx],bl
inc rdx
jmp up

down: mov byte[rsi+rdx],00
pop rcx
mov rsi,dest
mov rdx,00
up1: mov bl,byte[rcx+rdx]
cmp bl,00
je down1
mov byte[rsi+rdx],bl
inc rdx
jmp up1
down1: mov byte[rsi+rdx],00

FOPEN src,00
cmp rax,00
jle error2
mov [fd1],rax

FOPEN dest,00
cmp rax,00
jle createfile
mov [fd2],rax
mov rax,03
mov rdi,[fd2]
syscall
jmp skipcreate

createfile: mov rax,85
mov rdi,dest
mov rsi,0777o
syscall

skipcreate: FOPEN dest,01
cmp rax,00
jle error3
mov [fd3],rax

again: mov rax,00
mov rdi,[fd1]
mov rsi,buffer
mov rdx,100
syscall
mov [actl],rax
mov rax,01
mov rdi,[fd3]
mov rsi,buffer
mov rdx,[actl]
syscall
cmp qword[actl],100
je again

mov rax,3
mov rdi,qword[fd1]
syscall
mov rax,3
mov rdi,qword[fd3]
syscall

WRITE msg1,msglen

exit: mov rax,60
mov rdi,00
syscall

error1: WRITE e1,len1
jmp exit
error2: WRITE e2,len2
jmp exit
error3: WRITE e3,len3
jmp exit

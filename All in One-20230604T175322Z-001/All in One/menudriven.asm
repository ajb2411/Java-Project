
%macro READ 02
	mov rax,00
	mov rdi,00
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro
%macro WRITE 02
	mov rax,01
	mov rdi,01
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro

section .data
	menu db "1.Addition",10
	     db "2.Addition",10
	     db "3.Addition",10
	     db "4.Addition",10
	     db "5.Addition",10
	msg1 db "ENTER THE TWO NUMBER ",10
	len1 equ $-msg1
	msg2 db "THE ADDITION IS ",10
	len2 equ $-msg2
	msg3 db "THE SUBSTRACTON IS ",10
	len3 equ $-msg3
	msg4 db "THE MULTIPLICATION IS ",10
	len4 equ $-msg4
	msg5 db "THE DIVISION IS ",10
	len5 equ $-msg5
	msg6 db "THE REMINDER IS ",10
	len6 equ $-msg6
	msg7 db "INVALID CHOICE!PLEASE ENTER CHOICE AGAIN!!",10
	len7 equ $-msg7


section .bss
	a resq 1
	b resq 1
	c resq 1
	actl resq 1
	char_buff resb 17
	choice resb 02




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
	msg1 db "ENTER THE TWO NUMBER ",10
	len1 equ $-msg1
	msg2 db "THE ADDITION IS ",10
	len2 equ $-msg2

section .bss
	a resq 1
	b resq 1
	c resq 1
	actl resq 1
	char_buff resb 17


section .text 
	global _start
_start: 
	WRITE msg1,len1
	READ char_buff,17
	call accept
	mov[a],rbx
	READ char_buff,17
	call accept
	mov[b],rbx
	mov rax,[a]
	add rax,[b]
	mov [c],rax
	WRITE msg2,len2
	mov rbx,[c]
	call display
	
	mov rax,60
	mov rdi,00
	syscall
accept: 
	dec rax
	mov [actl],rax
	mov rbx,00
	mov rsi,char_buff
	up:
		shl rbx,04H
		mov rdx,00H
		mov dl,byte[rsi]
		cmp dl,39H
		jbe sub30
		sub dl,07H
	sub30:
		sub dl,30H
		add rbx,rdx
		inc rsi
		dec qword[actl]
		jnz up
	ret

display:
	mov rcx,16
	mov rsi,char_buff
	above: 
		rol rbx,04H
		mov dl,bl
		and dl,0fH
		cmp dl,09H
		jbe add30
		add dl,07H
	add30:	
		add dl,30H
		mov byte[rsi],dl
		inc rsi
		dec rcx
		jnz above
		WRITE char_buff,16
	ret

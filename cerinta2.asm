.data
	delim: .asciz " "
	sir1: .space 100
	cuv: .space 100
	nr: .space 4
	
	formatscanf: .asciz "%[^\n]"
	f: .asciz "%d\n"
	
.text
.global main
main:
	pushl $sir1
	pushl $formatscanf
	call scanf
	popl %ebx
	popl %ebx

	pushl $delim
	pushl $sir1
	call strtok
	popl %ebx
	popl %ebx
	
	movl %eax, cuv
	
	pushl cuv
	call atoi
	popl %ebx
	pushl %eax
	
etfor:
	pushl $delim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
e1:	
	cmp $0, %eax
	je exit
	
	movl %eax, cuv
	
e2:	
	pushl cuv
	call atoi
	popl %ebx
	
	movl %eax, nr
	
e3:	
	cmp $0, %eax
	je verif
	pushl %eax
	
	jmp etfor
	
verif:
	pushl cuv
	call strlen
	popl %ebx
	
	cmp $1, %eax
	jg operatie
	pushl nr
	
	jmp etfor	
	
operatie:
	xorl %ecx, %ecx
	movl cuv, %edi
	movb (%edi, %ecx, 1), %al
	
	cmp $97, %al
	je add
	cmp $100, %al
	je div
	cmp $109, %al
	je mul
	cmp $115, %al
	je sub
	
add:
	popl %eax
	popl %ebx
	add %ebx, %eax
	pushl %eax
	
	jmp etfor
	
div:
	xorl %edx, %edx
	popl %ebx
	popl %eax
	divl %ebx
	pushl %eax
	
	jmp etfor
	
mul:
	xorl %edx, %edx
	popl %eax
	popl %ebx
	mull %ebx
	pushl %eax
	
	jmp etfor
	
sub:	
	popl %ebx
	popl %eax
	sub %ebx, %eax
	pushl %eax
	
	jmp etfor
	
exit:
	popl %eax

	pushl %eax
	pushl $f
	call printf
	popl %ebx
	popl %ebx

	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80

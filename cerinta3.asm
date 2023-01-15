.data
	delim: .asciz " "
	sir1: .space 102
	cuv: .space 102
	nr: .space 4
	v: .long -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
	var: .space 4
	
	formatscanf: .asciz "%[^\n]"
	f: .asciz "%d\n"
	
.text
.global main
main:
	lea v, %esi

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
	
	cmp $0, %eax
	je verif1
	pushl %eax
	jmp etfor
	
verif1:
	xorl %ecx, %ecx
	movl cuv, %edi
	movb (%edi, %ecx, 1), %al
	pushl %eax
	
etfor:
	pushl $delim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	cmp $0, %eax
	je exit
	
	movl %eax, cuv
	
	pushl cuv
	call atoi
	popl %ebx
	
	movl %eax, nr
	
	cmp $0, %eax
	je verif2
	pushl %eax
	
	jmp etfor
	
verif2:
	pushl cuv
	call strlen
	popl %ebx

	cmp $1, %eax
	jg operatie
	jmp verif3
	
verif3:
	xorl %ecx, %ecx
	movl cuv, %edi
	movb (%edi, %ecx, 1), %al
	
	cmp $48, %eax
	je etzero
	jmp variabila
	
etzero:	
	pushl $0
	jmp etfor

variabila:
	movl %eax, var
	sub $97, %eax
	movl (%esi, %eax, 4), %ebx
	cmp $-1, %ebx
	je litera
	pushl %ebx
	jmp etfor
	
litera:
	pushl var
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
	cmp $108, %al
	je let
	
let:
	popl %eax		
	popl %ecx
	subl $97, %ecx
	movl %eax, (%esi, %ecx, 4)
	
	jmp etfor
	
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

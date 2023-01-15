.data
	delim: .asciz " "
	null: .asciz "\n"
	i: .long 0
	j: .long 0
	
	formatscanf: .asciz "%[^\n]"
	formatprintfnr: .asciz "%d "
	formatprintfch: .asciz "%s "
	
	v: .space 2000
	v2: .space 2000
	sir: .space 2000
	cuv: .space 2000
	n: .space 4
	m: .space 4
	mn: .space 4
	cifra: .space 4
	op: .space 4
	nr: .space 4
	vij: .space 4
	numarator: .space 4
	
.text
.global main
main:
	lea v, %edi
	
	pushl $sir
	pushl $formatscanf
	call scanf
	popl %ebx
	popl %ebx

	pushl $delim
	pushl $sir
	call strtok
	popl %ebx
	popl %ebx

linii_n:
	pushl $delim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	movl %eax, cuv
	
	pushl cuv
	call atoi
	popl %ebx
	
	movl %eax, n
	
coloane_m:
	pushl $delim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	movl %eax, cuv
	
	pushl cuv
	call atoi
	popl %ebx
	
	movl %eax, m
	
nrel:
	xorl %ecx, %ecx
	xorl %edx, %edx
	movl m, %eax
	mull n
	movl %eax, mn
	
etfor1:
	cmp mn, %ecx
	je etfor2
	
	pushl %ecx
	
	pushl $delim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	movl %eax, cifra
	
	pushl cifra
	call atoi
	popl %ebx
	
	popl %ecx
	movl %eax, (%edi, %ecx, 4)
	incl %ecx
	jmp etfor1
	
etfor2:
	pushl $delim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx

	cmp $0, %eax
	je afisare
	
	movl %eax, cifra
	
	pushl cifra
	call atoi
	popl %ebx

	cmp $0, %eax
	je verif1
	pushl %eax
	
	jmp etfor2
		
verif1:
	pushl cifra
	call strlen
	popl %ebx

	cmp $1, %eax
	jg operatie
	jmp verif2

verif2:
	xorl %ecx, %ecx
	movl cifra, %esi
	movb (%esi, %ecx, 1), %al
	
	cmp $48, %eax
	je etzero
	jmp etfor2
	
etzero:
	pushl $0
	jmp etfor2
	
operatie:	
	xorl %ecx, %ecx
	movl cifra, %esi
	movb (%esi, %ecx, 1), %al

	cmp $97, %al
	je add
	cmp $100, %al
	je div
	cmp $109, %al
	je mul
	cmp $115, %al
	je sub
	cmp $114, %al
	je rot
	
	jmp etfor2
	
add:
	popl %eax
	movl %eax, op
	xorl %ebx, %ebx
	
miniforadd:
	cmp mn, %ebx
	je etfor2
	movl (%edi, %ebx, 4), %eax
	add op, %eax
	movl %eax, (%edi, %ebx, 4)
	incl %ebx
	jmp miniforadd
	
rot:
	lea v2, %esi
	xorl %ebx, %ebx
	xorl %ecx, %ecx

miniforrot:
	movl i, %eax
	cmp n, %eax
	je afis
	
	movl j, %ebx
	movl (%edi, %ecx, 4), %eax
	movl %eax, vij
	
	movl n, %eax
	subl i, %eax
	subl $1, %eax
	movl %eax, %ebx
	xorl %edx, %edx
	movl j, %eax
	mull n
	add %ebx, %eax
	
	movl vij, %edx
	movl %edx, (%esi, %eax, 4)

	movl m, %eax
	sub $1, %eax
	movl j, %ebx
	cmp %ebx, %eax
	je etjzero
	add $1, %ebx
	movl %ebx, j
	incl %ecx
	jmp miniforrot
	
etjzero:
	movl $0, %ebx
	movl %ebx, j
	movl i, %ebx
	addl $1, %ebx
	movl %ebx, i
	incl %ecx
	jmp miniforrot	
	
afis:
	lea v2, %edi
	
	movl n, %eax
	movl m, %ebx
	movl %ebx, n
	movl %eax, m
	jmp afisare
	
div:
	popl %eax
	movl %eax, op
	xorl %ebx, %ebx
	
minifordiv:
	xorl %edx, %edx
	cmp mn, %ebx
	je etfor2
	movl (%edi, %ebx, 4), %eax
	cmp $0, %eax
	jl verif3
	idivl op
	movl %eax, (%edi, %ebx, 4)
	incl %ebx
	jmp minifordiv
	
verif3:
	movl %eax, numarator
	movl op, %eax
	cmp $0, %eax
	jl pozitiv
	jmp inversare
	
pozitiv:
	pushl op
	xorl %edx, %edx
	movl $-1, %eax
	imull op
	movl %eax, op
	
	xorl %edx, %edx
	movl $-1, %eax
	imull numarator
	
	idivl op
	movl %eax, (%edi, %ebx, 4)
	incl %ebx
	popl op
	jmp minifordiv
	
inversare:
	// sgn(op) --> sgn(numarator)
	// sgn(numarator) --> sgn(op)
	pushl op
	xorl %edx, %edx
	movl $-1, %eax
	imull op
	movl %eax, op
	
	xorl %edx, %edx
	movl $-1, %eax
	imull numarator
	movl %eax, numarator
		
	xorl %edx, %edx
	idivl op
	movl %eax, (%edi, %ebx, 4)
	incl %ebx
	popl op
	jmp minifordiv
	
mul:
	popl %eax
	movl %eax, op
	xorl %ebx, %ebx

miniformul:
	xorl %edx, %edx
	cmp mn, %ebx
	je etfor2
	movl (%edi, %ebx, 4), %eax
	mull op
	movl %eax, (%edi, %ebx, 4)
	incl %ebx
	jmp miniformul
	
sub:		
	popl %eax
	movl %eax, op
	xorl %ebx, %ebx
	
miniforsub:
	cmp mn, %ebx
	je etfor2
	movl (%edi, %ebx, 4), %eax
	sub op, %eax
	movl %eax, (%edi, %ebx, 4)
	incl %ebx
	jmp miniforsub
	
afisare:
	pushl n
	pushl $formatprintfnr
	call printf
	popl %ebx
	popl %ebx
	
	pushl m
	pushl $formatprintfnr
	call printf
	popl %ebx
	popl %ebx
	
	xorl %ecx, %ecx
	
afisarev:
	cmp mn, %ecx
	je exit
	movl (%edi, %ecx, 4), %edx
	movl %edx, nr
	
	pushl %ecx
	pushl nr
	pushl $formatprintfnr
	call printf
	popl %ebx
	popl %ebx
	popl %ecx
	
	incl %ecx
	jmp afisarev
	
exit:
	pushl $0
	call fflush
	popl %ebx	
	
	pushl $null
	pushl $formatprintfch
	call printf
	popl %ebx
	popl %ebx
	
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80

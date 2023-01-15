.data
	formatScanf: .asciz "%s"
	formatPrintfnumere: .asciz "%d "
	formatPrintfsiruri: .asciz "%s "
	formatminus: .asciz "%s"
	
	null: .asciz "\n"
	let: .asciz "let"
	div: .asciz "div"
	mul: .asciz "mul"
	add: .asciz "add"
	sub: .asciz "sub"
	minus: .asciz "-"
	
	sir1: .space 101
	ch1: .space 20
	ch2: .space 20
.text
.global main
main:
	pushl $sir1
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	xorl %eax, %eax
	xorl %ebx, %ebx
	xorl %ecx, %ecx
	movl $sir1, %edi
	
etfor:
	movb (%edi, %ecx, 1), %al
	cmp $0, %al
	je exit
	cmp $56, %al
	je numarp
	cmp $57, %al
	je numarn
	cmp $65, %al
	je variabila
	cmp $67, %al
	je operatie
	
incrementare:
	incl %ecx
	xorl %eax, %eax
	xorl %ebx, %ebx
	jmp etfor
	
numarp:
	incl %ecx
	movb (%edi, %ecx, 1), %bl
	subb $48, %bl
	
	cmp $9, %bl
	jg etch1
	
cont1:
	movl %ebx, ch1
	movl $16, %eax
	xorl %edx, %edx
	mull ch1
	
	incl %ecx
	movb (%edi, %ecx, 1), %bl
	subb $48, %bl
	
	cmp $9, %bl
	jg etch2
	
cont2:
	addl %ebx, %eax
	movl %eax, ch1
	
	pushl %ecx
	
	pushl ch1
	pushl $formatPrintfnumere
	call printf
	popl %ebx
	popl %ebx
	
	popl %ecx
	
	jmp incrementare
	
etch1:
	subb $7, %bl
	jmp cont1
	
etch2:
	subb $7, %bl
	jmp cont2
	
numarn:
	incl %ecx
	movb (%edi, %ecx, 1), %bl
	subb $48, %bl
	
	cmp $9, %bl
	jg etch3

cont3:
	movl %ebx, ch1
	movl $16, %eax
	xorl %edx, %edx
	mull ch1
	
	incl %ecx
	movb (%edi, %ecx, 1), %bl
	subb $48, %bl
	
	cmp $9, %bl
	jg etch4
	
cont4:
	addl %ebx, %eax
	movl %eax, ch1
	
	pushl %ecx
	
	pushl $minus
	pushl $formatminus
	call printf
	popl %ebx
	popl %ebx
	
	pushl ch1
	pushl $formatPrintfnumere
	call printf
	popl %ebx
	popl %ebx
	
	popl %ecx
	
	jmp incrementare

etch3:
	subb $7, %bl
	jmp cont3
	
etch4:
	subb $7, %bl
	jmp cont4

variabila:
	incl %ecx
	movb (%edi, %ecx, 1), %bl
	subb $48, %bl
	
	cmp $9, %bl
	jg etch5
	
cont5:
	movl %ebx, ch1
	movl $16, %eax
	xorl %edx, %edx
	mull ch1
	
	incl %ecx
	movb (%edi, %ecx, 1), %bl
	subb $48, %bl
	
	cmp $9, %bl
	jg etch6
	
cont6:
	addl %ebx, %eax
	movl %eax, ch1
	
	pushl %ecx
	
	pushl $ch1
	pushl $formatPrintfsiruri
	call printf
	popl %ebx
	popl %ebx
	
	popl %ecx
	
	jmp incrementare
	
etch5:
	subb $7, %bl
	jmp cont5
	
etch6:
	subb $7, %bl
	jmp cont6
	
operatie:
	addl $2, %ecx
	movb (%edi, %ecx, 1), %al
	cmp $48, %al
	je etlet
	cmp $49, %al
	je etadd
	cmp $50, %al
	je etsub
	cmp $51, %al
	je etmul
	cmp $52, %al
	je etdiv
	
etlet:
	pushl %eax
	pushl %ecx
	
	pushl $let
	pushl $formatPrintfsiruri
	call printf
	popl %ebx
	popl %ebx
	
	popl %ecx
	popl %eax
	
	jmp incrementare
	
etadd:
	pushl %eax
	pushl %ecx
	
	pushl $add
	pushl $formatPrintfsiruri
	call printf
	popl %ebx
	popl %ebx
	
	popl %ecx
	popl %eax
	
	jmp incrementare
	
etsub:
	pushl %eax
	pushl %ecx
	
	pushl $sub
	pushl $formatPrintfsiruri
	call printf
	popl %ebx
	popl %ebx
	
	popl %ecx
	popl %eax
	
	jmp incrementare
	
etmul:
	pushl %eax
	pushl %ecx
	
	pushl $mul
	pushl $formatPrintfsiruri
	call printf
	popl %ebx
	popl %ebx
	
	popl %ecx
	popl %eax
	
	jmp incrementare
	
etdiv:
	pushl %eax
	pushl %ecx
	
	pushl $div
	pushl $formatPrintfsiruri
	call printf
	popl %ebx
	popl %ebx
	
	popl %ecx
	popl %eax
	
	jmp incrementare
	
exit:	
	pushl $0
	call fflush
	popl %ebx
	
	pushl $null
	pushl $formatPrintfsiruri
	call printf
	popl %ebx
	popl %ebx
		
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80

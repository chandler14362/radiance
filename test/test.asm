%include 'util.inc'
%include 'lib.inc'
%include 'type.inc'

entrypoint main

cextern printf

section .data
	msg byte_st "test", 10, 0

section .text
main:
	sub esp, 12
	mov dword[esp], msg
	call printf
	add esp, 12
	ret

%include 'common.inc'

cextern printf
extern tick

entrypoint main

section .data
	msg byte_st "test", 10, 0

section .text
main:
	sub esp, 12
	call tick
	add esp, 12
	jmp main
	ret

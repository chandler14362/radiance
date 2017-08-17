%include 'type.inc'

global radiance.strcmp

section .text
radiance.strcmp:
    prologue 16
    mov edi, [ebp + 8] ; str 1 ptr
    mov esi, [ebp + 12] ; str 2 ptr
    xor ecx, ecx

.compare:
    mov ah, byte_t [edi + ecx]
    mov al, byte_t [esi + ecx]
    inc ecx

    cmp ah, al
    je .checkend
    
    cmp ah, byte_t 0
    je .endless
    cmp al,  byte_t 0
    je .endgreater

.endless:
    mov eax, -1
    jmp .end

.endgreater:
    mov eax, 1
    jmp .end

.checkend:
    cmp eax, 0
    jne .compare

.end: 
    epilogue 16

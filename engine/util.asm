%include 'type.inc'

global radiance.strcmp

section .text

; RADIANCE.STRCMP
; compares two null terminated strings 
radiance.strcmp:
    prologue 16

    push edi
    push esi
    push ebx

    mov edi, [ebp + 8] ; str a ptr
    mov esi, [ebp + 12] ; str b ptr
    xor ecx, ecx

.compare:
    mov eax, int32_t [edi + ecx]
    mov ebx, int32_t [esi + ecx]
    inc ecx

    cmp al, bl
    jne .failure

    cmp al, 0
    je .success

    cmp ah, bh
    jne .failure

    cmp ah, 0
    je .success

    jmp .compare ; loop again

.failure:
    mov eax, -1
    jmp .end

.success:
    mov eax, 0
    jmp .end

.end: 
    pop ebx
    pop esi
    pop edi

    epilogue 16

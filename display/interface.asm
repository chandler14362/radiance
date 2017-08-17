%include '../engine/type.inc'
%include '../display/display.inc'

%assign display_count 0

%macro apidef 1
    .display_%1:
%endmacro

%macro apidefnext 1
    %undef next_option
    %define next_option .display_%1
%endmacro

%macro .display_option 1
    %assign display_count display_count + 1
    
    apidef display_count
    apidefnext display_count + 1
%endmacro

global radiance.display.init
cextern printf

section .data
    msg byte_st "display type: %d", 10, 0

section .text
radiance.display.init:
    prologue 16

    mov esi, pointer_t [ebp + 8] ; display config
    mov dh, byte_t [esi + RadianceDisplay.type] ; get the display type
    
    mov pointer_t [esp], msg
    mov byte_t [esp + 4], dh
    call printf

%ifdef WANT_SDL
.display_option:
    ; check against the display type
    cmp dh, SDL2_DISPLAY
    jne next_option

    mov edi, pointer_t [esi + RadianceDisplay.title]
    mov pointer_t [esp], edi
    call printf
    
    mov eax, 1
    jmp .end
%endif

.display_option: ; label reached if the display type wasn't able to be identified
    mov eax, 0 ; return code 0 - error

.end:
    epilogue 16

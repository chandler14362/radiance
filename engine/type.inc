%ifndef __RADIANCE_TYPE__
%define __RADIANCE_TYPE__

%xdefine byte_st db
%xdefine int16_st dw
%xdefine uint16_st dw
%xdefine int32_st dd
%xdefine uint32_st dd

%xdefine byte_t byte
%xdefine int16_t word
%xdefine uint16_t word
%xdefine int32_t dword
%xdefine uint32_t dword

%xdefine pointer_t dword
%xdefine reg_t dword

%xdefine byte_rt resb
%xdefine int16_rt resw
%xdefine uint16_rt resw
%xdefine int32_rt resd
%xdefine uint32_rt resd

%macro struct_rt 1-2 1
    resb %1.size * %2
%endmacro

%macro cextern 1
    extern _%1
    %xdefine %1 _%1
%endmacro 

; see http://www.nasm.us/doc/nasmdoc9.html#section-9.1.2
%macro prologue 1
    push    ebp 
    mov     ebp,esp 
    sub esp, %1
%endmacro

%macro epilogue 1
    add esp, %1
    leave ; mov esp,ebp / pop ebp 
    ret
%endmacro

%endif

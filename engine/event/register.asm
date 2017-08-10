%include '../../engine/type.inc'

%ifndef MAX_EVENTS
    %xdefine MAX_EVENTS 32
%endif

section .data:
    registered_events int32_t 0

section .bss:
    

section .text:

; registers a new event.
event.register:
    prologue 16


    epilogue 16


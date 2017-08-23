%include '../../engine/event/artifact.inc'
%include '../../engine/type.inc'

section .text

extern radiance.event.members
global radiance.event.dispatch

; dispatches an event
radiance.event.dispatch:
    prologue 16

    mov eax, [radiance.event.members + EventParticipant.sub]

    ; call with args
    mov edi, pointer_t [ebp + 8]
    mov pointer_t [esp], edi
    call eax

    epilogue 16

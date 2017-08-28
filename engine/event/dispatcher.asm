%include '../../engine/event/artifact.inc'
%include '../../engine/type.inc'

%ifndef MAX_EVENT_PARTICIPANTS
    %xdefine MAX_EVENT_PARTICIPANTS 50
%endif

section .text

extern radiance.event.members
extern radiance.event.find
global radiance.event.dispatch

; RADIANCE.EVENT.DISPATCH
; dispatches an event 
radiance.event.dispatch:
    prologue 16

    push esi
    push ebx
    push edi

    mov esi, [ebp + 8] ; name
    mov ebx, [ebp + 12] ; args

    ; get the event address.
    mov pointer_t [esp], esi
    call radiance.event.find

    cmp eax, -1 ; check to see if the event exists
    je .end

    mov esi, int32_t [eax + RadianceEvent.id] ; copy the id over

    ; iterate over all the members
    xor ecx, ecx ; participant ptr
    xor edi, edi ; loop count

    .cmploop:
        mov eax, [radiance.event.members + ecx + EventParticipant.id] ; check to see if the participant is listening for our event
        cmp eax, esi
        jne .inc_counters
        
        ; call with args
        mov eax, [radiance.event.members + EventParticipant.sub]
        mov pointer_t [esp], ebx
        call eax

    .inc_counters:
        add ecx, EventParticipant.size ; inc pointer
        inc edi

        cmp edi, MAX_EVENT_PARTICIPANTS ; check if we have processed all events
        je .end

        jmp .cmploop ; loop again

.end:
    pop edi
    pop ebx
    pop esi

    epilogue 16

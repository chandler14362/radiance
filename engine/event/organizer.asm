%include '../../engine/event/artifact.inc'
%include '../../engine/type.inc'

%ifndef MAX_EVENT_PARTICIPANTS
    %xdefine MAX_EVENT_PARTICIPANTS 50
%endif

extern radiance.event.find

global radiance.event.join
global radiance.event.leave
global radiance.event.members

section .data
    radiance.event.participant_cap: int32_st MAX_EVENT_PARTICIPANTS
    idcounter: int32_st 0

section .bss 
    radiance.event.members: struct_rt EventParticipant, MAX_EVENT_PARTICIPANTS

section .text

; RADIANCE.EVENT.JOIN
; subscribes a member to an event
radiance.event.join:
    prologue 16

    push esi
    push edi

    mov esi, pointer_t [ebp + 8] ; event name
    mov edi, pointer_t [ebp + 12] ; subroutine
    
    mov pointer_t [esp], esi ; find the event by name
    call radiance.event.find

    cmp eax, -1 ; did we find the event? if not, end the routine
    je .end

    mov esi, int32_t [eax + RadianceEvent.id] ; move the event id

    call get_available ; get an available participant address
    cmp eax, -1 ; availablity check
    je .end

    mov pointer_t [eax + EventParticipant.sub], edi ; move the subroutine
    mov int32_t [eax + EventParticipant.eventid], esi ; move the event id

    mov edi, idcounter ; get an id for ourselves
    inc int32_t [edi]

    mov esi, int32_t [edi] ; claim the participant and return its id
    mov int32_t [eax + EventParticipant.id], esi
    mov eax, esi

.end:
    pop edi
    push esi

    epilogue 16


; RADIANCE.EVENT.LEAVE - todo
; removes a participant from an event
radiance.event.leave:
    prologue 16
    epilogue 16


; GET_AVAILABLE
; gets an available participant address
; returns -1 if all addresses are occupied
get_available:
    prologue 16

    push edi

    xor ecx, ecx ; participant ptr
    xor edi, edi ; loop count

.cmploop:
    mov eax, [radiance.event.members + ecx + EventParticipant.id] ; check to see if the participant is unoccupied (id 0) 
    cmp eax, 0 
    je .found

    add ecx, EventParticipant.size ; inc pointer
    inc edi

    cmp edi, radiance.event.participant_cap ; check if we have processed all events
    je .failure

    jmp .cmploop ; loop again

.failure:
    mov eax, -1
    jmp .end

.found:
    lea eax, [radiance.event.members + ecx] ; address of the participant
    jmp .end

.end:
    pop edi
    epilogue 16

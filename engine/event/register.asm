%include '../../engine/event/artifact.inc'
%include '../../engine/type.inc'

%ifndef MAX_EVENTS
    %xdefine MAX_EVENTS 32
%endif

extern radiance.strcmp

global radiance.event.register
global radiance.event.remove
global radiance.event.find
global radiance.event.cap

section .data
    radiance.event.cap: int32_st MAX_EVENTS
    idcounter: int32_st 0

section .bss
    radiance.events: struct_rt RadianceEvent, MAX_EVENTS

section .text

; RADIANCE.EVENT.REGISTER
; creates a new event and assigns it an id
; returns the event id or -1 if the event couldn't be registered
radiance.event.register:
    prologue 16

    mov esi, pointer_t [ebp + 8] ; event name

    mov pointer_t [esp], esi ; check to see if an event with the name already exists
    call radiance.event.find

    cmp eax, -1 ; check to see if we are trying to register an event that already exists
    jne .failure

    mov edx, idcounter ; get a new id
    inc int32_t [edx]

    call get_available ; get an available address
    cmp eax, -1
    je .failure

    mov int32_t [eax + RadianceEvent.id], edx ; claim the event as our own

    ; copy the name to the event
    xor ecx, ecx
.copy:
    mov ebx, int32_t [esi + ecx] ; copy the data
    mov int32_t [eax + RadianceEvent.name + ecx], ebx

    ; check to see if we have reached the end of the string
    cmp bh, 0
    je .done
    cmp bl, 0
    je .done

    inc ecx ; inc and loop again
    jmp .copy

.done:
    mov eax, int32_t [edx] ; ret the event id
    jmp .end

.failure:
    mov eax, -1
    jmp .end

.end:
    epilogue 16


; RADIANCE.EVENT.REMOVE - todo
; removes an event from the list of events
radiance.event.remove:
    prologue 16

    mov esi, pointer_t [ebp + 8] ; event name

    epilogue 16


; RADIANCE.EVENT.FIND
; gets the address of an event by name
radiance.event.find:
    prologue 16

    mov esi, pointer_t [ebp + 8] ; event name
    
    xor ecx, ecx ; event list index
    xor edi, edi ; loop count

.cmploop:
    mov eax, [radiance.events + ecx + RadianceEvent.id] ; check to see if the event is occupied (id 0) 
    cmp eax, 0 
    je .clnext

    mov pointer_t [esp], esi ; compare event names 
    mov eax, [radiance.events + ecx + RadianceEvent.name]
    mov pointer_t [esp + 4], eax
    call radiance.strcmp

    cmp eax, 0 ; check if we have a match
    je .found

.clnext:
    add ecx, RadianceEvent.size ; inc pointer
    inc edi 

    cmp edi, MAX_EVENTS ; check if we have processed all events
    jge .failure

    jmp .cmploop ; loop again

.failure:
    mov eax, -1
    jmp .end

.found:
    mov eax, [radiance.events + ecx] ; address of the event
    jmp .end

.end:
    epilogue 16


; GET_AVAILABLE
; gets an available event address
; returns -1 if all addresses are occupied
get_available:
    prologue 16

    xor ecx, ecx ; event ptr
    xor edi, edi ; loop count

.cmploop:
    mov eax, [radiance.events + ecx + RadianceEvent.id] ; check to see if the event is unoccupied (id 0) 
    cmp eax, 0 
    je .found

    add ecx, RadianceEvent.size ; inc pointer
    inc edi

    cmp edi, radiance.event.cap ; check if we have processed all events
    je .failure

    jmp .cmploop ; loop again

.failure:
    mov eax, -1
    jmp .end

.found:
    lea eax, [radiance.events + ecx] ; address of the event
    jmp .end

.end:
    epilogue 16

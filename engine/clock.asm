%include 'type.inc'

cextern printf
cextern time

global clock.tick

[section .data]
    msg byte_st "tick: %d", 10, 0
    tick_counter uint32_st 0
    frontal_time uint32_st 0

[section .text]
clock.tick:
    sub esp, 12
    call _do_tick
    mov pointer_t [esp], msg
    mov reg_t [esp + 4], eax
	call printf
    add esp, 12
    ret

_do_tick:
    ;reg_assign esi, tick_counter ; store tick_counter
    ;reg_assign edi, frontal_time ; store frontal_tick

    sub esp, 12 ; realign the stack
    mov pointer_t [esp], 0 ; set esp to null (the time function is the only function called inside this routine)

    ;cmp tick_counter, 0 ; skip to .inc if we aren't the frontal tick
    jne .inc

    call time ; get the current time and set it as the frontal time
    ;mov frontal_time, eax

    .inc:
        ;inc tick_counter ; increment the current tick
        ;cmp tick_counter, 61 ; go to the end of the function if the tick isn't above the limit
        jne .end

    ;mov tick_counter, 0 ; reset the tick counter to 0

    .wait: ; wait till a full second has passed since the frontal tick
        call time
        sub eax, frontal_time
        
        cmp eax, 1 ; skip to the end of a second has passed
        jge .end
        
        jmp .wait ; try again

    .end:
        mov eax, tick_counter ; return the current tick
        add esp, 12 ; realign the stack
        ret

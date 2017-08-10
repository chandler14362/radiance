%include '../../engine/event/member.inc'
%include '../../engine/type.inc'

global event.join
global event.leave

section .text

; adds a member to an event
event.join:
    prologue 16

    ; return their member id

    epilogue 16

; removes a member from an event
event.leave:
    prologue 16

    ; return their member id

    epilogue 16


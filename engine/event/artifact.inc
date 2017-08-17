%ifndef __RADIANCE_EVENT_ARTIFACT__
%define __RADIANCE_EVENT_ARTIFACT__

%include '../engine/type.inc'

struc EventParticipant
.id: int32_rt 1 ; id of the participant (assigned by the organizer)
.eventid: int32_rt 1 ; id of the event the participant is listening to
.sub: int32_rt 1 ; address of the subroutine to call
.size:
endstruc

struc RadianceEvent                
.id: int32_rt 1 ; id of the event (assigned by the register)
.name: byte_rt 255 ; name of the event
.size:
endstruc

%endif

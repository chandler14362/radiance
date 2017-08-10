%ifndef __RADIANCE_EVENT_MEMBER__
%define __RADIANCE_EVENT_MEMBER__

%include '../../engine/type.inc'

struc EventMember                
.name: int32_rt 1 ; pointer to the event name 
.sub: int32_rt 1 ; address of the subroutine to call
.size:
endstruc

%endif

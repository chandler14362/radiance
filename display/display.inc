%ifndef __RADIANCE_DISPLAY__
%define __RADIANCE_DISPLAY__

%include '../engine/type.inc'

%xdefine UNKNOWN_DISPLAY 0
%xdefine SDL2_DISPLAY 1

struc RadianceDisplay
.type: byte_rt 1
.title: int32_rt 1
.width: int32_rt 1
.height: int32_rt 1
.x: int32_rt 1
.y: int32_rt 1
.size:
endstruc

%endif

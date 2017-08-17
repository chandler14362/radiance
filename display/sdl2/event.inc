%ifndef __RADIANCE_SDL2_EVENT__
%define __RADIANCE_SDL2_EVENT__

%include '../../engine/type.inc'

%xdefine SDL_QUIT 0x100
%xdefine SDL_KEYDOWN 0x300

struc SDL_Event                 
.data: byte_rt 255
.size:
endstruc

%endif

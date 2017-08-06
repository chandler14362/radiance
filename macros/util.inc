%ifndef __RADIANCE_UTIL__
%define __RADIANCE_UTIL__

%macro entrypoint 1
	%xdefine %1 _%1
	global %1
%endmacro

%macro reg_assign 1-2
	mov %1, %2
    %define %2 dword [%1]
%endmacro

%endif

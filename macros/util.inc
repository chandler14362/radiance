%ifndef __RADIANCE_UTIL__
%define __RADIANCE_UTIL__

%macro entrypoint 1
	%define %1 _%1
	global %1
%endmacro

%endif

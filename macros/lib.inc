%ifndef __RADIANCE_LIB__
%define __RADIANCE_LIB__

%macro cextern 1
	extern _%1
	%xdefine %1 _%1
%endmacro

%macro rmodule 1
	%xdefine rmodule_name radiance.%1
%endmacro

%macro rmoduleproc 1
	;%defstr ns radiance. %+ rmodule_name
	global %1
%endmacro

%macro rextern 1-2
	extern %2
	%define %1.%2 %2
%endmacro

%endif
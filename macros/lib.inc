%ifndef __RADIANCE_LIB__
%define __RADIANCE_LIB__

%macro cextern 1
	extern _%1
	%idefine %1 _%1
%endmacro

%endif

install_macros(display
    display.inc
)

set(DISPLAY_SOURCES 
    interface.asm
)

add_nasm_includes()
create_radiance_module(display radiance.display "${DISPLAY_SOURCES}")

if(WANT_SDL2)
    add_subdirectory(sdl2 sdl2)
endif()

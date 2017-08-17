 add_compile_options(-dWANT_SDL=1)

install_macros(display/sdl2
    constants.inc
    event.inc
)

set(SDL2_SOURCES 
    display.asm
    event.asm
)

add_nasm_includes()
add_display_object(display.sdl2 "${SDL2_SOURCES}")

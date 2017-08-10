install_macros(engine
    type.inc
)

set(ENGINE_SOURCES 
    clock.asm
)

add_nasm_includes()
create_radiance_module(engine radiance.engine ${ENGINE_SOURCES})

add_subdirectory(draw draw)
add_subdirectory(event event)

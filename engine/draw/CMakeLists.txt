install_macros(engine/draw
    tile.inc
)

set(DRAW_SOURCES 
    tile.asm
)

add_nasm_includes()
add_engine_object(engine.draw "${EVENT_SOURCES}")

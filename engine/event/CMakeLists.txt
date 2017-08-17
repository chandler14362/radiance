install_macros(engine/event
    artifact.inc
    types.inc
)

set(EVENT_SOURCES 
    dispatcher.asm
    organizer.asm
    register.asm
)

add_nasm_includes()
add_engine_object(engine.event "${EVENT_SOURCES}")

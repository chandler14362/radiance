cmake_minimum_required(VERSION 3.0.2)

macro(CREATE_LIBRARY lalias lname ltype lsources)
    # create the library
    add_library(${lname} ${ltype} ${lsources})

    # create macro for creating modules
    macro(CREATE_${lalias}_MODULE malias mname msources)  
        # add the new module to the library
        add_library(${mname} OBJECT ${msources})
        add_dependencies(${lname} ${mname})
        target_sources(${lname} PRIVATE $<TARGET_OBJECTS:${mname}>)

        # create macro for adding objects to the module
        macro(ADD_${malias}_OBJECT oname osources)
            # create a new library for the object
            add_library(${oname} OBJECT ${osources})
            add_dependencies(${oname} ${mname})

            # add the new object to the library
            target_sources(${lname} PRIVATE $<TARGET_OBJECTS:${oname}>)
        endmacro()
    endmacro()
endmacro()

macro(ADD_NASM_INCLUDES)
    add_compile_options(-I${CMAKE_CURRENT_SOURCE_DIR}/ -I${PROJECT_SOURCE_DIR}/)
endmacro()

macro(INSTALL_MACROS macro_path macro_list)
    install(FILES ${macro_list} DESTINATION include/radiance/${macro_path})
endmacro()

project(RADIANCE)

set(CMAKE_ASM_NASM_OBJECT_FORMAT macho)
set(CMAKE_ASM_NASM_COMPILER /usr/local/Cellar/nasm/2.13.01/bin/nasm)
enable_language(ASM_NASM)

# SDL2 display
option(WANT_SDL2 "Build with SDL2 support." NO)

set(LIBRADIANCE radiance)

set(RADIANCE_SOURCES
    radiance.asm
)

add_nasm_includes()
add_compile_options(-dradiance_version="0.0.1")
create_library(radiance ${LIBRADIANCE} STATIC ${RADIANCE_SOURCES})

add_subdirectory(engine engine)
add_subdirectory(display display)

install(TARGETS ${LIBRADIANCE} ARCHIVE DESTINATION lib)

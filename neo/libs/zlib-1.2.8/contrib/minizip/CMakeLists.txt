cmake_minimum_required ( VERSION 2.8.11 )
project ( minizip C )
set(VERSION "")

if ( APPLE )
    set ( CMAKE_MACOSX_RPATH OFF )
    set (
        CMAKE_MODULE_LINKER_FLAGS
        "${CMAKE_MODULE_LINKER_FLAGS} -undefined dynamic_lookup"
    )
endif ( APPLE )

if (WIN32 OR MINGW)
    set (IOWIN32 iowin32.c iowin32.h)
endif(WIN32 OR MINGW)


add_library (
    minizip STATIC 
    crypt.h
    ioapi.c
    ioapi.h
    ${IOWIN32}
    miniunz.c
    minizip.c
    mztools.c
    mztools.h
    unzip.c
    unzip.h
    zip.c
    zip.h
)

target_link_libraries( minizip zlib )
include_directories(
    ${CMAKE_CURRENT_BINARY_DIR}/../..
    )

message(STATUS "zconf.h :-> ${ZLIB_PUBLIC_HDRS}")

#target_include_directories (
#    minizip PUBLIC
#    ${ZLIB_PUBLIC_HDRS}
#)
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c11" )

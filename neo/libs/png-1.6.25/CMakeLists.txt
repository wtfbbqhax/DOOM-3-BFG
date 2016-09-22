cmake_minimum_required ( VERSION 2.8.11 )
project ( png-1.6.25 C )
set(VERSION "1.6.25")

if ( APPLE )
    set ( CMAKE_MACOSX_RPATH OFF )
    set (
        CMAKE_MODULE_LINKER_FLAGS
        "${CMAKE_MODULE_LINKER_FLAGS} -undefined dynamic_lookup"
    )
endif ( APPLE )

add_library (
    png-1.6.25 STATIC 
    #example.c
    png.c
    png.h #TODO install
    pngconf.h
    pngdebug.h
    pngerror.c
    pngget.c
    pnginfo.h
    pngmem.c
    pngpread.c
    pngpriv.h
    pngread.c
    pngrio.c
    pngrtran.c
    pngrutil.c
    pngset.c
    pngstruct.h
    pngtrans.c
    pngwio.c
    pngwrite.c
    pngwtran.c
    pngwutil.c
)

target_link_libraries( png-1.6.25 zlib-1.2.8 )

add_executable(
    pngtest
    pngtest.c png.h pngconf.h
    )

target_link_libraries( pngtest png-1.6.25 )

set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c11" )


cmake_minimum_required ( VERSION 2.8.11 )
project ( zlib-1.2.8 C )
set(VERSION "1.2.8")

if ( APPLE )
    set ( CMAKE_MACOSX_RPATH OFF )
    set (
        CMAKE_MODULE_LINKER_FLAGS
        "${CMAKE_MODULE_LINKER_FLAGS} -undefined dynamic_lookup"
    )
endif ( APPLE )

# idTech4 requires this

include(CheckTypeSize)
include(CheckFunctionExists)
include(CheckIncludeFile)

check_function_exists(fseeko HAVE_FSEEKO)
if(NOT HAVE_FSEEKO)
    add_definitions(-DNO_FSEEKO)
endif()

check_include_file(unistd.h Z_HAVE_UNISTD_H)

configure_file( 
    ${CMAKE_CURRENT_SOURCE_DIR}/zconf.h.cmakein
    #    ${CMAKE_CURRENT_BINARY_DIR}/zconf.h @ONLY) FIXME
    ${CMAKE_CURRENT_SOURCE_DIR}/zconf.h @ONLY)

include_directories(
    ${CMAKE_CURRENT_BINARY_DIR}
    ${CMAKE_SOURCE_DIR})

set(ZLIB_PUBLIC_HDRS
    #${CMAKE_CURRENT_BINARY_DIR}/zconf.h FIXME
    zconf.h
    zlib.h
)

set(ZLIB_PRIVATE_HDRS
    crc32.h
    deflate.h
    gzguts.h
    inffast.h
    inffixed.h
    inflate.h
    inftrees.h
    trees.h
    zutil.h
)
set(ZLIB_SRCS
    adler32.c
    compress.c
    crc32.c
    deflate.c
    gzclose.c
    gzlib.c
    gzread.c
    gzwrite.c
    inflate.c
    infback.c
    inftrees.c
    inffast.c
    trees.c
    uncompr.c
    zutil.c
)

if(CMAKE_COMPILER_IS_GNUCC)
    if(ASM686)
        set(ZLIB_ASMS contrib/asm686/match.S)
    elseif (AMD64)
        set(ZLIB_ASMS contrib/amd64/amd64-match.S)
    endif ()

    if(ZLIB_ASMS)
        add_definitions(-DASMV)
        set_source_files_properties(
            ${ZLIB_ASMS} PROPERTIES 
            LANGUAGE C COMPILE_FLAGS -DNO_UNDERLINE)
    endif()
endif()

if(MSVC)
    if(ASM686)
        ENABLE_LANGUAGE(ASM_MASM)
        set(ZLIB_ASMS
            contrib/masmx86/inffas32.asm
            contrib/masmx86/match686.asm
            )
    elseif (AMD64)
        ENABLE_LANGUAGE(ASM_MASM)
        set(ZLIB_ASMS
            contrib/masmx64/gvmat64.asm
            contrib/masmx64/inffasx64.asm
            )
    endif()

    if(ZLIB_ASMS)
        add_definitions(-DASMV -DASMINF)
    endif()
endif()

# parse the full version number from zlib.h and include in ZLIB_FULL_VERSION
file(READ ${CMAKE_CURRENT_SOURCE_DIR}/zlib.h _zlib_h_contents)
string(REGEX REPLACE
    ".*#define[ \t]+ZLIB_VERSION[ \t]+\"([-0-9A-Za-z.]+)\".*"
    "\\1"
    ZLIB_FULL_VERSION
    ${_zlib_h_contents})

add_library(
    zlib-1.2.8
    STATIC
    ${ZLIB_SRCS}
    ${ZLIB_ASMS}
    ${ZLIB_PUBLIC_HDRS}
    ${ZLIB_PRIVATE_HDRS}
)
add_definitions(-D_LARGEFILE64_SOURCE=1)

set(ZLIB_HEADERS ${CMAKE_CURRENT_SOURCE_DIR})
add_subdirectory(minizip)

set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c11" )

cmake_minimum_required ( VERSION 2.8.11 )
project ( cm CXX )

if ( APPLE )
    set ( CMAKE_MACOSX_RPATH OFF )
    set (
        CMAKE_SHARED_LINKER_FLAGS
        "${CMAKE_SHARED_LINKER_FLAGS} -undefined dynamic_lookup"
    )
endif ( APPLE )

include ( FindPkgConfig )
#Do this if user wants to build against system packages
#pkg_search_module ( SDL2 REQUIRED SDL2>=2.0.3 )
#pkg_search_module ( JPEG REQUIRED)
#pkg_search_module ( PNG REQUIRED )
#pkg_search_module ( FREETYPE REQUIRED )
#pkg_search_module ( OPENAL REQUIRED )
#pkg_search_module ( OPENGL REQUIRED )

add_library (
    cm SHARED
    CollisionModel.h
    CollisionModel_contacts.cpp
    CollisionModel_contents.cpp
    CollisionModel_debug.cpp
    CollisionModel_files.cpp
    CollisionModel_load.cpp
    CollisionModel_local.h
    CollisionModel_rotate.cpp
    CollisionModel_trace.cpp
    CollisionModel_translate.cpp
)

set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11" )

target_include_directories (
    cm PUBLIC
    ${IDTECH4_INCLUDE_DIRS}
)

#install (
#    TARGETS cm
#    LIBRARY DESTINATION "lib/${CMAKE_PROJECT_NAME}/neo"
#)

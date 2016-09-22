cmake_minimum_required ( VERSION 2.8.11 )
project ( aas CXX )

if ( APPLE )
    set ( CMAKE_MACOSX_RPATH OFF )
    set (
        CMAKE_SHARED_LINKER_FLAGS
        "${CMAKE_SHARED_LINKER_FLAGS} -undefined dynamic_lookup"
    )
endif ( APPLE )

add_library (
    aas SHARED
    AASFile.cpp
    AASFile.h
    AASFileManager.cpp
    AASFileManager.h
    AASFile_local.h
    AASFile_optimize.cpp
    AASFile_sample.cpp
)

set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11" )

target_include_directories (
    aas PUBLIC
    ${IDTECH4_INCLUDE_DIRS}
)

#install (
#    TARGETS aas
#    LIBRARY DESTINATION "lib/${CMAKE_PROJECT_NAME}/neo"
#)
